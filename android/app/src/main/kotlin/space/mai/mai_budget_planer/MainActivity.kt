package space.mai.mai_budget_planer

import android.content.Intent
import android.view.WindowManager
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import space.mai.mai_budget_planer.widget.HomeWidgetChannel

// FragmentActivity wird von local_auth (BiometricPrompt) benötigt.
class MainActivity : FlutterFragmentActivity() {
    private var widgets: HomeWidgetChannel? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, DatabaseKeyChannel.NAME)
            .setMethodCallHandler(DatabaseKeyChannel(applicationContext))
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "mai/secure_window")
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    // Blendet App-Inhalte in „Zuletzt verwendet“ und Screenshots aus.
                    "setSecure" -> {
                        if (call.arguments as? Boolean == true) {
                            window.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
                        } else {
                            window.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
                        }
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
        // Startbildschirm-Widgets; Start aus einem Widget-Tipp merken.
        widgets = HomeWidgetChannel(
            applicationContext,
            MethodChannel(flutterEngine.dartExecutor.binaryMessenger, HomeWidgetChannel.NAME),
        ).also { it.offer(intent, notify = false) }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        widgets?.offer(intent, notify = true)
    }
}
