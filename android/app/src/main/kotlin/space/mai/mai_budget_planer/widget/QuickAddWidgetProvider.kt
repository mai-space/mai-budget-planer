package space.mai.mai_budget_planer.widget

import android.content.Context
import android.util.SizeF
import android.view.View
import android.widget.RemoteViews
import space.mai.mai_budget_planer.R

/** „Neuer Posten“: ein Tipp öffnet direkt das Formular. Zeigt keine Daten. */
class QuickAddWidgetProvider : ResponsiveWidgetProvider() {
    override val sizes = listOf(SizeF(40f, 40f), SizeF(130f, 40f))

    override fun build(
        context: Context,
        payload: WidgetPayload?,
        widthDp: Float,
        heightDp: Float,
    ): RemoteViews {
        val views = RemoteViews(context.packageName, R.layout.widget_quick_add)
        views.setOnClickPendingIntent(android.R.id.background, Widgets.launch(context, Widgets.ACTION_ADD_ITEM))
        views.setViewVisibility(R.id.label, if (widthDp >= 130f) View.VISIBLE else View.GONE)
        return views
    }
}
