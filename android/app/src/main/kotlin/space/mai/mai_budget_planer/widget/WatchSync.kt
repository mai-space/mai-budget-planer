package space.mai.mai_budget_planer.widget

import android.content.Context
import android.util.Log
import com.google.android.gms.wearable.CapabilityClient
import com.google.android.gms.wearable.PutDataMapRequest
import com.google.android.gms.wearable.Wearable

/**
 * Schickt den Widget-Stand an die Uhr — aber nur, wenn eine Uhr mit der
 * Budget-App gekoppelt ist. Ohne Uhr-App wird ein alter Stand aus der
 * Data Layer gelöscht. Ohne Play-Dienste passiert schlicht nichts.
 */
object WatchSync {
    private const val TAG = "MaiWatchSync"

    fun push(context: Context, json: String?) {
        val app = context.applicationContext
        try {
            Wearable.getCapabilityClient(app)
                .getCapability(WatchProtocol.CAPABILITY_WATCH, CapabilityClient.FILTER_ALL)
                .addOnSuccessListener { info ->
                    if (info.nodes.isEmpty() || json == null) {
                        clear(app)
                    } else {
                        put(app, json)
                    }
                }
                .addOnFailureListener { Log.i(TAG, "Keine Uhr erreichbar: ${it.javaClass.simpleName}") }
        } catch (e: RuntimeException) {
            // Ohne Play-Dienste kann schon das Holen des Clients scheitern.
            Log.i(TAG, "Wearable-API nicht verfügbar: ${e.javaClass.simpleName}")
        }
    }

    private fun put(context: Context, json: String) {
        val request = PutDataMapRequest.create(WatchProtocol.PATH_PAYLOAD).apply {
            dataMap.putString(WatchProtocol.KEY_PAYLOAD, json)
        }.asPutDataRequest().setUrgent()
        Wearable.getDataClient(context).putDataItem(request)
            .addOnFailureListener { Log.i(TAG, "Senden fehlgeschlagen: ${it.javaClass.simpleName}") }
    }

    private fun clear(context: Context) {
        val uri = PutDataMapRequest.create(WatchProtocol.PATH_PAYLOAD).uri
        Wearable.getDataClient(context).deleteDataItems(uri)
    }
}
