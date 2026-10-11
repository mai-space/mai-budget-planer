package space.mai.mai_budget_planer.wear

import android.content.Context
import android.net.Uri
import android.util.Log
import com.google.android.gms.wearable.DataMapItem
import com.google.android.gms.wearable.PutDataRequest
import com.google.android.gms.wearable.Wearable
import space.mai.mai_budget_planer.widget.WatchProtocol

/** Holt den Stand vom Handy: vorhandenes DataItem lesen, frischen anfragen. */
object PhoneLink {
    private const val TAG = "MaiPhoneLink"

    fun refresh(context: Context) {
        val app = context.applicationContext
        try {
            val uri = Uri.Builder()
                .scheme(PutDataRequest.WEAR_URI_SCHEME)
                .path(WatchProtocol.PATH_PAYLOAD)
                .build()
            Wearable.getDataClient(app).getDataItems(uri).addOnSuccessListener { buffer ->
                val json = buffer.firstOrNull()?.let {
                    DataMapItem.fromDataItem(it).dataMap.getString(WatchProtocol.KEY_PAYLOAD)
                }
                buffer.release()
                if (json != null) WatchStore.save(app, json)
            }
            // Die Handy-App antwortet mit putDataItem → PhoneListenerService.
            Wearable.getNodeClient(app).connectedNodes.addOnSuccessListener { nodes ->
                val messages = Wearable.getMessageClient(app)
                nodes.forEach { messages.sendMessage(it.id, WatchProtocol.PATH_REQUEST, ByteArray(0)) }
            }
        } catch (e: RuntimeException) {
            Log.i(TAG, "Wearable-API nicht verfügbar: ${e.javaClass.simpleName}")
        }
    }
}
