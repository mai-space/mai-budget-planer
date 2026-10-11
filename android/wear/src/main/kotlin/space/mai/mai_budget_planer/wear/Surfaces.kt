package space.mai.mai_budget_planer.wear

import android.content.ComponentName
import android.content.Context
import androidx.wear.tiles.TileService
import androidx.wear.watchface.complications.datasource.ComplicationDataSourceUpdateRequester

/** Kacheln und Komplikationen nach neuem Stand neu zeichnen lassen. */
object Surfaces {
    fun refreshAll(context: Context) {
        val updater = TileService.getUpdater(context)
        updater.requestUpdate(FreeTileService::class.java)
        updater.requestUpdate(UpcomingTileService::class.java)
        listOf(FreeComplicationService::class.java, NextPaymentComplicationService::class.java)
            .forEach {
                ComplicationDataSourceUpdateRequester
                    .create(context, ComponentName(context, it))
                    .requestUpdateAll()
            }
    }
}
