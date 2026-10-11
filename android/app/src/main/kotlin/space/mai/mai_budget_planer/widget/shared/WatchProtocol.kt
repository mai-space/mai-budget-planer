package space.mai.mai_budget_planer.widget

/**
 * Abgleich Handy ↔ Wear-OS-Uhr über die Wearable Data Layer der
 * Google-Play-Dienste (Bluetooth bzw. vom System verschlüsselt geroutet,
 * keine INTERNET-Berechtigung der App). Übertragen wird genau der
 * Widget-Stand (Format v1) — mit „Beträge ausblenden“ also ohne Beträge.
 * Pfade und Schlüssel nie ändern: Uhr und Handy können verschiedene
 * App-Versionen haben.
 */
object WatchProtocol {
    /** DataItem mit dem aktuellen Widget-Stand. */
    const val PATH_PAYLOAD = "/mai_budget/widgets"

    /** Nachricht der Uhr: bitte aktuellen Stand schicken. */
    const val PATH_REQUEST = "/mai_budget/request"

    const val KEY_PAYLOAD = "payload"

    /** Fähigkeit der Uhr-App (`res/values/wear.xml` im Modul `wear`). */
    const val CAPABILITY_WATCH = "mai_budget_watch"
}
