package space.mai.mai_budget_planer.widget

import android.content.Context
import android.content.Intent
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/** Verbindung App ↔ Widgets: Daten übernehmen, Tipp-Aktionen melden. */
class HomeWidgetChannel(
    private val context: Context,
    private val channel: MethodChannel,
) : MethodChannel.MethodCallHandler {
    companion object {
        const val NAME = "mai/home_widgets"
    }

    /** Aktion des letzten Widget-Tipps, bis die App sie abholt. */
    private var pending: String? = null

    init {
        channel.setMethodCallHandler(this)
    }

    /** Merkt sich die Aktion aus einem Widget-Tipp; [notify] bei laufender App. */
    fun offer(intent: Intent?, notify: Boolean) {
        val action = intent?.getStringExtra(Widgets.EXTRA_ACTION) ?: return
        // Nur einmal auswerten, auch wenn die Activity neu erstellt wird.
        intent.removeExtra(Widgets.EXTRA_ACTION)
        pending = action
        if (notify) channel.invokeMethod("launchAction", null)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "publish" -> {
                val json = call.arguments as? String
                if (json == null) {
                    result.error("BAD_ARGS", "JSON erwartet", null)
                    return
                }
                WidgetStore.savePayload(context, json)
                Widgets.refreshAll(context)
                // Gleicher Stand für Kacheln und Komplikationen auf der Uhr.
                WatchSync.push(context, json)
                result.success(null)
            }
            "getHideAmounts" -> result.success(WidgetStore.hideAmounts(context))
            "setHideAmounts" -> {
                WidgetStore.setHideAmounts(context, call.arguments as? Boolean == true)
                result.success(null)
            }
            "takeLaunchAction" -> {
                result.success(pending)
                pending = null
            }
            else -> result.notImplemented()
        }
    }
}
