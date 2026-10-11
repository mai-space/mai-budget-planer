package space.mai.mai_budget_planer.wear

import android.app.PendingIntent
import android.content.Intent
import androidx.wear.watchface.complications.data.ComplicationData
import androidx.wear.watchface.complications.data.ComplicationType
import androidx.wear.watchface.complications.data.LongTextComplicationData
import androidx.wear.watchface.complications.data.PlainComplicationText
import androidx.wear.watchface.complications.data.ShortTextComplicationData
import androidx.wear.watchface.complications.datasource.ComplicationDataSourceService
import androidx.wear.watchface.complications.datasource.ComplicationDataSourceService.ComplicationRequestListener
import androidx.wear.watchface.complications.datasource.ComplicationRequest
import space.mai.mai_budget_planer.widget.WidgetPayload
import java.text.DateFormatSymbols
import java.util.Locale

/**
 * Gemeinsame Basis der Komplikationen: kurzer und langer Text aus dem
 * gespeicherten Stand; Tipp öffnet die Uhr-App.
 */
abstract class BudgetComplicationService : ComplicationDataSourceService() {
    /** Kurzer Text (≤ 7 Zeichen sinnvoll), optional Titel, langer Text. */
    protected class Texts(val short: String, val title: String?, val long: String)

    protected abstract fun texts(payload: WidgetPayload?): Texts

    override fun onComplicationRequest(request: ComplicationRequest, listener: ComplicationRequestListener) {
        listener.onComplicationData(build(request.complicationType, texts(WatchStore.payload(this))))
    }

    override fun getPreviewData(type: ComplicationType): ComplicationData? =
        build(type, preview())

    /** Vorschau in der Zifferblatt-Auswahl, ohne echte Daten. */
    protected abstract fun preview(): Texts

    override fun onComplicationActivated(complicationInstanceId: Int, type: ComplicationType) {
        PhoneLink.refresh(this)
    }

    private fun build(type: ComplicationType, texts: Texts): ComplicationData? {
        val tap = PendingIntent.getActivity(
            this,
            0,
            Intent(this, WatchActivity::class.java).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK),
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
        )
        return when (type) {
            ComplicationType.SHORT_TEXT -> ShortTextComplicationData.Builder(plain(texts.short), plain(texts.long))
                .apply { texts.title?.let { setTitle(plain(it)) } }
                .setTapAction(tap)
                .build()
            ComplicationType.LONG_TEXT -> LongTextComplicationData.Builder(plain(texts.long), plain(texts.long))
                .apply { texts.title?.let { setTitle(plain(it)) } }
                .setTapAction(tap)
                .build()
            else -> null
        }
    }

    private fun plain(text: String) = PlainComplicationText.Builder(text).build()
}

/** „Frei verfügbar“ als Betrag. */
class FreeComplicationService : BudgetComplicationService() {
    override fun texts(payload: WidgetPayload?): Texts {
        val title = getString(R.string.free_short)
        if (payload == null || !payload.hasData) return Texts("–", title, getString(R.string.no_data))
        val amount = payload.free ?: getString(R.string.hidden)
        return Texts(amount, title, "${getString(R.string.free_per_month)}: $amount")
    }

    override fun preview() = Texts("420 €", getString(R.string.free_short), "${getString(R.string.free_per_month)}: 420 €")
}

/** Nächste Jahres-/Quartalszahlung: Monat kurz, lang mit Posten und Betrag. */
class NextPaymentComplicationService : BudgetComplicationService() {
    override fun texts(payload: WidgetPayload?): Texts {
        if (payload == null) return Texts("–", null, getString(R.string.no_data))
        val next = payload.dueList().firstOrNull()
            ?: return Texts("–", null, getString(R.string.no_upcoming))
        return Texts(
            next.whenText(this, short = true),
            next.item.label,
            "${next.item.label} · ${next.whenText(this)} · ${next.amount(this)}",
        )
    }

    override fun preview(): Texts {
        val symbols = DateFormatSymbols.getInstance(Locale.getDefault())
        val label = getString(R.string.preview_label)
        return Texts(symbols.shortMonths[9], label, "$label · ${symbols.months[9]} · 450 €")
    }
}
