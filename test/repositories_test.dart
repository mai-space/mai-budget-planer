import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mai_budget_planer/data/app_database.dart';
import 'package:mai_budget_planer/data/repositories/budget_repository.dart';
import 'package:mai_budget_planer/data/repositories/household_repository.dart';
import 'package:mai_budget_planer/data/repositories/settings_repository.dart';
import 'package:mai_budget_planer/domain/budget.dart';

void main() {
  late AppDatabase db;
  late HouseholdRepository household;
  late BudgetRepository budget;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    household = HouseholdRepository(db);
    budget = BudgetRepository(db);
  });
  tearDown(() => db.close());

  Future<void> setUpCouple() => household.setUpHousehold(
    [(name: ' Alex ', netCents: 300000), (name: 'Sam', netCents: 0)],
    mainAccountName: (n) => 'Giro $n',
    incomeLabel: 'Gehalt',
  );

  test('fresh database has settings and localized default categories', () async {
    final s = await budget.snapshot();
    expect(s.settings.onboardingCompleted, isFalse);
    expect(s.settings.ruleNeeds + s.settings.ruleWants + s.settings.ruleSavings, 100);
    expect(s.categories.map((c) => c.systemKey), [
      CategoryKey.housing,
      CategoryKey.insurance,
      CategoryKey.mobility,
      CategoryKey.communication,
      CategoryKey.subscriptions,
      CategoryKey.banking,
      CategoryKey.groceries,
      CategoryKey.leisure,
      CategoryKey.savings,
    ]);
    // Tests laufen auf einem deutschen Gerät.
    expect(s.categories.first.name, 'Wohnen');
    expect(
      s.categories.firstWhere((c) => c.systemKey == CategoryKey.savings).bucket,
      BudgetBucket.savings,
    );
  });

  test('household setup creates people, incomes and main accounts', () async {
    await setUpCouple();
    final s = await budget.snapshot();
    expect(s.persons.map((p) => p.name), ['Alex', 'Sam']);
    expect(s.persons.map((p) => p.colorIndex), [0, 1]);
    expect(s.incomes.single.netCents, 300000);
    expect(s.accounts.map((a) => (a.name, a.isMain)), [
      ('Giro Alex', true),
      ('Giro Sam', true),
    ]);
  });

  test('only one main account per person', () async {
    await setUpCouple();
    final alex = (await household.persons()).first;
    await household.saveAccount(
      name: 'Neues Giro',
      kind: AccountKind.checking,
      ownerPersonId: alex.id,
      isMain: true,
    );
    final s = await budget.snapshot();
    final mains = s.accounts.where(
      (a) => a.ownerPersonId == alex.id && a.isMain,
    );
    expect(mains.single.name, 'Neues Giro');
    expect(s.plans.first.mainAccount?.name, 'Neues Giro');
  });

  test('items: create, edit, archive, restore', () async {
    await setUpCouple();
    final alex = (await household.persons()).first;
    final id = await budget.saveItem(
      BudgetItemsCompanion(
        categoryId: Value('cat_${CategoryKey.insurance}'),
        label: const Value('Haftpflicht'),
        amountCents: const Value(6000),
        interval: const Value(PayInterval.yearly),
        payerPersonId: Value(alex.id),
      ),
    );
    var s = await budget.snapshot();
    expect(BudgetSnapshot.monthly(s.items.single), 500);

    await budget.saveItem(
      BudgetItemsCompanion(id: Value(id), amountCents: const Value(12000)),
    );
    expect((await budget.item(id))!.amountCents, 12000);

    await budget.archiveItem(id);
    s = await budget.snapshot();
    expect(s.items, isEmpty);
    await budget.restoreItem(id);
    s = await budget.snapshot();
    expect(s.items.single.label, 'Haftpflicht');
  });

  test('archiving a person keeps their items as shared', () async {
    await setUpCouple();
    final sam = (await household.persons()).last;
    await budget.saveItem(
      BudgetItemsCompanion(
        categoryId: Value('cat_${CategoryKey.subscriptions}'),
        label: const Value('Musik'),
        amountCents: const Value(1100),
        payerPersonId: Value(sam.id),
        beneficiaryPersonId: Value(sam.id),
      ),
    );
    await household.archivePerson(sam.id);
    final s = await budget.snapshot();
    expect(s.persons.map((p) => p.name), ['Alex']);
    expect(s.accounts.map((a) => a.name), ['Giro Alex']);
    expect(s.items.single.payerPersonId, isNull);
    expect(s.items.single.beneficiaryPersonId, isNull);
  });

  test('archiving an account detaches its items', () async {
    await setUpCouple();
    final giro = (await budget.snapshot()).accounts.first;
    await budget.saveItem(
      BudgetItemsCompanion(
        categoryId: Value('cat_${CategoryKey.housing}'),
        label: const Value('Miete'),
        amountCents: const Value(90000),
        accountId: Value(giro.id),
      ),
    );
    await household.archiveAccount(giro.id);
    expect((await budget.snapshot()).items.single.accountId, isNull);
  });

  test('only empty categories can be archived', () async {
    final id = await budget.saveCategory(
      name: 'Haustier',
      bucket: BudgetBucket.needs,
      icon: 'pets',
    );
    final cats = (await budget.snapshot()).categories;
    expect(cats.last.id, id);
    expect(cats.last.sortOrder, cats[cats.length - 2].sortOrder + 1);

    await budget.saveItem(
      BudgetItemsCompanion(
        categoryId: Value(id),
        label: const Value('Futter'),
        amountCents: const Value(4000),
      ),
    );
    expect(await budget.archiveCategory(id), isFalse);
    final itemId = (await budget.snapshot()).items.single.id;
    await budget.archiveItem(itemId);
    expect(await budget.archiveCategory(id), isTrue);
  });

  test('settings: budget rule must add up to 100', () async {
    final settings = SettingsRepository(db);
    await settings.setRule(needs: 60, wants: 20, savings: 20);
    expect((await settings.get()).ruleNeeds, 60);
    expect(
      () => settings.setRule(needs: 60, wants: 30, savings: 20),
      throwsArgumentError,
    );
    await settings.setSplitMode(SplitMode.equalRemainder);
    expect((await settings.get()).splitMode, SplitMode.equalRemainder);
  });

  test('snapshot stream emits on every change', () async {
    final stream = budget.watchSnapshot();
    final seen = <int>[];
    final sub = stream.listen((s) => seen.add(s.persons.length));
    await pumpEventQueue();
    await household.addPerson('Alex');
    await pumpEventQueue();
    await household.addPerson('Sam');
    await pumpEventQueue();
    await sub.cancel();
    expect(seen.first, 0);
    expect(seen.last, 2);
  });

  test('tags are listed once, sorted', () async {
    for (final (label, tag) in [
      ('A', 'Streaming'),
      ('B', 'Sport'),
      ('C', 'Streaming'),
      ('D', null),
    ]) {
      await budget.saveItem(
        BudgetItemsCompanion(
          categoryId: Value('cat_${CategoryKey.subscriptions}'),
          label: Value(label),
          amountCents: const Value(100),
          tag: Value(tag),
        ),
      );
    }
    expect(await budget.tags(), ['Sport', 'Streaming']);
  });
}
