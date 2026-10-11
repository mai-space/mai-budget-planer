import 'dart:math' as math;

import '../data/app_database.dart';

/// Monatlicher Gegenwert eines Betrags (in Cent, ungerundet).
double monthlyOf(int cents, PayInterval interval) => switch (interval) {
  PayInterval.monthly => cents.toDouble(),
  PayInterval.quarterly => cents / 3,
  PayInterval.halfYearly => cents / 6,
  PayInterval.yearly => cents / 12,
  PayInterval.weekly => cents * 52 / 12,
};

/// Zahlungen pro Jahr.
int paymentsPerYear(PayInterval interval) => switch (interval) {
  PayInterval.monthly => 12,
  PayInterval.quarterly => 4,
  PayInterval.halfYearly => 2,
  PayInterval.yearly => 1,
  PayInterval.weekly => 52,
};

/// Monate (1–12), in denen ein nicht monatlicher Posten fällig wird —
/// Rhythmus ab `dueMonth`. Leer ohne Fälligkeitsmonat oder bei monatlichen
/// Posten.
List<int> dueMonthsOf(BudgetItem item) {
  final due = item.dueMonth;
  if (due == null || item.interval == PayInterval.monthly) return const [];
  final step = 12 ~/ paymentsPerYear(item.interval).clamp(1, 12);
  return [for (var k = 0; k < 12; k += step) (due - 1 + k) % 12 + 1]..sort();
}

/// Eine Überweisung im Einkommensverteiler: Person → Konto.
class Transfer {
  const Transfer({required this.account, required this.monthly});

  /// `null` = Posten ohne Konto.
  final Account? account;
  final double monthly;
}

/// Verteilung des Einkommens einer Person.
class PersonPlan {
  const PersonPlan({
    required this.person,
    required this.income,
    required this.transfers,
    required this.remainder,
    required this.mainAccount,
  });

  final Person person;

  /// Netto je Monat.
  final double income;

  /// Feste Überweisungen je Konto (ohne Hauptkonto-Rest).
  final List<Transfer> transfers;

  /// Frei verfügbar nach allen eigenen Posten und dem Anteil an
  /// Gemeinschaftsposten.
  final double remainder;

  /// Ziel für den Rest (Hauptkonto der Person), falls angelegt.
  final Account? mainAccount;
}

/// Ausgleichszahlung zwischen zwei Personen je Monat.
class Settlement {
  const Settlement({
    required this.from,
    required this.to,
    required this.monthly,
  });

  final Person from;
  final Person to;
  final double monthly;
}

/// Hochrechnung eines Sparkontos auf zwölf Monate.
class SavingsProjection {
  const SavingsProjection({
    required this.account,
    required this.monthlyDeposit,
    required this.startBalance,
    required this.balanceAfterYear,
    required this.interest,
  });

  final Account account;
  final double monthlyDeposit;
  final double startBalance;
  final double balanceAfterYear;
  final double interest;
}

/// Alle Daten des Haushalts plus abgeleitete Kennzahlen. Unveränderlich;
/// wird bei jeder Datenänderung neu gebaut.
class BudgetSnapshot {
  BudgetSnapshot({
    required List<Person> persons,
    required List<Income> incomes,
    required List<Account> accounts,
    required List<Category> categories,
    required List<BudgetItem> items,
    required this.settings,
  }) : persons = List.unmodifiable(persons),
       incomes = List.unmodifiable(incomes),
       accounts = List.unmodifiable(accounts),
       categories = List.unmodifiable(categories),
       items = List.unmodifiable(items),
       _categoryById = {for (final c in categories) c.id: c},
       _accountById = {for (final a in accounts) a.id: a};

  final List<Person> persons;
  final List<Income> incomes;
  final List<Account> accounts;
  final List<Category> categories;
  final List<BudgetItem> items;
  final AppSetting settings;

  final Map<String, Category> _categoryById;
  final Map<String, Account> _accountById;

  Category? categoryOf(BudgetItem item) => _categoryById[item.categoryId];

  Account? accountOf(BudgetItem item) =>
      item.accountId == null ? null : _accountById[item.accountId];

  Person? personById(String? id) {
    if (id == null) return null;
    for (final p in persons) {
      if (p.id == id) return p;
    }
    return null;
  }

  /// Topf eines Postens: eigene Angabe vor der Kategorie.
  BudgetBucket bucketOf(BudgetItem item) =>
      item.bucketOverride ?? categoryOf(item)?.bucket ?? BudgetBucket.needs;

