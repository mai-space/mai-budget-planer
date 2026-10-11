import 'package:drift/drift.dart';

import '../l10n/l10n.dart';
import 'connection/connection.dart';

part 'app_database.g.dart';

// Alle Enums werden als Index gespeichert (`intEnum`): neue Werte nur hinten
// anhängen, nie umsortieren oder löschen.

/// Zahlungsrhythmus eines Postens oder Einkommens.
enum PayInterval { monthly, quarterly, halfYearly, yearly, weekly }

/// Topf der Budgetregel (z. B. 50/30/20).
enum BudgetBucket { needs, wants, savings }

/// Art eines Kontos im Einkommensverteiler.
enum AccountKind { checking, savings, card, other }

/// Wie gemeinsame Kosten fair verteilt werden.
enum SplitMode {
  /// Anteilig nach Nettoeinkommen.
  proportional,

  /// Hälftig bzw. zu gleichen Teilen.
  equal,

  /// Jede Person behält am Ende gleich viel frei verfügbares Geld.
  equalRemainder,
}

/// Soft Delete: archivierte Zeilen sind überall ausgeblendet.
mixin Archivable on Table {
  DateTimeColumn get archivedAt => dateTime().nullable()();
}

/// Personen im Haushalt (z. B. zwei Partner).
class Persons extends Table with Archivable {
  TextColumn get id => text()();
  TextColumn get name => text()();

