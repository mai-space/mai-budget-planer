import 'app_database.dart';

/// Vorschlag für einen typischen Posten (ohne Beträge).
class CatalogEntry {
  const CatalogEntry(
    this.de,
    this.en,
    this.category, {
    this.interval = PayInterval.monthly,
    this.tag,
    this.bucket,
  });

  final String de;
  final String en;

  /// [CategoryKey] der Standardkategorie.
  final String category;
  final PayInterval interval;
  final String? tag;

  /// Abweichender Topf, falls nicht der der Kategorie.
  final BudgetBucket? bucket;

  String label(String languageCode) => languageCode == 'de' ? de : en;
}

/// Typische Haushaltsposten als Eingabehilfe — erweitert die
/// Autovervollständigung, ersetzt keine eigenen Einträge.
const itemCatalog = <CatalogEntry>[
  // Wohnen
  CatalogEntry('Miete', 'Rent', CategoryKey.housing),
  CatalogEntry('Nebenkosten', 'Service charges', CategoryKey.housing),
  CatalogEntry('Heizkosten', 'Heating', CategoryKey.housing),
  CatalogEntry('Strom', 'Electricity', CategoryKey.housing),
  CatalogEntry('Rundfunkbeitrag', 'TV licence', CategoryKey.housing),
  CatalogEntry('Hausgeld', 'Building fees', CategoryKey.housing),
  CatalogEntry('Kreditrate', 'Mortgage payment', CategoryKey.housing),
  // Versicherungen
  CatalogEntry(
    'Haftpflichtversicherung',
    'Liability insurance',
    CategoryKey.insurance,
    interval: PayInterval.yearly,
  ),
  CatalogEntry(
    'Hausratversicherung',
    'Home contents insurance',
    CategoryKey.insurance,
    interval: PayInterval.yearly,
  ),
  CatalogEntry(
    'Rechtsschutzversicherung',
    'Legal expenses insurance',
    CategoryKey.insurance,
    interval: PayInterval.yearly,
  ),
  CatalogEntry(
    'Berufsunfähigkeitsversicherung',
    'Disability insurance',
    CategoryKey.insurance,
  ),
  CatalogEntry(
    'Zahnzusatzversicherung',
    'Dental insurance',
    CategoryKey.insurance,
  ),
  CatalogEntry(
    'Auslandskrankenversicherung',
    'Travel health insurance',
    CategoryKey.insurance,
    interval: PayInterval.yearly,
  ),
  CatalogEntry(
    'Unfallversicherung',
    'Accident insurance',
    CategoryKey.insurance,
    interval: PayInterval.yearly,
  ),
  CatalogEntry(
    'Risikolebensversicherung',
    'Term life insurance',
    CategoryKey.insurance,
    interval: PayInterval.yearly,
  ),
  // Mobilität
  CatalogEntry(
    'Kfz-Versicherung',
    'Car insurance',
    CategoryKey.mobility,
    interval: PayInterval.yearly,
  ),
  CatalogEntry(
    'Kfz-Steuer',
    'Vehicle tax',
    CategoryKey.mobility,
    interval: PayInterval.yearly,
  ),
  CatalogEntry('Sprit', 'Fuel', CategoryKey.mobility),
  CatalogEntry(
    'Inspektion & Service',
    'Car service',
    CategoryKey.mobility,
    interval: PayInterval.yearly,
  ),
  CatalogEntry(
    'Schutzbrief',
    'Breakdown cover',
    CategoryKey.mobility,
    interval: PayInterval.yearly,
  ),
  CatalogEntry('Deutschlandticket', 'Public transport pass', CategoryKey.mobility),
  // Kommunikation
  CatalogEntry('Internet & Festnetz', 'Internet & landline', CategoryKey.communication),
  CatalogEntry('Mobilfunk', 'Mobile phone', CategoryKey.communication),
  // Abos
  CatalogEntry('Netflix', 'Netflix', CategoryKey.subscriptions, tag: 'Streaming'),
  CatalogEntry('Disney+', 'Disney+', CategoryKey.subscriptions, tag: 'Streaming'),
  CatalogEntry('Prime Video', 'Prime Video', CategoryKey.subscriptions, tag: 'Streaming'),
  CatalogEntry('WOW', 'WOW', CategoryKey.subscriptions, tag: 'Streaming'),
  CatalogEntry('Spotify', 'Spotify', CategoryKey.subscriptions),
  CatalogEntry('Fitnessstudio', 'Gym', CategoryKey.subscriptions, tag: 'Sport'),
  CatalogEntry(
    'Passwortmanager',
    'Password manager',
    CategoryKey.subscriptions,
    interval: PayInterval.yearly,
    tag: 'Software',
  ),
  CatalogEntry(
    'Cloud-Speicher',
    'Cloud storage',
    CategoryKey.subscriptions,
    tag: 'Software',
  ),
  CatalogEntry('Zeitung', 'Newspaper', CategoryKey.subscriptions),
  // Kontoführung
  CatalogEntry('Kontoführung', 'Account fees', CategoryKey.banking),
  CatalogEntry(
    'Kreditkarte',
    'Credit card fee',
    CategoryKey.banking,
    interval: PayInterval.yearly,
  ),
  CatalogEntry(
    'Steuersoftware',
    'Tax software',
    CategoryKey.banking,
    interval: PayInterval.yearly,
  ),
  // Lebensmittel & Haushalt
  CatalogEntry('Lebensmittel', 'Groceries', CategoryKey.groceries),
  CatalogEntry('Drogerie & Kosmetik', 'Toiletries', CategoryKey.groceries),
  CatalogEntry('Reinigung', 'Cleaning supplies', CategoryKey.groceries),
  CatalogEntry('Getränke', 'Drinks', CategoryKey.groceries),
  CatalogEntry('Tierfutter', 'Pet food', CategoryKey.groceries),
  CatalogEntry(
    'Genussmittel',
    'Treats & tobacco',
    CategoryKey.groceries,
    bucket: BudgetBucket.wants,
  ),
  // Freizeit & Wünsche
  CatalogEntry('Wünsche', 'Wishes', CategoryKey.leisure),
  CatalogEntry('Restaurant', 'Eating out', CategoryKey.leisure),
  CatalogEntry('Hobbys', 'Hobbies', CategoryKey.leisure),
  CatalogEntry('Kleidung', 'Clothing', CategoryKey.leisure),
  // Sparen
  CatalogEntry('Notgroschen', 'Emergency fund', CategoryKey.savings),
  CatalogEntry('Urlaub', 'Holiday', CategoryKey.savings),
  CatalogEntry('Geschenke', 'Gifts', CategoryKey.savings),
  CatalogEntry('Altersvorsorge', 'Retirement', CategoryKey.savings),
  CatalogEntry('ETF-Sparplan', 'ETF savings plan', CategoryKey.savings),
  CatalogEntry('Eigenheim', 'Home ownership', CategoryKey.savings),
  CatalogEntry('Tierarzt-Rücklage', 'Vet reserve', CategoryKey.savings),
  CatalogEntry('Auto-Rücklage', 'Car reserve', CategoryKey.savings),
];
