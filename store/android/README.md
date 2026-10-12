# Play Store: Store-Eintrag für Budget

Alles, was du in der Play Console unter **Wachstum → Store-Präsenz →
Haupteintrag im Play Store** brauchst. Deutsch (`de-DE`) ist die
Standardsprache, Englisch (`en-US`) fügst du als Übersetzung hinzu
(„Übersetzungen verwalten → Eigene Übersetzungen hinzufügen“).

| Play-Console-Feld | Datei | Grenze |
|---|---|---|
| App-Name | `de-DE/title.txt`, `en-US/title.txt` | 30 Zeichen |
| Kurzbeschreibung | `…/short-description.txt` | 80 Zeichen |
| Vollständige Beschreibung | `…/full-description.txt` | 4000 Zeichen |
| App-Symbol | `icon-512.png` (512 × 512, PNG mit Alpha, für beide Sprachen) | 1 MB |
| Feature-Grafik | `…/feature-graphic.png` (1024 × 500) | 15 MB |
| Screenshots → Smartphone | `…/phone-screenshots/1-…6-*.png` (1080 × 1920), in dieser Reihenfolge | 2–8 Stück |
| Release → Versionshinweise | `…/release-notes.txt` (in `<de-DE>…</de-DE>` bzw. `<en-US>…</en-US>`) | 500 Zeichen |

`test/store/store_texts_test.dart` prüft die Zeichengrenzen bei jedem
`flutter test`.

## Weitere Angaben im Store-Eintrag

- **App-Kategorie:** App · Finanzen
- **Tags:** Budget, Haushaltsbuch, Finanzplanung (aus Googles Liste wählen)
- **Kontaktdaten:** E-Mail `joel@maispace.de`, Entwicklername `maispace`
  (Name Joël Maximilian Mai). Website optional.
- **Datenschutzerklärung, Datensicherheit, Altersfreigabe usw.:** stehen im
  Material des Datenschutz-Threads (`play-store/budget/play-console.md` in
  den Projektdateien), URL
  `https://mai-space.github.io/mai-budget-planer/datenschutz/`.

## Wear OS

Die Beschreibung nennt unter „Widgets und Uhr“ die Wear-OS-Kacheln. Wenn du
die Uhr-App (`mai-budget-planer-wear.apk`) nicht gleich mit veröffentlichst,
lösche die Zeile „Wear OS: …“ und den letzten Punkt unter „Datenschutz“
(„Zur Uhr gelangen …“) vor dem Einfügen.

## Wie die Bilder entstanden sind

Keine echten Daten: Die Screenshots zeigen den frei erfundenen
Beispielhaushalt „Alex“ und „Sam“ (Zahlen, Konten und Posten stehen in
`test/store/store_assets_test.dart`). Sie wurden ohne Gerät erzeugt: ein
Flutter-Widget-Test startet die echte App mit einer Datenbank im
Arbeitsspeicher, lädt Roboto und Material Icons aus dem Flutter-SDK und
speichert die Bildschirme als PNG. Darum fehlt die Statusleiste oben, sonst
sind es die echten Bildschirme. Die Feature-Grafik setzt der gleiche Test aus
Logo, Text und dem Übersicht-Screenshot zusammen.

Neu erzeugen (z. B. nach Änderungen an der Oberfläche):

```bash
flutter test test/store/store_assets_test.dart --dart-define=STORE_ASSETS=true
```

„Demnächst fällig“ hängt vom aktuellen Monat ab; die Bilder ändern sich also
leicht, je nachdem wann du sie erzeugst.

Das App-Symbol kommt aus derselben Vorlage wie das Launcher-Icon:

```bash
pip install cairosvg && python3 tool/generate_icons.py
```
