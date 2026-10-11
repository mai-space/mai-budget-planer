# Mai Budget Planer — Hinweise für Änderungen

Lokaler, verschlüsselter Budgetplaner (Flutter, Android). Gleiche Prinzipien
und gleicher Stack wie Mai Doctor Hub. UI Deutsch/Englisch nach Systemsprache.

## Datenschutz (Pflicht)

- **Keine echten Finanzdaten ins Repo** — keine Tabellen, Exporte,
  Sicherungen, Screenshots mit echten Zahlen. Testdaten sind frei erfunden
  (Beispielhaushalt „Alex“/„Sam“). `.gitignore` blockt `*.xlsx`, `*.csv`,
  `*.maibudget` usw. — nicht aufweichen.
- Keine INTERNET-Berechtigung im Release-Manifest, kein Android-Backup
  (`allowBackup=false`, `data_extraction_rules.xml`), keine Analytics.

## Rückwärtskompatibilität (sobald es echte Nutzer gibt)

- **Datenbank (drift, `lib/data/app_database.dart`)**
  - Nur additive Migrationen: neue Tabellen, neue Spalten *nullable oder mit
    Default*. Niemals Spalten/Tabellen löschen, umbenennen oder Typ ändern.
  - Jede Änderung: `schemaVersion` +1 und ein eigener Block `if (from < n)`
    in `onUpgrade` (strikt aufsteigend, alte Blöcke nie ändern).
  - Vor der Änderung das alte Schema als `test/migrations/v<alt>.sql`
    sichern (= `test/schema/current.sql`) und einen Migrationstest
    `v<alt> → v<neu>` mit Bestandsdaten ergänzen.
  - Enums (`intEnum`) nur am Ende erweitern — gespeichert wird der Index.
  - `CategoryKey`-Werte nie umbenennen (Regeln in `insights.dart` hängen dran).
  - Danach: `dart run build_runner build --delete-conflicting-outputs` und
    `UPDATE_SCHEMA=1 flutter test test/schema_contract_test.dart`.
- **Sicherungen (`packages/mai_backup_format`, `backup_service_io.dart`)** —
  ältere Sicherungen müssen wiederherstellbar bleiben (Restore migriert).
  Manifest nur erweitern; `app` bleibt `mai_budget_planer`.
- **Beträge** immer als `int` Cent speichern; Umrechnung auf Monat nur in
  `domain/budget.dart` (`monthlyOf`).

## Arbeitsweise

- Rechenlogik und Tipps sind reines Dart (`lib/domain/`) und vollständig
  getestet — neue Regeln immer mit Test in `test/insights_test.dart`.
- Strings: `lib/l10n/parts/<bereich>.<de|en>.json` (neue Schlüssel anhängen),
  dann `python3 tool/merge_arb.py && flutter gen-l10n`.
- Prüfen vor jedem Commit: `flutter analyze` (sauber) und `flutter test`
  (komplett grün); bei Änderungen an `packages/mai_backup_format` dort
  `dart analyze --fatal-infos && dart test`.
- Kein `dart format` auf ganze bestehende Dateien (erzeugt fremde Diffs).
- Kommentare im Code auf Deutsch.
