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
