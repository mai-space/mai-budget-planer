package space.mai.mai_budget_planer.wear

import android.app.Activity
import android.content.SharedPreferences
import android.graphics.Typeface
import android.os.Bundle
import android.util.TypedValue
import android.view.Gravity
import android.widget.LinearLayout
import android.widget.ScrollView
import android.widget.TextView

/**
 * Einfache Übersicht auf der Uhr: frei verfügbar und alle anstehenden
 * Jahres-/Quartalszahlungen. Holt beim Öffnen den Stand vom Handy.
 */
class WatchActivity : Activity() {
    private lateinit var list: LinearLayout

    private val listener = SharedPreferences.OnSharedPreferenceChangeListener { _, _ -> render() }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Runde Displays: großzügiger Rand oben/unten und seitlich.
        val pad = dp(24)
        list = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            gravity = Gravity.CENTER_HORIZONTAL
            setPadding(pad, dp(32), pad, dp(40))
        }
        setContentView(ScrollView(this).apply { addView(list) })
    }

    override fun onResume() {
        super.onResume()
        WatchStore.prefs(this).registerOnSharedPreferenceChangeListener(listener)
        render()
        PhoneLink.refresh(this)
    }

    override fun onPause() {
        WatchStore.prefs(this).unregisterOnSharedPreferenceChangeListener(listener)
        super.onPause()
    }

    private fun render() {
        list.removeAllViews()
        val payload = WatchStore.payload(this)
        add(getString(R.string.tile_free_name), 14f, WatchColors.MUTED)
        if (payload == null || !payload.hasData) {
            add(getString(R.string.no_data), 16f)
            return
        }
        val color = if (payload.freeNegative) WatchColors.DANGER else WatchColors.POSITIVE
        add(payload.free ?: getString(R.string.hidden), 28f, color, bold = true)
        if (payload.hidden) add(getString(R.string.amounts_hidden_hint), 12f, WatchColors.MUTED)

        add(getString(R.string.tile_upcoming_name), 14f, WatchColors.MUTED, top = 16)
        val due = payload.dueList()
        if (due.isEmpty()) add(getString(R.string.no_upcoming), 14f)
        for (d in due) {
            add(d.item.label, 15f, bold = true, top = 8)
            add("${d.whenText(this)} · ${d.amount(this)}", 13f, WatchColors.MUTED)
        }
    }

    private fun add(text: String, sizeSp: Float, color: Int = WatchColors.INK, bold: Boolean = false, top: Int = 2) {
        list.addView(
            TextView(this).apply {
                this.text = text
                gravity = Gravity.CENTER_HORIZONTAL
                setTextColor(color)
                setTextSize(TypedValue.COMPLEX_UNIT_SP, sizeSp)
                if (bold) setTypeface(typeface, Typeface.BOLD)
            },
            LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT)
                .apply { topMargin = dp(top) },
        )
    }

    private fun dp(value: Int) = TypedValue.applyDimension(
        TypedValue.COMPLEX_UNIT_DIP,
        value.toFloat(),
        resources.displayMetrics,
    ).toInt()
}
