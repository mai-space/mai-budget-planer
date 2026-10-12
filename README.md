# Mai Budget Planer

Lokaler Haushalts- und Budgetplaner — **Privacy first**, auf Deutsch und
Englisch. Gleiche Prinzipien und gleicher Stack wie Mai Doctor Hub: alle
Daten verschlüsselt auf dem Gerät, kein Account, kein Server, keine
Bankanbindung.

> Erster Entwurf (v0.1). Konzept, Herleitung aus der bisherigen Tabelle und
> Roadmap: [`project-docs/KONZEPT.md`](project-docs/KONZEPT.md)

## Features

- **Übersicht:** Nettoeinkommen, geplante Posten, frei verfügbar (gesamt und
  je Person), Budgetregel 50/30/20 (anpassbar), Summen je Bereich,
  Rücklage für Jahreszahlungen, demnächst fällige Posten; Umschalter
  Monat/Jahr
- **Posten:** Fixkosten, Versicherungen, Abos, Lebensmittel, Wünsche und
  Sparraten mit Rhythmus (monatlich … jährlich), wer zahlt, für wen, von
  welchem Konto, Unterkategorie, Anbieter, Vertragsnummer, Telefon,
  Fälligkeit, eigenes Sparpotenzial. Betragsfeld rechnet wie eine Tabelle
  (`2,49 + 2,49 + 5`, `195,05 / 12`). Vorschläge für typische Posten
- **Verteiler:** Daueraufträge je Person auf Konten/Unterkonten, Rest aufs
  Hauptkonto; fairer Ausgleich zwischen Partnern (nach Einkommen, hälftig
  oder „gleiches Restgeld“); Sparkonten-Prognose mit Zinseszins
- **Tipps:** regelbasierte Optimierungsvorschläge (Defizit, Budgetregel,
  doppelte Verträge, parallele Streaming-Abos, unterjährige
  Versicherungszahlung, Zins, Notgroschen, größter Wunsch-Posten, Posten
  ohne Betrag/Konto, Jahresrücklage) mit geschätzter Ersparnis
- **Einstellungen:** Haushalt & Einkommen (netto/brutto), Konten, Bereiche
  mit Topf, Budgetregel, App-Sperre, verschlüsselte Sicherung
- **Wear OS (Modul `android/wear`, eigenes APK für die Uhr):** Kacheln
  „Frei verfügbar“ und „Demnächst fällig“, Komplikationen „Frei“ und
  „Nächste Zahlung“ — gleicher Stand wie die Startbildschirm-Widgets,
  „Beträge ausblenden“ gilt auch dort

## Stack

- Flutter (Android; Web nur zum UI-Debuggen)
- Drift / SQLite3 Multiple Ciphers (verschlüsselt), Schlüssel im Android
  Keystore (`DatabaseKeyChannel.kt`)
- App-Sperre per Biometrie/Geräte-PIN, `FLAG_SECURE`
- Sicherung `.maibudget`: AES-256-GCM / PBKDF2 (`packages/mai_backup_format`,
  gleiches Container-Format wie Mai Doctor Hub)

## Entwicklung

```bash
flutter pub get
flutter analyze
flutter test
(cd packages/mai_backup_format && dart test)

# nach Schema-Änderungen
dart run build_runner build --delete-conflicting-outputs
UPDATE_SCHEMA=1 flutter test test/schema_contract_test.dart

# nach Text-Änderungen
python3 tool/merge_arb.py && flutter gen-l10n

flutter run -d android
flutter build apk --release
```

## Release (Play Store)

Auf `main` baut die CI zusätzlich ein mit deinem Upload-Schlüssel
signiertes App-Bundle (`mai-budget-planer.aab`, Uhr:
`mai-budget-planer-wear.aab`, Artefakte des Laufs), sobald die vier
Secrets unten gesetzt sind. Ohne Secrets läuft alles wie bisher (APKs mit
Debug-Key). In Pull Requests prüft ein Probelauf mit Wegwerf-Schlüssel die
Signatur, lädt aber nichts hoch. Store-Texte und Grafiken:
[`store/android/`](store/android/README.md).

**1. Upload-Schlüssel einmalig erzeugen** (lokal, nicht im Repo-Ordner):

```bash
keytool -genkeypair -v -keystore ~/mai-upload-keystore.jks -alias upload \
  -keyalg RSA -keysize 2048 -validity 10000
```

Keystore und Passwörter sicher aufbewahren (Passwort-Manager). Bei Play App
Signing verwaltet Google den eigentlichen App-Schlüssel; geht der
Upload-Schlüssel verloren, lässt er sich über die Play Console zurücksetzen.

**2. Secrets anlegen** unter GitHub → Repo → Settings → Secrets and
variables → Actions → New repository secret:

| Secret | Inhalt |
|---|---|
| `ANDROID_KEYSTORE_BASE64` | `base64 -w0 ~/mai-upload-keystore.jks` (macOS: `base64 -i ~/mai-upload-keystore.jks`) |
| `ANDROID_KEYSTORE_PASSWORD` | Passwort des Keystores |
| `ANDROID_KEY_ALIAS` | `upload` (bzw. dein Alias) |
| `ANDROID_KEY_PASSWORD` | Passwort des Schlüssels (bei PKCS12 = Keystore-Passwort) |

**3. Lokal signiert bauen** (optional): `android/key.properties` anlegen
(steht in `.gitignore`):

```properties
storeFile=/home/du/mai-upload-keystore.jks
storePassword=…
keyAlias=upload
keyPassword=…
```

Dann `flutter build appbundle --release` und für die Uhr
`(cd android && ./gradlew :wear:bundleRelease)`. Mit
`REQUIRE_RELEASE_SIGNING=true` bricht der Build ab, statt mit dem Debug-Key
zu signieren, falls `key.properties` fehlt. Vor jedem Upload
`version:` in `pubspec.yaml` erhöhen (die Zahl nach `+` ist der
versionCode).

## Privacy

- Daten nur in der verschlüsselten SQLite-Datei der App-Sandbox
- **Keine INTERNET-Berechtigung** im Release (Handy und Uhr, CI prüft
  das), kein Google-Backup, kein Gerätetransfer; Umzug nur per
  passwortgeschützter Sicherung
- Uhr: Nur wenn die Budget-App auf einer gekoppelten Wear-OS-Uhr
  installiert ist, geht der Widget-Stand über die Wearable Data Layer der
  Google-Play-Dienste dorthin (ohne Uhr-App wird er dort gelöscht)
- Echte Finanzdaten (Tabellen, Exporte, Sicherungen) gehören nie ins Repo —
  `.gitignore` blockt die üblichen Formate
