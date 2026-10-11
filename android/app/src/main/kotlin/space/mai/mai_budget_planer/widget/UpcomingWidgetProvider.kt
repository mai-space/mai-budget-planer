package space.mai.mai_budget_planer.widget

import android.content.Context
import android.util.SizeF
import android.view.View
import android.widget.RemoteViews
import space.mai.mai_budget_planer.R
import java.text.DateFormatSymbols
import java.util.Calendar
import java.util.Locale

/**
 * „Demnächst fällig“: Jahres-/Quartalszahlungen nach nächster Fälligkeit.
 * Die Reihenfolge rechnet das Widget selbst (Monatswechsel ohne App).
 */
class UpcomingWidgetProvider : ResponsiveWidgetProvider() {
    override val sizes = listOf(
        SizeF(110f, 40f),
        SizeF(250f, 40f),
        SizeF(110f, 110f),
        SizeF(250f, 110f),
        SizeF(110f, 180f),
        SizeF(250f, 180f),
        SizeF(110f, 260f),
        SizeF(250f, 260f),
    )

    override fun build(
        context: Context,
        payload: WidgetPayload?,
        widthDp: Float,
        heightDp: Float,
    ): RemoteViews {
        val views = RemoteViews(context.packageName, R.layout.widget_upcoming)
        views.setOnClickPendingIntent(android.R.id.background, Widgets.launch(context, Widgets.ACTION_OVERVIEW))
        views.setOnClickPendingIntent(R.id.add, Widgets.launch(context, Widgets.ACTION_ADD_ITEM))
        if (payload == null) {
            views.setViewVisibility(R.id.content, View.GONE)
            views.setViewVisibility(R.id.empty, View.VISIBLE)
            return views
        }
        val hidden = context.getString(R.string.widget_hidden)
        val compact = widthDp < 180f
        // Flach: nur die nächste Zahlung, ohne Kopf.
        val flat = heightDp < 90f
        views.setViewVisibility(R.id.header, if (flat) View.GONE else View.VISIBLE)
        views.setViewVisibility(R.id.add, if (compact) View.GONE else View.VISIBLE)

        val showFooter = !flat && heightDp >= 180f && payload.hasReserve
        views.setViewVisibility(R.id.footer, if (showFooter) View.VISIBLE else View.GONE)
        views.setTextViewText(R.id.value_reserve, payload.reserve ?: hidden)

        val month = Calendar.getInstance().get(Calendar.MONTH) + 1
        val sorted = payload.sortedUpcoming(month)
        views.setViewVisibility(R.id.rows, if (sorted.isEmpty()) View.GONE else View.VISIBLE)
        views.setViewVisibility(R.id.none, if (sorted.isEmpty()) View.VISIBLE else View.GONE)

        // Platz für Zeilen: Höhe minus Innenabstand, Kopf und Fußzeile.
        val rowDp = if (compact) 36f else 28f
        val free = heightDp - 28f - (if (flat) 0f else 34f) - (if (showFooter) 20f else 0f)
        val rows = (free / rowDp).toInt().coerceIn(1, 8)

        views.removeAllViews(R.id.rows)
        val monthNames = DateFormatSymbols.getInstance(Locale.getDefault()).months
        for (item in sorted.take(rows)) {
            val distance = item.distanceFrom(month)
            val dueMonth = (month - 1 + distance) % 12
            val whenText = if (distance == 0) {
                context.getString(R.string.widget_this_month)
            } else {
                monthNames[dueMonth]
            }
            val amount = item.amount ?: hidden
            val row = if (compact) {
                RemoteViews(context.packageName, R.layout.widget_upcoming_row_compact).apply {
                    setTextViewText(R.id.label, item.label)
                    setTextViewText(R.id.due, "$whenText · $amount")
                }
            } else {
                RemoteViews(context.packageName, R.layout.widget_upcoming_row).apply {
                    setTextViewText(R.id.label, item.label)
                    setTextViewText(R.id.due, whenText)
                    setTextViewText(R.id.amount, amount)
                }
            }
            views.addView(R.id.rows, row)
        }
        return views
    }
}
