package space.mai.mai_budget_planer.wear

import android.content.Context
import space.mai.mai_budget_planer.widget.UpcomingItem
import space.mai.mai_budget_planer.widget.WidgetPayload
import java.text.DateFormatSymbols
import java.util.Calendar
import java.util.Locale

/** Nächste Fälligkeit eines Postens, vom aktuellen Monat aus gesehen. */
class Due(val item: UpcomingItem, private val distance: Int, private val monthIndex: Int) {
    /** „Diesen Monat“ bzw. Monatsname (kurz für Komplikationen). */
    fun whenText(context: Context, short: Boolean = false): String {
        if (distance == 0) return context.getString(if (short) R.string.this_month_short else R.string.this_month)
        val symbols = DateFormatSymbols.getInstance(Locale.getDefault())
        return (if (short) symbols.shortMonths else symbols.months)[monthIndex]
    }

    fun amount(context: Context): String = item.amount ?: context.getString(R.string.hidden)
}

/** Posten nach nächster Fälligkeit; die Uhr rechnet den Monatswechsel selbst. */
fun WidgetPayload.dueList(): List<Due> {
    val month = Calendar.getInstance().get(Calendar.MONTH) + 1
    return sortedUpcoming(month).map {
        val distance = it.distanceFrom(month)
        Due(it, distance, (month - 1 + distance) % 12)
    }
}