  /// Index in die Farbpalette der Oberfläche.
  IntColumn get colorIndex => integer().withDefault(const Constant(0))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Einkommensquelle einer Person (Gehalt, Nebenjob, Kindergeld …).
class Incomes extends Table with Archivable {
  TextColumn get id => text()();
  TextColumn get personId => text().references(Persons, #id)();
  TextColumn get label => text()();

  /// Netto je [interval] in Cent — Grundlage aller Rechnungen.
  IntColumn get netCents => integer()();

  /// Brutto je [interval] in Cent (optional, nur für die Abzugsquote).
  IntColumn get grossCents => integer().nullable()();
  IntColumn get interval =>
      intEnum<PayInterval>().withDefault(const Constant(0))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Konto oder Unterkonto, auf das Geld verteilt wird (Girokonto, Tagesgeld …).
class Accounts extends Table with Archivable {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get kind => intEnum<AccountKind>()();

  /// Inhaber; `null` = Gemeinschaftskonto.
  TextColumn get ownerPersonId =>
      text().nullable().references(Persons, #id)();

  /// Hauptkonto der Person: bekommt, was nach allen Posten übrig bleibt.
  BoolColumn get isMain => boolean().withDefault(const Constant(false))();

  /// Zinssatz in % p. a. (Tagesgeld).
  RealColumn get interestRate => real().nullable()();

  /// Aktueller Kontostand in Cent (optional, für Notgroschen/Prognose).
  IntColumn get balanceCents => integer().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Bereich wie „Wohnen“, „Versicherungen“, „Abos“.
class Categories extends Table with Archivable {
  TextColumn get id => text()();
  TextColumn get name => text()();

  /// Schlüssel der Standardkategorien (siehe `CategoryKey`); eigene = `null`.
  TextColumn get systemKey => text().nullable()();

  /// Symbol (Schlüssel aus `categoryIcons`).
  TextColumn get icon => text().withDefault(const Constant('category'))();
  IntColumn get bucket => intEnum<BudgetBucket>()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Wiederkehrender Posten: Ausgabe, Abo, Versicherung oder Sparrate.
class BudgetItems extends Table with Archivable {
  TextColumn get id => text()();
  TextColumn get categoryId => text().references(Categories, #id)();
  TextColumn get label => text()();

  /// Betrag je [interval] in Cent.
  IntColumn get amountCents => integer()();
  IntColumn get interval =>
      intEnum<PayInterval>().withDefault(const Constant(0))();

  /// Wer zahlt; `null` = Gemeinschaftskonto.
  @ReferenceName('paidItems')
  TextColumn get payerPersonId =>
      text().nullable().references(Persons, #id)();

  /// Für wen; `null` = für den ganzen Haushalt.
  @ReferenceName('benefitItems')
  TextColumn get beneficiaryPersonId =>
      text().nullable().references(Persons, #id)();

  /// Von welchem Konto abgebucht bzw. auf welches gespart wird.
  TextColumn get accountId => text().nullable().references(Accounts, #id)();

  /// Abweichender Topf (z. B. Genussmittel unter „Lebensmittel“ = Wunsch).
  IntColumn get bucketOverride => intEnum<BudgetBucket>().nullable()();

  /// Unterkategorie, z. B. „Streaming“, „Sport“.
  TextColumn get tag => text().nullable()();
  TextColumn get provider => text().nullable()();
  TextColumn get contractNumber => text().nullable()();
  TextColumn get phone => text().nullable()();

  /// Fälligkeitsmonat (1–12) bei nicht monatlichen Zahlungen.
  IntColumn get dueMonth => integer().nullable()();

  /// Selbst eingeschätzte mögliche Ersparnis je Monat in Cent.
  IntColumn get savingsPotentialCents => integer().nullable()();

  /// Sparziel in Cent (nur bei Sparposten sinnvoll).
  IntColumn get targetCents => integer().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Einzige Zeile (id = 1) mit App-Einstellungen.
class AppSettings extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  BoolColumn get onboardingCompleted =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get appLockEnabled =>
      boolean().withDefault(const Constant(false))();

  /// Budgetregel in Prozent des Nettoeinkommens.
  IntColumn get ruleNeeds => integer().withDefault(const Constant(50))();
  IntColumn get ruleWants => integer().withDefault(const Constant(30))();
  IntColumn get ruleSavings => integer().withDefault(const Constant(20))();
  IntColumn get splitMode =>
      intEnum<SplitMode>().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Schlüssel der Standardkategorien — stabil, nie umbenennen.
abstract final class CategoryKey {
  static const housing = 'housing';
  static const insurance = 'insurance';
  static const mobility = 'mobility';
  static const communication = 'communication';
  static const subscriptions = 'subscriptions';
  static const banking = 'banking';
  static const groceries = 'groceries';
  static const leisure = 'leisure';
  static const savings = 'savings';
}

@DriftDatabase(
  tables: [Persons, Incomes, Accounts, Categories, BudgetItems, AppSettings],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? openAppDatabase());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      await migrator.createAll();
      await into(appSettings).insert(AppSettingsCompanion.insert());
      await _insertDefaultCategories();
    },
    // Schritte strikt aufsteigend: jeder Block bringt v(n-1) → v(n).
    // Beispiel: if (from < 2) { await migrator.addColumn(...); }
    onUpgrade: (migrator, from, to) async {},
    beforeOpen: (details) async {
      // Einstellungszeile garantieren (z. B. nach Restore).
      await customStatement(
        'INSERT OR IGNORE INTO app_settings (id) VALUES (1)',
      );
    },
  );

  /// Standardkategorien in der Sprache beim ersten Start; danach frei
  /// umbenennbar.
  Future<void> _insertDefaultCategories() async {
    final l10n = AppLocale.strings;
    final now = DateTime.now();
    final defaults = [
      (CategoryKey.housing, l10n.catHousing, 'home', BudgetBucket.needs),
      (
        CategoryKey.insurance,
        l10n.catInsurance,
        'shield',
        BudgetBucket.needs,
      ),
      (CategoryKey.mobility, l10n.catMobility, 'car', BudgetBucket.needs),
      (
        CategoryKey.communication,
        l10n.catCommunication,
        'phone',
        BudgetBucket.needs,
      ),
      (
        CategoryKey.subscriptions,
        l10n.catSubscriptions,
        'subscriptions',
        BudgetBucket.wants,
      ),
      (CategoryKey.banking, l10n.catBanking, 'bank', BudgetBucket.needs),
      (
        CategoryKey.groceries,
        l10n.catGroceries,
        'cart',
        BudgetBucket.needs,
      ),
      (CategoryKey.leisure, l10n.catLeisure, 'leisure', BudgetBucket.wants),
      (CategoryKey.savings, l10n.catSavings, 'savings', BudgetBucket.savings),
    ];
    await batch((b) {
      for (final (i, (key, name, icon, bucket)) in defaults.indexed) {
        b.insert(
          categories,
          CategoriesCompanion.insert(
            id: 'cat_$key',
            name: name,
            systemKey: Value(key),
            icon: Value(icon),
            bucket: bucket,
            sortOrder: Value(i),
            createdAt: now,
            updatedAt: now,
          ),
        );
      }
    });
  }
}
