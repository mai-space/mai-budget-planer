package space.mai.mai_budget_planer.widget

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.res.Configuration
import android.os.Build
import android.os.Bundle
import android.util.SizeF
import android.widget.RemoteViews
import space.mai.mai_budget_planer.MainActivity

/**
 * Gemeinsame Basis: ab Android 12 liefert jedes Widget eine Layout-Variante
 * je Größenstufe (der Launcher wählt beim Größenändern selbst), davor wird
 * bei jeder Größenänderung passend zur aktuellen Größe neu gezeichnet.
 */
abstract class ResponsiveWidgetProvider : AppWidgetProvider() {
    /** Größenstufen in dp (Breite × Höhe), für Android 12+. */
    protected abstract val sizes: List<SizeF>

    /** Baut das Widget für eine Größe in dp. */
    protected abstract fun build(
        context: Context,
        payload: WidgetPayload?,
        widthDp: Float,
        heightDp: Float,
    ): RemoteViews

    override fun onUpdate(context: Context, manager: AppWidgetManager, ids: IntArray) {
        val payload = WidgetStore.payload(context)
        ids.forEach { render(context, manager, it, payload) }
    }

    override fun onAppWidgetOptionsChanged(
        context: Context,
        manager: AppWidgetManager,
        id: Int,
        newOptions: Bundle,
    ) {
        render(context, manager, id, WidgetStore.payload(context), newOptions)
    }

    fun render(
        context: Context,
        manager: AppWidgetManager,
        id: Int,
        payload: WidgetPayload?,
        options: Bundle = manager.getAppWidgetOptions(id),
    ) {
        val views = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            RemoteViews(sizes.associateWith { build(context, payload, it.width, it.height) })
        } else {
            val (width, height) = currentSize(context, options)
            build(context, payload, width, height)
        }
        manager.updateAppWidget(id, views)
    }

    /** Aktuelle Größe vor Android 12: hochkant schmal und hoch, quer breit und flach. */
    private fun currentSize(context: Context, options: Bundle): Pair<Float, Float> {
        val portrait = context.resources.configuration.orientation != Configuration.ORIENTATION_LANDSCAPE
        val width = options.getInt(
            if (portrait) AppWidgetManager.OPTION_APPWIDGET_MIN_WIDTH else AppWidgetManager.OPTION_APPWIDGET_MAX_WIDTH,
        )
        val height = options.getInt(
            if (portrait) AppWidgetManager.OPTION_APPWIDGET_MAX_HEIGHT else AppWidgetManager.OPTION_APPWIDGET_MIN_HEIGHT,
        )
        // Ohne Angaben (frisch platziert): mittlere Stufe annehmen.
        return Pair(
            if (width > 0) width.toFloat() else 180f,
            if (height > 0) height.toFloat() else 110f,
        )
    }
}

object Widgets {
    const val EXTRA_ACTION = "space.mai.mai_budget_planer.WIDGET_ACTION"
    const val ACTION_ADD_ITEM = "add_item"
    const val ACTION_OVERVIEW = "overview"

    /** Öffnet die App (mit App-Sperre, falls aktiv) und meldet die Aktion. */
    fun launch(context: Context, action: String): PendingIntent {
        val intent = Intent(context, MainActivity::class.java)
            .setAction("space.mai.mai_budget_planer.WIDGET.$action")
            .putExtra(EXTRA_ACTION, action)
            .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_SINGLE_TOP)
        return PendingIntent.getActivity(
            context,
            action.hashCode(),
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
        )
    }

    /** Alle platzierten Widgets mit den gespeicherten Daten neu zeichnen. */
    fun refreshAll(context: Context) {
        val manager = AppWidgetManager.getInstance(context)
        val payload = WidgetStore.payload(context)
        listOf(BudgetWidgetProvider(), UpcomingWidgetProvider(), QuickAddWidgetProvider())
            .forEach { provider ->
                manager.getAppWidgetIds(ComponentName(context, provider.javaClass))
                    .forEach { provider.render(context, manager, it, payload) }
            }
    }
}
