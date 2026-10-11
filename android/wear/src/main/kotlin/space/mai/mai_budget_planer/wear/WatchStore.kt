package space.mai.mai_budget_planer.wear

import android.content.Context
import android.content.SharedPreferences
import space.mai.mai_budget_planer.widget.WidgetPayload

/**
 * Letzter Widget-Stand vom Handy, im privaten App-Speicher der Uhr
 * (kein Backup). Mit „Beträge ausblenden“ enthält er keine Beträge.
 */
object WatchStore {
    private const val PREFS = "mai_watch"
    private const val KEY_PAYLOAD = "payload"

    fun prefs(context: Context): SharedPreferences =
        context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)

    fun payload(context: Context): WidgetPayload? =
        prefs(context).getString(KEY_PAYLOAD, null)?.let { WidgetPayload.parse(it) }

    /** Speichert den Stand (`null` löscht ihn) und zeichnet alles neu. */
    fun save(context: Context, json: String?) {
        val current = prefs(context).getString(KEY_PAYLOAD, null)
        if (current == json) return
        prefs(context).edit().apply {
            if (json == null) remove(KEY_PAYLOAD) else putString(KEY_PAYLOAD, json)
        }.apply()
        Surfaces.refreshAll(context)
    }
}