  static double monthly(BudgetItem item) =>
      monthlyOf(item.amountCents, item.interval);

  // --- Einkommen -----------------------------------------------------------

  double incomeOf(String personId) => incomes
      .where((i) => i.personId == personId)
      .fold(0.0, (sum, i) => sum + monthlyOf(i.netCents, i.interval));

  late final double totalIncome = incomes.fold(
    0.0,
    (sum, i) => sum + monthlyOf(i.netCents, i.interval),
  );

  /// Abzugsquote (Steuern + Sozialabgaben) über alle Einkommen mit Brutto.
  double? get deductionRate {
    var gross = 0.0, net = 0.0;
    for (final i in incomes) {
      if (i.grossCents case final g? when g > 0) {
        gross += monthlyOf(g, i.interval);
        net += monthlyOf(i.netCents, i.interval);
      }
    }
    return gross == 0 ? null : 1 - net / gross;
  }

  // --- Ausgaben ------------------------------------------------------------

  /// Alle Posten (inkl. Sparraten) je Monat.
  late final double totalPlanned = items.fold(
    0.0,
    (sum, i) => sum + monthly(i),
  );

  /// Summe je Topf.
  late final Map<BudgetBucket, double> byBucket = {
    for (final b in BudgetBucket.values)
      b: items
          .where((i) => bucketOf(i) == b)
          .fold(0.0, (sum, i) => sum + monthly(i)),
  };

  /// Summe je Kategorie (nur Kategorien mit Posten), absteigend.
  late final List<(Category, double)> byCategory = () {
    final sums = <String, double>{};
    for (final item in items) {
      sums.update(
        item.categoryId,
        (v) => v + monthly(item),
        ifAbsent: () => monthly(item),
      );
    }
    final rows = [
      for (final c in categories)
        if (sums[c.id] case final sum?) (c, sum),
    ];
    rows.sort((a, b) => a.$1.sortOrder.compareTo(b.$1.sortOrder));
    return rows;
  }();

  /// Was nach allen Posten übrig bleibt („Spaßkarte“).
  double get freeRemainder => totalIncome - totalPlanned;

  /// Anteil eines Topfs am Nettoeinkommen (0–1); `null` ohne Einkommen.
  double? shareOf(BudgetBucket bucket) =>
      totalIncome <= 0 ? null : byBucket[bucket]! / totalIncome;

  /// Zielanteil laut Budgetregel (0–1).
  double targetOf(BudgetBucket bucket) => switch (bucket) {
    BudgetBucket.needs => settings.ruleNeeds / 100,
    BudgetBucket.wants => settings.ruleWants / 100,
    BudgetBucket.savings => settings.ruleSavings / 100,
  };

  /// Monatliche Rücklage für Posten, die nicht monatlich fällig sind.
  late final double annualReserve = items
      .where(
        (i) =>
            i.interval != PayInterval.monthly &&
            i.interval != PayInterval.weekly,
      )
      .fold(0.0, (sum, i) => sum + monthly(i));

  /// Nicht monatliche Posten, die in den nächsten [months] Monaten fällig
  /// werden (nach Fälligkeitsmonat), sortiert nach Abstand.
  List<(BudgetItem, int)> dueSoon(DateTime now, {int months = 3}) {
    final result = <(BudgetItem, int)>[];
    for (final item in items) {
      final dueMonths = dueMonthsOf(item);
      if (dueMonths.isEmpty) continue;
      // Nächster Fälligkeitsmonat ab jetzt (Rhythmus ab dueMonth).
      var best = 12;
      for (final month in dueMonths) {
        final distance = (month - now.month + 12) % 12;
        best = math.min(best, distance);
      }
      if (best < months) result.add((item, best));
    }
    result.sort((a, b) => a.$2.compareTo(b.$2));
    return result;
  }

  // --- Verteilung ----------------------------------------------------------

  /// Anteile der Personen an Gemeinschaftsposten (Summe 1).
  Map<String, double> get _shares {
    if (persons.isEmpty) return const {};
    final equal = {for (final p in persons) p.id: 1 / persons.length};
    if (settings.splitMode == SplitMode.equal || totalIncome <= 0) {
      return equal;
    }
    return {for (final p in persons) p.id: incomeOf(p.id) / totalIncome};
  }

  /// Wer welchen Anteil eines Postens wirtschaftlich trägt (ohne Ausgleich).
  Map<String, double> _owedShares(BudgetItem item) {
    if (personById(item.beneficiaryPersonId) case final p?) {
      return {p.id: 1};
    }
    return _shares;
  }

