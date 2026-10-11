package space.mai.mai_budget_planer.widget

import com.google.android.gms.wearable.CapabilityInfo
import com.google.android.gms.wearable.MessageEvent
import com.google.android.gms.wearable.WearableListenerService

/**
 * Meldungen von der Uhr, auch wenn die App nicht läuft: Die Uhr fragt nach
 * dem Stand (z. B. direkt nach der Installation), oder die Uhr-App kommt
 * bzw. geht. Geschickt wird der zuletzt von der App gespeicherte Stand.
 */
class WatchListenerService : WearableListenerService() {
    override fun onMessageReceived(event: MessageEvent) {
        if (event.path == WatchProtocol.PATH_REQUEST) {
            WatchSync.push(this, WidgetStore.payloadJson(this))
        }
    }

    override fun onCapabilityChanged(info: CapabilityInfo) {
        if (info.name == WatchProtocol.CAPABILITY_WATCH) {
            WatchSync.push(this, WidgetStore.payloadJson(this))
        }
    }
}
