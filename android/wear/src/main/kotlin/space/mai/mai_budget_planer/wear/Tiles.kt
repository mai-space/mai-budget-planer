package space.mai.mai_budget_planer.wear

import android.content.Context
import androidx.concurrent.futures.CallbackToFutureAdapter
import androidx.wear.protolayout.ActionBuilders
import androidx.wear.protolayout.ColorBuilders
import androidx.wear.protolayout.DimensionBuilders
import androidx.wear.protolayout.LayoutElementBuilders
import androidx.wear.protolayout.ModifiersBuilders
import androidx.wear.protolayout.ResourceBuilders
import androidx.wear.protolayout.TimelineBuilders
import androidx.wear.tiles.EventBuilders
import androidx.wear.tiles.RequestBuilders
import androidx.wear.tiles.TileBuilders
import androidx.wear.tiles.TileService
import com.google.common.util.concurrent.ListenableFuture
import space.mai.mai_budget_planer.widget.WidgetPayload

/** Farben auf dunklem Uhr-Hintergrund (gleiche Familie wie die Widgets). */
object WatchColors {
    const val INK = 0xFFFFFFFF.toInt()
    const val MUTED = 0xFFB0BEC5.toInt()
    const val POSITIVE = 0xFF7FD3A8.toInt()
    const val DANGER = 0xFFFF8A80.toInt()
}

/**
 * Gemeinsame Basis der Kacheln: Layout aus dem gespeicherten Stand, Tipp
 * öffnet die Uhr-App. Alle 6 h neu, damit der Monatswechsel stimmt.
 */
abstract class BudgetTileService : TileService() {
    protected abstract fun content(payload: WidgetPayload?): LayoutElementBuilders.LayoutElement

    override fun onTileRequest(
        requestParams: RequestBuilders.TileRequest,
    ): ListenableFuture<TileBuilders.Tile> {
        val tile = TileBuilders.Tile.Builder()
            .setResourcesVersion(RESOURCES_VERSION)
            .setFreshnessIntervalMillis(6 * 60 * 60 * 1000L)
            .setTileTimeline(TimelineBuilders.Timeline.fromLayoutElement(root(content(WatchStore.payload(this)))))
            .build()
        return immediate(tile)
    }

    override fun onTileResourcesRequest(
        requestParams: RequestBuilders.ResourcesRequest,
    ): ListenableFuture<ResourceBuilders.Resources> =
        immediate(ResourceBuilders.Resources.Builder().setVersion(RESOURCES_VERSION).build())

    override fun onTileAddEvent(requestParams: EventBuilders.TileAddEvent) {
        // Frisch hinzugefügt: Stand vom Handy holen.
        PhoneLink.refresh(this)
    }

    /** Ganze Kachel antippbar, Inhalt mittig. */
    private fun root(content: LayoutElementBuilders.LayoutElement): LayoutElementBuilders.LayoutElement {
        val open = ActionBuilders.LaunchAction.Builder()
            .setAndroidActivity(
                ActionBuilders.AndroidActivity.Builder()
                    .setPackageName(packageName)
                    .setClassName(WatchActivity::class.java.name)
                    .build(),
            )
            .build()
        return LayoutElementBuilders.Box.Builder()
            .setWidth(DimensionBuilders.expand())
            .setHeight(DimensionBuilders.expand())
            .setHorizontalAlignment(LayoutElementBuilders.HORIZONTAL_ALIGN_CENTER)
            .setVerticalAlignment(LayoutElementBuilders.VERTICAL_ALIGN_CENTER)
            .setModifiers(
                ModifiersBuilders.Modifiers.Builder()
                    .setClickable(ModifiersBuilders.Clickable.Builder().setId("open").setOnClick(open).build())
                    .setPadding(ModifiersBuilders.Padding.Builder().setAll(DimensionBuilders.dp(20f)).build())
                    .build(),
            )
            .addContent(content)
            .build()
    }

