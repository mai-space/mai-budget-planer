package space.mai.mai_budget_planer.wear

import com.google.android.gms.wearable.DataEvent
import com.google.android.gms.wearable.DataEventBuffer
import com.google.android.gms.wearable.DataMapItem
import com.google.android.gms.wearable.WearableListenerService
import space.mai.mai_budget_planer.widget.WatchProtocol

/** Neuer Widget-Stand vom Handy (auch wenn die Uhr-App nicht läuft). */
class PhoneListenerService : WearableListenerService() {
    override fun onDataChanged(events: DataEventBuffer) {
        for (event in events) {
            val item = event.dataItem
            if (item.uri.path != WatchProtocol.PATH_PAYLOAD) continue
            when (event.type) {
                DataEvent.TYPE_CHANGED -> WatchStore.save(
                    this,
                    DataMapItem.fromDataItem(item).dataMap.getString(WatchProtocol.KEY_PAYLOAD),
                )
                DataEvent.TYPE_DELETED -> WatchStore.save(this, null)
            }
        }
    }
}
