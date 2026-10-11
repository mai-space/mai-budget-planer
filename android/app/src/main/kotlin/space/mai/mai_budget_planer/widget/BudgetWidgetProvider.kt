package space.mai.mai_budget_planer.widget

import android.content.Context
import android.util.SizeF
import android.util.TypedValue
import android.view.View
import android.widget.RemoteViews
import space.mai.mai_budget_planer.R
import kotlin.math.roundToInt

/**
 * „Frei verfügbar“: Betrag; ab mittlerer Höhe Einkommen/Geplant/Rücklage,
 * groß zusätzlich die Budgetregel als Balken.
 */
class BudgetWidgetProvider : ResponsiveWidgetProvider() {
    override val sizes = listOf(
        SizeF(110f, 40f),
        SizeF(180f, 40f),
        SizeF(110f, 100f),
        SizeF(180f, 110f),
        SizeF(180f, 200f),
        SizeF(250f, 250f),
    )

    override fun build(
        context: Context,
        payload: WidgetPayload?,
        widthDp: Float,
        heightDp: Float,
    ): RemoteViews {
        val views = RemoteViews(context.packageName, R.layout.widget_budget)
        views.setOnClickPendingIntent(android.R.id.background, Widgets.launch(context, Widgets.ACTION_OVERVIEW))
        views.setOnClickPendingIntent(R.id.add, Widgets.launch(context, Widgets.ACTION_ADD_ITEM))
        if (payload == null || !payload.hasData) {
            views.setViewVisibility(R.id.content, View.GONE)
            views.setViewVisibility(R.id.empty, View.VISIBLE)
            return views
        }
        val hidden = context.getString(R.string.widget_hidden)

        // Größenstufen: flach nur Betrag, mittel mit Details, hoch mit Regel.
        val flat = heightDp < 90f
        val showDetails = heightDp >= 110f
        val showBuckets = heightDp >= 200f && payload.buckets.size == 3
        views.setViewVisibility(R.id.add, visibleIf(widthDp >= 150f && !flat))
        views.setViewVisibility(R.id.title, visibleIf(!flat || widthDp >= 150f))
        views.setViewVisibility(R.id.details, visibleIf(showDetails))
        views.setViewVisibility(R.id.buckets, visibleIf(showBuckets))

        val amountSp = when {
            flat -> if (widthDp < 150f) 18f else 22f
            widthDp < 150f -> 22f
            else -> 30f
        }
        val amountId = if (payload.freeNegative) R.id.amount_neg else R.id.amount_pos
        val otherId = if (payload.freeNegative) R.id.amount_pos else R.id.amount_neg
        views.setViewVisibility(amountId, View.VISIBLE)
        views.setViewVisibility(otherId, View.GONE)
        views.setTextViewText(amountId, payload.free ?: hidden)
        views.setTextViewTextSize(amountId, TypedValue.COMPLEX_UNIT_SP, amountSp)

        views.setTextViewText(R.id.value_income, payload.income ?: hidden)
        views.setTextViewText(R.id.value_planned, payload.planned ?: hidden)
        views.setViewVisibility(R.id.row_reserve, visibleIf(payload.hasReserve))
        views.setTextViewText(R.id.value_reserve, payload.reserve ?: hidden)

        if (showBuckets) {
            val ids = listOf(
                Triple(R.id.share_needs, R.id.bar_needs, payload.buckets[0]),
                Triple(R.id.share_wants, R.id.bar_wants, payload.buckets[1]),
                Triple(R.id.share_savings, R.id.bar_savings, payload.buckets[2]),
            )
            for ((textId, barId, bucket) in ids) {
                val share = (bucket.share * 100).roundToInt()
                val target = (bucket.target * 100).roundToInt()
                views.setTextViewText(textId, context.getString(R.string.widget_share, share, target))
                views.setProgressBar(barId, 100, share.coerceIn(0, 100), false)
            }
        }
        return views
    }

    private fun visibleIf(visible: Boolean) = if (visible) View.VISIBLE else View.GONE
}
