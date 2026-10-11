import 'dart:async';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../domain/budget.dart';
import '../app_database.dart';

const _uuid = Uuid();

/// Kategorien, Posten und der zusammengefasste [BudgetSnapshot].
class BudgetRepository {
  BudgetRepository(this._db);

  final AppDatabase _db;

  /// Aktueller Stand; neu bei jeder Änderung an einer der Tabellen.
  Stream<BudgetSnapshot> watchSnapshot() {
    final updates = _db.tableUpdates(
      TableUpdateQuery.onAllTables([
        _db.persons,
        _db.incomes,
        _db.accounts,
        _db.categories,
        _db.budgetItems,
        _db.appSettings,
      ]),
    );
    late StreamController<BudgetSnapshot> controller;
    StreamSubscription<void>? sub;
    var loading = false, again = false;
    Future<void> load() async {
      // Änderungen während des Ladens zusammenfassen.
      if (loading) {
        again = true;
        return;
      }
      loading = true;
      try {
        do {
          again = false;
          final snapshot = await this.snapshot();
          if (!controller.isClosed) controller.add(snapshot);
        } while (again);
      } catch (e, st) {
        if (!controller.isClosed) controller.addError(e, st);
      } finally {
        loading = false;
      }
    }

    controller = StreamController<BudgetSnapshot>(
      onListen: () {
        load();
        sub = updates.listen((_) => load());
      },
      onCancel: () => sub?.cancel(),
    );
    return controller.stream;
  }

  Future<BudgetSnapshot> snapshot() async {
    final persons =
        await (_db.select(_db.persons)
              ..where((t) => t.archivedAt.isNull())
              ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
            .get();
    final incomes = await (_db.select(
      _db.incomes,
    )..where((t) => t.archivedAt.isNull())).get();
    final accounts =
        await (_db.select(_db.accounts)
              ..where((t) => t.archivedAt.isNull())
              ..orderBy([(t) => OrderingTerm.asc(t.name)]))
            .get();
    final categories =
        await (_db.select(_db.categories)
              ..where((t) => t.archivedAt.isNull())
              ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
            .get();
    final items =
        await (_db.select(_db.budgetItems)
              ..where((t) => t.archivedAt.isNull())
              ..orderBy([(t) => OrderingTerm.asc(t.label)]))
            .get();
    final settings = await (_db.select(
      _db.appSettings,
    )..where((t) => t.id.equals(1))).getSingle();
    return BudgetSnapshot(
      persons: persons,
      incomes: incomes,
      accounts: accounts,
      categories: categories,
      items: items,
      settings: settings,
    );
  }

  // --- Kategorien ----------------------------------------------------------

  Future<String> saveCategory({
    String? id,
    required String name,
    required BudgetBucket bucket,
    String icon = 'category',
  }) async {
    final now = DateTime.now();
    if (id != null) {
      await (_db.update(_db.categories)..where((t) => t.id.equals(id))).write(
        CategoriesCompanion(
          name: Value(name.trim()),
          bucket: Value(bucket),
          icon: Value(icon),
          updatedAt: Value(now),
        ),
      );
      return id;
    }
    final last = await (_db.selectOnly(
      _db.categories,
    )..addColumns([_db.categories.sortOrder.max()])).getSingle();
    final key = _uuid.v4();
    await _db
        .into(_db.categories)
        .insert(
          CategoriesCompanion.insert(
            id: key,
            name: name.trim(),
            icon: Value(icon),
            bucket: bucket,
            sortOrder: Value(
              (last.read(_db.categories.sortOrder.max()) ?? -1) + 1,
            ),
            createdAt: now,
            updatedAt: now,
          ),
        );
    return key;
  }

  /// Nur leere Kategorien lassen sich archivieren; `false` sonst.
  Future<bool> archiveCategory(String id) => _db.transaction(() async {
    final used = await (_db.select(_db.budgetItems)
          ..where((t) => t.categoryId.equals(id) & t.archivedAt.isNull())
          ..limit(1))
        .get();
    if (used.isNotEmpty) return false;
    await (_db.update(_db.categories)..where((t) => t.id.equals(id))).write(
      CategoriesCompanion(archivedAt: Value(DateTime.now())),
    );
    return true;
  });

  // --- Posten --------------------------------------------------------------

  Future<BudgetItem?> item(String id) => (_db.select(
    _db.budgetItems,
  )..where((t) => t.id.equals(id))).getSingleOrNull();

  /// Legt einen Posten an ([BudgetItemsCompanion.id] fehlt) oder ändert ihn.
  Future<String> saveItem(BudgetItemsCompanion values) async {
    final now = DateTime.now();
    if (values.id.present) {
      final id = values.id.value;
      await (_db.update(_db.budgetItems)..where((t) => t.id.equals(id))).write(
        values.copyWith(updatedAt: Value(now)),
      );
      return id;
    }
    final id = _uuid.v4();
    await _db
        .into(_db.budgetItems)
        .insert(
          values.copyWith(
            id: Value(id),
            createdAt: Value(now),
            updatedAt: Value(now),
          ),
        );
    return id;
  }

  Future<void> archiveItem(String id) =>
      (_db.update(_db.budgetItems)..where((t) => t.id.equals(id))).write(
        BudgetItemsCompanion(archivedAt: Value(DateTime.now())),
      );

  Future<void> restoreItem(String id) =>
      (_db.update(_db.budgetItems)..where((t) => t.id.equals(id))).write(
        const BudgetItemsCompanion(archivedAt: Value(null)),
      );

  /// Bisher verwendete Unterkategorien (für Vorschläge).
  Future<List<String>> tags() async {
    final rows = await (_db.selectOnly(_db.budgetItems, distinct: true)
          ..addColumns([_db.budgetItems.tag])
          ..where(_db.budgetItems.tag.isNotNull()))
        .get();
    return [
      for (final r in rows)
        if (r.read(_db.budgetItems.tag) case final t? when t.trim().isNotEmpty)
          t,
    ]..sort();
  }
}
