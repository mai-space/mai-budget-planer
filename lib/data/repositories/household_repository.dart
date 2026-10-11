import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../app_database.dart';

const _uuid = Uuid();

/// Personen, Einkommen und Konten.
class HouseholdRepository {
  HouseholdRepository(this._db);

  final AppDatabase _db;

  // --- Personen ------------------------------------------------------------

  Future<List<Person>> persons() => (_db.select(_db.persons)
        ..where((t) => t.archivedAt.isNull())
        ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
      .get();

  Future<String> addPerson(String name) async {
    final now = DateTime.now();
    final existing = await persons();
    final id = _uuid.v4();
    await _db
        .into(_db.persons)
        .insert(
          PersonsCompanion.insert(
            id: id,
            name: name.trim(),
            colorIndex: Value(existing.length),
            sortOrder: Value(existing.length),
            createdAt: now,
            updatedAt: now,
          ),
        );
    return id;
  }

  Future<void> renamePerson(String id, String name) =>
      (_db.update(_db.persons)..where((t) => t.id.equals(id))).write(
        PersonsCompanion(
          name: Value(name.trim()),
          updatedAt: Value(DateTime.now()),
        ),
      );

  /// Archiviert die Person mit ihren Einkommen und Konten. Posten, die sie
  /// bezahlt oder die für sie sind, gelten danach als gemeinsam.
  Future<void> archivePerson(String id) => _db.transaction(() async {
    final now = DateTime.now();
    await (_db.update(_db.persons)..where((t) => t.id.equals(id))).write(
      PersonsCompanion(archivedAt: Value(now), updatedAt: Value(now)),
    );
    await (_db.update(_db.incomes)..where((t) => t.personId.equals(id)))
        .write(IncomesCompanion(archivedAt: Value(now)));
    await (_db.update(_db.accounts)..where((t) => t.ownerPersonId.equals(id)))
        .write(AccountsCompanion(archivedAt: Value(now)));
    await (_db.update(_db.budgetItems)
          ..where((t) => t.payerPersonId.equals(id)))
        .write(const BudgetItemsCompanion(payerPersonId: Value(null)));
    await (_db.update(_db.budgetItems)
          ..where((t) => t.beneficiaryPersonId.equals(id)))
        .write(const BudgetItemsCompanion(beneficiaryPersonId: Value(null)));
  });

  // --- Einkommen -----------------------------------------------------------

  Future<String> saveIncome({
    String? id,
    required String personId,
    required String label,
    required int netCents,
    int? grossCents,
    PayInterval interval = PayInterval.monthly,
    String? notes,
  }) async {
    final now = DateTime.now();
    final key = id ?? _uuid.v4();
    final values = IncomesCompanion(
      personId: Value(personId),
      label: Value(label.trim()),
      netCents: Value(netCents),
      grossCents: Value(grossCents),
      interval: Value(interval),
      notes: Value(_blankToNull(notes)),
      updatedAt: Value(now),
    );
    if (id == null) {
      await _db
          .into(_db.incomes)
          .insert(values.copyWith(id: Value(key), createdAt: Value(now)));
    } else {
      await (_db.update(_db.incomes)..where((t) => t.id.equals(id))).write(
        values,
      );
    }
    return key;
  }

  Future<void> archiveIncome(String id) =>
      (_db.update(_db.incomes)..where((t) => t.id.equals(id))).write(
        IncomesCompanion(archivedAt: Value(DateTime.now())),
      );

  // --- Konten --------------------------------------------------------------

  Future<String> saveAccount({
    String? id,
    required String name,
    required AccountKind kind,
    String? ownerPersonId,
    bool isMain = false,
    double? interestRate,
    int? balanceCents,
    String? notes,
  }) => _db.transaction(() async {
    final now = DateTime.now();
    final key = id ?? _uuid.v4();
    // Nur ein Hauptkonto je Person.
    if (isMain && ownerPersonId != null) {
      await (_db.update(_db.accounts)
            ..where((t) => t.ownerPersonId.equals(ownerPersonId)))
          .write(const AccountsCompanion(isMain: Value(false)));
    }
    final values = AccountsCompanion(
      name: Value(name.trim()),
      kind: Value(kind),
      ownerPersonId: Value(ownerPersonId),
      isMain: Value(isMain && ownerPersonId != null),
      interestRate: Value(interestRate),
      balanceCents: Value(balanceCents),
      notes: Value(_blankToNull(notes)),
      updatedAt: Value(now),
    );
    if (id == null) {
      await _db
          .into(_db.accounts)
          .insert(values.copyWith(id: Value(key), createdAt: Value(now)));
    } else {
      await (_db.update(_db.accounts)..where((t) => t.id.equals(id))).write(
        values,
      );
    }
    return key;
  });

  /// Archiviert das Konto; Posten darauf verlieren die Zuordnung.
  Future<void> archiveAccount(String id) => _db.transaction(() async {
    await (_db.update(_db.accounts)..where((t) => t.id.equals(id))).write(
      AccountsCompanion(archivedAt: Value(DateTime.now())),
    );
    await (_db.update(_db.budgetItems)..where((t) => t.accountId.equals(id)))
        .write(const BudgetItemsCompanion(accountId: Value(null)));
  });

  /// Ersteinrichtung: Personen mit Nettoeinkommen und je einem Hauptkonto.
  Future<void> setUpHousehold(
    List<({String name, int netCents})> members, {
    required String Function(String name) mainAccountName,
    required String incomeLabel,
  }) => _db.transaction(() async {
    for (final member in members) {
      final id = await addPerson(member.name);
      if (member.netCents > 0) {
        await saveIncome(
          personId: id,
          label: incomeLabel,
          netCents: member.netCents,
        );
      }
      await saveAccount(
        name: mainAccountName(member.name.trim()),
        kind: AccountKind.checking,
        ownerPersonId: id,
        isMain: true,
      );
    }
  });
}

String? _blankToNull(String? value) {
  final trimmed = value?.trim();
  return trimmed == null || trimmed.isEmpty ? null : trimmed;
}
