package space.mai.mai_budget_planer.widget

import android.content.Context
import org.json.JSONArray
import org.json.JSONException
import org.json.JSONObject

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

    fun payload(context: Context): WidgetPayload? =
        prefs(context).getString(KEY_PAYLOAD, null)?.let { WidgetPayload.parse(it) }

    /** `null` = nie eingestellt (die App entscheidet dann selbst). */
    fun hideAmounts(context: Context): Boolean? {
        val prefs = prefs(context)
        return if (prefs.contains(KEY_HIDE)) prefs.getBoolean(KEY_HIDE, false) else null
    }

    fun setHideAmounts(context: Context, value: Boolean) {
        prefs(context).edit().putBoolean(KEY_HIDE, value).apply()
    }
}

/** Anteil eines Topfs am Netto und Ziel laut Budgetregel (0–1). */
data class BucketShare(val share: Double, val target: Double)

/** Nicht monatlicher Posten mit seinen Fälligkeitsmonaten (1–12). */
data class UpcomingItem(val label: String, val amount: String?, val months: List<Int>) {
    /** Monate bis zur nächsten Fälligkeit ab [month] (0 = diesen Monat). */
    fun distanceFrom(month: Int): Int = months.minOf { (it - month + 12) % 12 }
}

class WidgetPayload(
    val hidden: Boolean,
    val hasData: Boolean,
    val free: String?,
    val freeNegative: Boolean,
    val income: String?,
    val planned: String?,
    val hasReserve: Boolean,
    val reserve: String?,
    val buckets: List<BucketShare>,
    val upcoming: List<UpcomingItem>,
) {
    companion object {
        /** Unbekannte Felder werden ignoriert; kaputte Daten → `null`. */
        fun parse(json: String): WidgetPayload? = try {
            val o = JSONObject(json)
            WidgetPayload(
                hidden = o.optBoolean("hidden", true),
                hasData = o.optBoolean("hasData", false),
                free = o.str("free"),
                freeNegative = o.optBoolean("freeNegative", false),
                income = o.str("income"),
                planned = o.str("planned"),
                hasReserve = o.optBoolean("hasReserve", false),
                reserve = o.str("reserve"),
                buckets = o.optJSONArray("buckets").objects().map {
                    BucketShare(it.optDouble("share", 0.0), it.optDouble("target", 0.0))
                },
                upcoming = o.optJSONArray("upcoming").objects().mapNotNull { item ->
                    val months = item.optJSONArray("months") ?: return@mapNotNull null
                    val list = (0 until months.length())
                        .map { months.optInt(it) }
                        .filter { it in 1..12 }
                    if (list.isEmpty()) return@mapNotNull null
                    UpcomingItem(item.optString("label"), item.str("amount"), list)
                },
            )
        } catch (e: JSONException) {
            null
        }

        private fun JSONObject.str(key: String): String? = if (isNull(key)) null else optString(key)

        private fun JSONArray?.objects(): List<JSONObject> =
            if (this == null) emptyList() else (0 until length()).mapNotNull { optJSONObject(it) }
    }
}
