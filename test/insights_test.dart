import 'package:flutter_test/flutter_test.dart';
import 'package:mai_budget_planer/data/app_database.dart';
import 'package:mai_budget_planer/domain/insights.dart';

import 'helpers/builders.dart';

List<InsightKind> kinds(List<Insight> insights) =>
    insights.map((i) => i.kind).toList();

Insight only(List<Insight> insights, InsightKind kind) =>
    insights.singleWhere((i) => i.kind == kind);

void main() {
  final couple = [person('Alex'), person('Sam', color: 1)];
  final incomes = [income('Alex', 3000), income('Sam', 2000)];

  test('no data, no noise', () {
    expect(Insights.analyze(snapshot()), isEmpty);
  });

  test('deficit is a warning and sorted first', () {
    final s = snapshot(
      persons: couple,
      incomes: incomes,
      items: [
        item('Miete', 4000, payer: 'Alex'),
        item('Netflix', 10, category: CategoryKey.subscriptions),
        item('Disney', 9, category: CategoryKey.subscriptions),
        item('Reise', 1500, category: CategoryKey.leisure),
      ],
    );
    final result = Insights.analyze(s);
    expect(result.first.kind, InsightKind.deficit);
    expect(result.first.severity, InsightSeverity.warning);
    expect(result.first.amount, closeTo(51900, 0.01));
  });

  test('budget rule: needs over and savings under target', () {
    final s = snapshot(
      persons: couple,
      incomes: incomes,
      items: [
        item('Miete', 2000, payer: 'Alex'),
        item('Lebensmittel', 800, category: CategoryKey.groceries),
        item('Urlaub', 250, category: CategoryKey.savings),
      ],
    );
    final result = Insights.analyze(s);
    final needs = only(result, InsightKind.needsOverTarget);
    expect(needs.percent, closeTo(56, 0.001));
    expect(needs.targetPercent, 50);
    expect(needs.amount, closeTo(30000, 0.01));
    final savings = only(result, InsightKind.savingsUnderTarget);
    expect(savings.percent, closeTo(5, 0.001));
    expect(savings.amount, closeTo(75000, 0.01));
  });

  test('same contract twice suggests a partner plan', () {
    final s = snapshot(
      persons: couple,
      incomes: incomes,
      items: [
        item('Fitness', 30, category: CategoryKey.subscriptions, payer: 'Alex'),
        item(
          'fitness (Sam)',
          30,
          category: CategoryKey.subscriptions,
          payer: 'Sam',
        ),
      ],
    );
    final dup = only(Insights.analyze(s), InsightKind.duplicateContract);
    expect(dup.items, hasLength(2));
    expect(dup.amount, closeTo(6000, 0.01));
  });

  test('overlapping streaming subscriptions: keep the most expensive', () {
    final s = snapshot(
      persons: couple,
      incomes: incomes,
      items: [
        item('A', 5, category: CategoryKey.subscriptions, tag: 'Streaming'),
        item('B', 7, category: CategoryKey.subscriptions, tag: 'streaming'),
        item('C', 10, category: CategoryKey.subscriptions, tag: 'Streaming'),
        // Andere Kategorie zählt nicht.
        item('D', 50, category: CategoryKey.leisure, tag: 'Streaming'),
        // Sport/Hosting lassen sich nicht rotieren.
        item('Gym', 30, category: CategoryKey.subscriptions, tag: 'Sport'),
        item('Mode', 2, category: CategoryKey.subscriptions, tag: 'Sport'),
        item('Hosting', 12, category: CategoryKey.subscriptions, tag: 'Web'),
        item('Domains', 6, category: CategoryKey.subscriptions, tag: 'Web'),
      ],
    );
    final overlap = only(
      Insights.analyze(s),
      InsightKind.overlappingSubscriptions,
    );
    expect(overlap.items, hasLength(3));
    expect(overlap.monthlyPotential, closeTo(1200, 0.01));
  });

  test('flagged potentials are summed', () {
    final s = snapshot(
      persons: couple,
      incomes: incomes,
      items: [
        item('Handy', 40, category: CategoryKey.subscriptions, potentialEuro: 20),
        item('Konto', 4, potentialEuro: 4),
      ],
    );
    final flagged = only(Insights.analyze(s), InsightKind.flaggedPotential);
    expect(flagged.monthlyPotential, 2400);
  });

  test('insurance paid monthly; yearly is fine', () {
    final s = snapshot(
      persons: couple,
      incomes: incomes,
      items: [
        item('BU', 100, category: CategoryKey.insurance),
        item(
          'Haftpflicht',
          60,
          category: CategoryKey.insurance,
          interval: PayInterval.yearly,
        ),
      ],
    );
    final ins = only(Insights.analyze(s), InsightKind.insurancePaidMonthly);
    expect(ins.items.single.label, 'BU');
    expect(ins.monthlyPotential, closeTo(400, 0.01));
  });

  test('zero amounts, missing accounts and annual reserve', () {
    final s = snapshot(
      persons: couple,
      incomes: incomes,
      accounts: [account('Giro', owner: 'Alex', main: true)],
      items: [
        item('Heizung', 0),
        item(
          'Kfz-Steuer',
          120,
          interval: PayInterval.yearly,
          accountId: 'Giro',
        ),
      ],
    );
    final result = Insights.analyze(s);
    expect(only(result, InsightKind.zeroAmount).items.single.label, 'Heizung');
    expect(
      only(result, InsightKind.missingAccount).items.single.label,
      'Heizung',
    );
    expect(only(result, InsightKind.annualReserve).amount, 1000);
  });

  test('low interest on a savings account with deposits', () {
    final s = snapshot(
      persons: couple,
      incomes: incomes,
      accounts: [
        account('Tagesgeld', kind: AccountKind.savings, rate: 0.5),
        account('Gut verzinst', kind: AccountKind.savings, rate: 3),
      ],
      items: [
        item('Haus', 1000, category: CategoryKey.savings, accountId: 'Tagesgeld'),
        item(
          'Urlaub',
          200,
          category: CategoryKey.savings,
          accountId: 'Gut verzinst',
        ),
      ],
    );
    final low = only(Insights.analyze(s), InsightKind.lowInterest);
    expect(low.accounts.single.id, 'Tagesgeld');
    // Ø 6000 € × 1,5 % / 12.
    expect(low.monthlyPotential, closeTo(750, 0.01));
  });

  test('emergency fund: unknown balance vs. partially funded', () {
    final base = [item('Miete', 1000, payer: 'Alex')];
    final unknown = only(
      Insights.analyze(
        snapshot(persons: couple, incomes: incomes, items: base),
      ),
      InsightKind.emergencyFund,
    );
    expect(unknown.severity, InsightSeverity.info);
    expect(unknown.amount, 300000);
    expect(unknown.percent, isNull);

    final partial = only(
      Insights.analyze(
        snapshot(
          persons: couple,
          incomes: incomes,
          accounts: [
            account(
              'Notgroschen',
              kind: AccountKind.savings,
              rate: 3,
              balanceEuro: 1500,
            ),
          ],
          items: base,
        ),
      ),
      InsightKind.emergencyFund,
    );
    expect(partial.percent, closeTo(50, 0.001));

    final funded = Insights.analyze(
      snapshot(
        persons: couple,
        incomes: incomes,
        accounts: [
          account(
            'Notgroschen',
            kind: AccountKind.savings,
            rate: 3,
            balanceEuro: 3000,
          ),
        ],
        items: base,
      ),
    );
    expect(kinds(funded), isNot(contains(InsightKind.emergencyFund)));
  });

  test('biggest want only when it is a notable share of income', () {
    final small = snapshot(
      persons: couple,
      incomes: incomes,
      items: [item('Kino', 20, category: CategoryKey.leisure)],
    );
    expect(kinds(Insights.analyze(small)), isNot(contains(InsightKind.biggestWant)));

    final big = snapshot(
      persons: couple,
      incomes: incomes,
      items: [
        item('Kino', 20, category: CategoryKey.leisure),
        item(
          'Genussmittel',
          300,
          category: CategoryKey.groceries,
          bucket: BudgetBucket.wants,
        ),
      ],
    );
    final want = only(Insights.analyze(big), InsightKind.biggestWant);
    expect(want.label, 'Genussmittel');
    expect(want.percent, closeTo(6, 0.001));
    expect(want.amount, 360000);
  });

  test('total potential sums only estimable savings', () {
    final insights = [
      const Insight(
        kind: InsightKind.zeroAmount,
        severity: InsightSeverity.info,
      ),
      const Insight(
        kind: InsightKind.flaggedPotential,
        severity: InsightSeverity.tip,
        monthlyPotential: 500,
      ),
      const Insight(
        kind: InsightKind.lowInterest,
        severity: InsightSeverity.tip,
        monthlyPotential: 250,
      ),
    ];
    expect(Insights.totalPotential(insights), 750);
  });
}
