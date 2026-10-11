package space.mai.mai_budget_planer.widget

import org.json.JSONArray
import org.json.JSONException
import org.json.JSONObject

// Gemeinsam mit der Wear-OS-App (android/wear bindet diesen Ordner als
// Quellordner ein): nur org.json und Kotlin, keine App-Abhängigkeiten.

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
    /** Nach nächster Fälligkeit ab [month] (1–12), gleich weit alphabetisch. */
    fun sortedUpcoming(month: Int): List<UpcomingItem> = upcoming.sortedWith(
        compareBy<UpcomingItem> { it.distanceFrom(month) }.thenBy { it.label.lowercase() },
    )

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