    protected fun column(vararg children: LayoutElementBuilders.LayoutElement): LayoutElementBuilders.LayoutElement =
        LayoutElementBuilders.Column.Builder()
            .setHorizontalAlignment(LayoutElementBuilders.HORIZONTAL_ALIGN_CENTER)
            .apply { children.forEach { addContent(it) } }
            .build()

    protected fun text(
        value: String,
        sizeSp: Float,
        color: Int = WatchColors.INK,
        bold: Boolean = false,
        maxLines: Int = 1,
    ): LayoutElementBuilders.LayoutElement =
        LayoutElementBuilders.Text.Builder()
            .setText(value)
            .setMaxLines(maxLines)
            .setOverflow(LayoutElementBuilders.TEXT_OVERFLOW_ELLIPSIZE_END)
            .setFontStyle(
                LayoutElementBuilders.FontStyle.Builder()
                    .setSize(DimensionBuilders.sp(sizeSp))
                    .setColor(ColorBuilders.argb(color))
                    .setWeight(
                        if (bold) LayoutElementBuilders.FONT_WEIGHT_BOLD else LayoutElementBuilders.FONT_WEIGHT_NORMAL,
                    )
                    .build(),
            )
            .build()

    protected fun gap(heightDp: Float): LayoutElementBuilders.LayoutElement =
        LayoutElementBuilders.Spacer.Builder().setHeight(DimensionBuilders.dp(heightDp)).build()

    /** Kein Stand vom Handy: Hinweis statt leerer Kachel. */
    protected fun noData(context: Context, title: String): LayoutElementBuilders.LayoutElement =
        column(
            text(title, 14f, WatchColors.MUTED),
            gap(6f),
            text(context.getString(R.string.no_data), 14f, maxLines = 2),
        )

    private fun <T : Any> immediate(value: T): ListenableFuture<T> =
        CallbackToFutureAdapter.getFuture { completer ->
            completer.set(value)
            "mai-tile"
        }

    companion object {
        private const val RESOURCES_VERSION = "1"
    }
}

/** „Frei verfügbar“: Betrag groß, darunter die nächste Zahlung. */
class FreeTileService : BudgetTileService() {
    override fun content(payload: WidgetPayload?): LayoutElementBuilders.LayoutElement {
        val title = getString(R.string.tile_free_name)
        if (payload == null || !payload.hasData) return noData(this, title)
        val amount = payload.free ?: getString(R.string.hidden)
        val color = if (payload.freeNegative) WatchColors.DANGER else WatchColors.POSITIVE
        val next = payload.dueList().firstOrNull()
        return if (next == null) {
            column(text(title, 14f, WatchColors.MUTED), gap(4f), text(amount, 30f, color, bold = true))
        } else {
            column(
                text(title, 14f, WatchColors.MUTED),
                gap(4f),
                text(amount, 30f, color, bold = true),
                gap(10f),
                text(getString(R.string.next_label, next.item.label), 13f, WatchColors.MUTED),
                text("${next.whenText(this)} · ${next.amount(this)}", 13f, WatchColors.MUTED),
            )
        }
    }
}

/** „Demnächst fällig“: die nächsten drei Jahres-/Quartalszahlungen. */
class UpcomingTileService : BudgetTileService() {
    override fun content(payload: WidgetPayload?): LayoutElementBuilders.LayoutElement {
        val title = getString(R.string.tile_upcoming_name)
        if (payload == null) return noData(this, title)
        val due = payload.dueList().take(3)
        if (due.isEmpty()) {
            return column(text(title, 14f, WatchColors.MUTED), gap(6f), text(getString(R.string.no_upcoming), 14f, maxLines = 2))
        }
        val rows = mutableListOf(text(title, 14f, WatchColors.MUTED))
        for (d in due) {
            rows += gap(4f)
            rows += text(d.item.label, 14f, bold = true)
            rows += text("${d.whenText(this)} · ${d.amount(this)}", 12f, WatchColors.MUTED)
        }
        return column(*rows.toTypedArray())
    }
}
