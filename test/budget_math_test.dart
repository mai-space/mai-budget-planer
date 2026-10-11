import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:mai_budget_planer/data/app_database.dart';
import 'package:mai_budget_planer/domain/budget.dart';

import 'helpers/builders.dart';

/// Beispielhaushalt: Alex 3000 €, Sam 2000 € netto (60 : 40).
BudgetSnapshot household({SplitMode split = SplitMode.proportional}) =>
    snapshot(
      split: split,
      persons: [person('Alex'), person('Sam', color: 1)],
      incomes: [income('Alex', 3000, grossEuro: 4500), income('Sam', 2000)],
      accounts: [
        account('Giro Alex', owner: 'Alex', main: true),
        account('Giro Sam', owner: 'Sam', main: true),
        account(
          'Tagesgeld',
          kind: AccountKind.savings,
          rate: 2.4,
          balanceEuro: 1000,
        ),
      ],
      items: [
        item('Miete', 1200, payer: 'Alex', accountId: 'Giro Alex'),
        item(
          'Lebensmittel',
          400,
          category: CategoryKey.groceries,
          payer: 'Sam',
        ),
        item(
          'Haftpflicht',
          120,
          category: CategoryKey.insurance,
          interval: PayInterval.yearly,
          payer: 'Alex',
          dueMonth: 3,
        ),
        item(
          'Fitness',
          30,
          category: CategoryKey.subscriptions,
          payer: 'Sam',
          forWhom: 'Sam',
        ),
        item(
          'Urlaub',
          200,
          category: CategoryKey.savings,
          payer: 'Sam',
          accountId: 'Tagesgeld',
        ),
      ],
    );

void main() {
  test('converts every interval to a monthly amount', () {
    expect(monthlyOf(1200, PayInterval.monthly), 1200);
    expect(monthlyOf(1200, PayInterval.quarterly), 400);
    expect(monthlyOf(1200, PayInterval.halfYearly), 200);
    expect(monthlyOf(1200, PayInterval.yearly), 100);
    expect(monthlyOf(1200, PayInterval.weekly), closeTo(5200, 0.001));
  });

  test('overview: income, planned items, free money, deductions', () {
    final s = household();
    expect(s.totalIncome, 500000);
    expect(s.incomeOf('Alex'), 300000);
    expect(s.totalPlanned, 184000);
    expect(s.freeRemainder, 316000);
    // Nur Alex hat Brutto: 1 − 3000/4500.
    expect(s.deductionRate, closeTo(1 / 3, 1e-9));
  });

  test('budget rule buckets follow category unless overridden', () {
    final s = household();
    expect(s.byBucket[BudgetBucket.needs], 161000);
    expect(s.byBucket[BudgetBucket.wants], 3000);
    expect(s.byBucket[BudgetBucket.savings], 20000);
    expect(s.shareOf(BudgetBucket.needs), closeTo(0.322, 1e-9));
    expect(s.targetOf(BudgetBucket.savings), 0.2);

    final treats = snapshot(
      items: [
        item(
          'Genussmittel',
          100,
          category: CategoryKey.groceries,
          bucket: BudgetBucket.wants,
        ),
      ],
    );
    expect(treats.byBucket[BudgetBucket.wants], 10000);
    expect(treats.byBucket[BudgetBucket.needs], 0);
  });

  test('categories are summed in category order', () {
    final rows = household().byCategory;
    expect(rows.map((r) => r.$1.systemKey), [
      CategoryKey.housing,
      CategoryKey.insurance,
      CategoryKey.subscriptions,
      CategoryKey.groceries,
      CategoryKey.savings,
    ]);
    expect(rows[1].$2, 1000); // 120 € jährlich = 10 €/Monat
  });

  test('distribution: transfers per account and remainder per person', () {
    final s = household();
    final alex = s.plans.firstWhere((p) => p.person.id == 'Alex');
    final sam = s.plans.firstWhere((p) => p.person.id == 'Sam');
    expect(alex.remainder, 300000 - 121000);
    expect(sam.remainder, 200000 - 63000);
    expect(alex.mainAccount?.id, 'Giro Alex');
    expect(
      {for (final t in alex.transfers) t.account?.id: t.monthly},
      {'Giro Alex': 120000, null: 1000},
    );
    expect(
      {for (final t in sam.transfers) t.account?.id: t.monthly},
      {null: 43000, 'Tagesgeld': 20000},
    );
  });

  test('joint-account items are funded by income share', () {
    final s = snapshot(
      persons: [person('Alex'), person('Sam', color: 1)],
      incomes: [income('Alex', 3000), income('Sam', 2000)],
      items: [item('Strom', 100)],
    );
    expect(s.plans[0].remainder, 300000 - 6000);
    expect(s.plans[1].remainder, 200000 - 4000);
    // Gemeinsam bezahlt, gemeinsam genutzt → kein Ausgleich nötig.
    expect(s.settlements, isEmpty);
  });

  group('fair settlement', () {
    test('proportional: shared costs by income', () {
      final st = household().settlements.single;
      expect((st.from.id, st.to.id), ('Sam', 'Alex'));
      // Gemeinsam 1810 €: Alex trägt 60 % = 1086 €, zahlt 1210 €.
      expect(st.monthly, closeTo(12400, 0.01));
    });

    test('equal: shared costs split in half', () {
      final st = household(split: SplitMode.equal).settlements.single;
      expect((st.from.id, st.to.id), ('Sam', 'Alex'));
      expect(st.monthly, closeTo(30500, 0.01));
    });

    test('equal remainder: everyone keeps the same free money', () {
      final st = household(split: SplitMode.equalRemainder).settlements.single;
      expect((st.from.id, st.to.id), ('Alex', 'Sam'));
      // Rest 1790 € vs. 1370 € → Mitte 1580 €.
      expect(st.monthly, closeTo(21000, 0.01));
    });

    test('a single person never settles', () {
      final s = snapshot(
        persons: [person('Alex')],
        incomes: [income('Alex', 2000)],
        items: [item('Miete', 800, payer: 'Alex')],
      );
      expect(s.balances, isEmpty);
      expect(s.settlements, isEmpty);
    });
  });

  test('annual reserve and items due soon', () {
    final s = household();
    expect(s.annualReserve, 1000);
    final due = s.dueSoon(DateTime(2026, 2, 10));
    expect(due.single.$1.label, 'Haftpflicht');
    expect(due.single.$2, 1);
    expect(s.dueSoon(DateTime(2026, 4, 1)), isEmpty);

    // Vierteljährlich ab Januar: April ist fällig.
    final quarterly = snapshot(
      items: [
        item(
          'Kfz',
          300,
          interval: PayInterval.quarterly,
          dueMonth: 1,
        ),
      ],
    );
    expect(quarterly.dueSoon(DateTime(2026, 4, 1)).single.$2, 0);
  });

  test('savings projection compounds monthly', () {
    final p = household().projections.single;
    const rate = 0.024 / 12;
    final expected =
        100000 * math.pow(1 + rate, 12) +
        20000 * (math.pow(1 + rate, 12) - 1) / rate;
    expect(p.monthlyDeposit, 20000);
    expect(p.balanceAfterYear, closeTo(expected, 0.01));
    expect(p.interest, closeTo(expected - 100000 - 240000, 0.01));
  });
}
