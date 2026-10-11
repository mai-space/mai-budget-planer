# Konzept — Mai Budget Planer

## Ausgangspunkt

Vorlage war eine Haushalts-Tabelle mit diesen Blättern (nur Struktur
übernommen, **keine Inhalte**):

| Tabellenblatt | In der App |
|---|---|
| Übersicht (Monat/Jahr, „mögliche Ersparnis“, Rest „sollte 0 sein“) | Tab **Übersicht**, Umschalter Monat/Jahr, „Frei verfügbar“ statt manueller Restzeile |
| Einkommen (je Person brutto/netto, Steuerquote) | **Haushalt & Einkommen**: beliebig viele Einkommen je Person, Abzugsquote aus Brutto/Netto |
| Einkommensverteiler (Person × Konto, Tagesgeld-Zinsen) | Tab **Verteiler**: Daueraufträge je Person/Konto, Rest aufs Hauptkonto, Zinsprognose |
| Ausgaben (Summen je Bereich) | Karte **Bereiche** in der Übersicht |
| Wohnen, Versicherungen, KFZ, Kommunikation, Abos, Kontoführung, Lebensmittel, Sparen | **Bereiche** (Standardkategorien, frei änderbar) mit **Posten** |
| Spalten „Wer zahlt“, „Kategorie“, Versicherungsname/-nummer/Telefon, „Mögliche Ersparnis“ | Felder am Posten: Wer zahlt, Unterkategorie, Anbieter, Vertragsnummer, Telefon, Sparpotenzial |
| „Unsere Verteilung“ vs. „Empfohlene Verteilung 50/30/20“ | **Budgetregel** mit Ist/Ziel-Balken, Regel anpassbar |

## Was die App gegenüber der Tabelle besser macht

1. **Rhythmus statt Formel.** Jahresbeiträge werden als „120 € jährlich“
   erfasst, nicht als `=120/12`. Daraus folgen automatisch Monatswert,
   Jahresrücklage und Fälligkeiten.
2. **Keine festen Zahlen in Formeln.** Ziel-Werte wurden in der Tabelle
   teils als Konstanten eingetragen und veralten; in der App ist alles aus
   den Posten abgeleitet.
3. **Kein Selbstkontroll-Feld nötig.** „Rest (sollte 0 sein)“ ist per
   Konstruktion immer 0; die App zeigt stattdessen, was wirklich frei ist —
   gesamt und je Person.
4. **Topf je Posten.** Ein Posten kann vom Topf seiner Kategorie abweichen
   (z. B. Genussmittel unter „Lebensmittel“ zählen als Wunsch) — sonst ist
   die 50/30/20-Auswertung verzerrt.
5. **Zweckrücklagen sind Sparen.** Urlaub, Geschenke, Tier-Rücklage laufen
   als Sparposten auf eigene Unterkonten und zählen in die Sparquote.
6. **Zinsen richtig.** Statt „Monatsbetrag × 1,0075“ rechnet die Prognose
   mit monatlicher Verzinsung und Startguthaben.
7. **Fairer Ausgleich.** Wer zahlt und für wen ist getrennt; die App
   berechnet die Ausgleichszahlung nach Einkommen, hälftig oder so, dass
   beide gleich viel Restgeld haben.
8. **Sensible Vertragsdaten** (Versicherungsnummern, Telefon) liegen
   verschlüsselt statt in einer Datei, die per Mail/Cloud herumgeht.

## Datenmodell (Schema v1)

- `persons` — Haushaltsmitglieder
- `incomes` — Einkommen je Person (netto, optional brutto, Rhythmus)
- `accounts` — Konten/Unterkonten (Art, Inhaber, Hauptkonto, Zins, Stand)
- `categories` — Bereiche mit Topf (Grundbedarf/Wünsche/Sparen), `system_key`
  für Standardkategorien
- `budget_items` — Posten (Betrag in Cent, Rhythmus, Zahler, Begünstigter,
  Konto, Topf-Override, Unterkategorie, Anbieter, Vertragsnr., Telefon,
  Fälligkeitsmonat, Sparpotenzial, Sparziel, Notizen)
- `app_settings` — Onboarding, App-Sperre, Budgetregel, Aufteilungsmodus

Alles mit Soft Delete (`archived_at`). Beträge in Cent, Monatswerte nur
berechnet.

## Optimierungsregeln (Tab „Tipps“)

Rein lokal, deterministisch, getestet (`lib/domain/insights.dart`):

| Regel | Auslöser | Geschätzte Ersparnis |
|---|---|---|
| Defizit | Posten > Einkommen | — (Warnung) |
| Grundbedarf über Ziel | Anteil > Regel | Differenz zum Ziel |
| Sparquote unter Ziel | Anteil < Regel | fehlender Betrag |
| Markierte Sparpotenziale | Feld „mögliche Ersparnis“ gesetzt | Summe |
| Doppelter Vertrag | gleicher Name mehrfach (z. B. Fitness für beide) | — (Partnertarif prüfen) |
| Parallele Abos | ≥ 2 Abos gleicher Unterkategorie | alle außer dem teuersten |
| Unterjährige Versicherung | Versicherung monatlich/quartalsweise | ~4 % (Ratenzuschlag) |
| Niedriger Zins | Sparkonto < 2 % mit Einzahlung/Guthaben | Zinsdifferenz |
| Notgroschen | Guthaben < 3 × Grundbedarf/Monat | — |
| Größter Wunsch | Wunsch-Posten ≥ 5 % des Einkommens | — |
| Posten ohne Betrag / ohne Konto | 0 € bzw. kein Konto | — |
| Jahresrücklage | nicht monatliche Posten vorhanden | — (Betrag/Monat) |

## Roadmap (Vorschläge)

1. **Import aus der Tabelle** (einmalig, lokal): CSV/XLSX-Datei auswählen,
   Spalten zuordnen, Vorschau — Datei wird nie gespeichert.
2. **Ist-Erfassung**: Monatsabschluss „geplant vs. tatsächlich“ für
   variable Posten (Lebensmittel, Sprit), Verlauf als Diagramm.
3. **Erinnerungen** (lokal, wie Doctor Hub): Kündigungsfristen,
   Fälligkeiten von Jahresbeiträgen, Vertragsende von Tarifen mit
   Preissprung nach 24 Monaten.
4. **Sparziele mit Datum**: „Urlaub 3.000 € bis Juli“ → nötige Rate.
5. **Steuer-Helfer**: Posten als „absetzbar“ markieren (Arbeitsmittel,
   Versicherungen, Freelancer-Kosten) → Jahresliste für die Steuererklärung.
6. **Inflation/Preisänderungen**: Historie je Posten, Hinweis bei
   Preiserhöhungen.
7. **iOS**: Schlüsselbund-Kanal und `SecureWindow` wie in Doctor Hub.
8. **Gemeinsame Nutzung zu zweit** ohne Server: verschlüsselte Sicherung
   austauschen oder später lokaler Sync.
9. ~~App-Icon~~ — erledigt (`tool/generate_icons.py`).
