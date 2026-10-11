package space.mai.mai_budget_planer.widget

import android.content.Context

/**
 * Daten der Startbildschirm-Widgets, von der App fertig aufbereitet
 * (siehe `lib/services/home_widgets.dart`). Liegt in `SharedPreferences`
 * im privaten App-Verzeichnis; Android-Backup ist für die App aus. Mit
 * „Beträge ausblenden“ schickt die App gar keine Beträge mit.
 */
object WidgetStore {
    private const val PREFS = "mai_widgets"
    private const val KEY_PAYLOAD = "payload"
    private const val KEY_HIDE = "hide_amounts"

    private fun prefs(context: Context) =
        context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)

    fun savePayload(context: Context, json: String) {
        prefs(context).edit().putString(KEY_PAYLOAD, json).apply()
    }

    fun payload(context: Context): WidgetPayload? = payloadJson(context)?.let { WidgetPayload.parse(it) }

    /** Unveränderter Stand, wie ihn die App geschickt hat (für die Uhr). */
    fun payloadJson(context: Context): String? = prefs(context).getString(KEY_PAYLOAD, null)

    /** `null` = nie eingestellt (die App entscheidet dann selbst). */
    fun hideAmounts(context: Context): Boolean? {
        val prefs = prefs(context)
        return if (prefs.contains(KEY_HIDE)) prefs.getBoolean(KEY_HIDE, false) else null
    }

    fun setHideAmounts(context: Context, value: Boolean) {
        prefs(context).edit().putBoolean(KEY_HIDE, value).apply()
    }
}