  /// Wer einen Posten tatsächlich überweist.
  Map<String, double> _paidShares(BudgetItem item) {
    if (personById(item.payerPersonId) case final p?) return {p.id: 1};
    // Gemeinschaftskonto: wird nach Aufteilungsregel befüllt.
    return _shares;
  }

  /// Einkommensverteiler: je Person Überweisungen auf Konten und der Rest.
  late final List<PersonPlan> plans = [
    for (final person in persons) _planFor(person),
  ];

  PersonPlan _planFor(Person person) {
    final byAccount = <String?, double>{};
    var paid = 0.0;
    for (final item in items) {
      final share = _paidShares(item)[person.id] ?? 0;
      if (share == 0) continue;
      final amount = monthly(item) * share;
      paid += amount;
      byAccount.update(
        item.accountId,
        (v) => v + amount,
        ifAbsent: () => amount,
      );
    }
    Account? main;
    for (final a in accounts) {
      if (a.ownerPersonId == person.id && a.isMain) main = a;
    }
    final income = incomeOf(person.id);
    final transfers = [
      for (final MapEntry(key: id, value: sum) in byAccount.entries)
        Transfer(account: id == null ? null : _accountById[id], monthly: sum),
    ]..sort((a, b) => b.monthly.compareTo(a.monthly));
    return PersonPlan(
      person: person,
      income: income,
      transfers: transfers,
      remainder: income - paid,
      mainAccount: main,
    );
  }

  /// Ausgleich je Person: positiv = bekommt Geld, negativ = zahlt.
  late final Map<String, double> balances = () {
    if (persons.length < 2) return <String, double>{};
    if (settings.splitMode == SplitMode.equalRemainder) {
      final avg =
          plans.fold(0.0, (s, p) => s + p.remainder) / plans.length;
      return {for (final p in plans) p.person.id: avg - p.remainder};
    }
    final result = {for (final p in persons) p.id: 0.0};
    for (final item in items) {
      final amount = monthly(item);
      for (final MapEntry(key: id, value: share) in _paidShares(item).entries) {
        result[id] = result[id]! + amount * share;
      }
      for (final MapEntry(key: id, value: share)
          in _owedShares(item).entries) {
        result[id] = result[id]! - amount * share;
      }
    }
    return result;
  }();

  /// Ausgleichszahlungen (Gläubiger zuerst bedient), Beträge ab 1 €.
  late final List<Settlement> settlements = () {
    final creditors = [
      for (final p in persons)
        if ((balances[p.id] ?? 0) > 0) (p, balances[p.id]!),
    ]..sort((a, b) => b.$2.compareTo(a.$2));
    final debtors = [
      for (final p in persons)
        if ((balances[p.id] ?? 0) < 0) (p, -balances[p.id]!),
    ]..sort((a, b) => b.$2.compareTo(a.$2));
    final result = <Settlement>[];
    var i = 0, j = 0;
    var credit = creditors.isEmpty ? 0.0 : creditors.first.$2;
    var debt = debtors.isEmpty ? 0.0 : debtors.first.$2;
    while (i < creditors.length && j < debtors.length) {
      final amount = math.min(credit, debt);
      if (amount >= 100) {
        result.add(
          Settlement(from: debtors[j].$1, to: creditors[i].$1, monthly: amount),
        );
      }
      credit -= amount;
      debt -= amount;
      if (credit <= 0.5) {
        i++;
        if (i < creditors.length) credit = creditors[i].$2;
      }
      if (debt <= 0.5) {
        j++;
        if (j < debtors.length) debt = debtors[j].$2;
      }
    }
    return result;
  }();

  // --- Sparen --------------------------------------------------------------

  /// Hochrechnung je Sparkonto mit monatlicher Verzinsung.
  late final List<SavingsProjection> projections = [
    for (final account in accounts)
      if (account.kind == AccountKind.savings) _project(account),
  ];

  SavingsProjection _project(Account account) {
    final deposit = items
        .where((i) => i.accountId == account.id)
        .fold(0.0, (sum, i) => sum + monthly(i));
    final start = (account.balanceCents ?? 0).toDouble();
    final rate = (account.interestRate ?? 0) / 100 / 12;
    var balance = start;
    for (var m = 0; m < 12; m++) {
      balance = balance * (1 + rate) + deposit;
    }
    return SavingsProjection(
      account: account,
      monthlyDeposit: deposit,
      startBalance: start,
      balanceAfterYear: balance,
      interest: balance - start - deposit * 12,
    );
  }
}
