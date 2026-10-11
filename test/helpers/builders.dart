import 'package:mai_budget_planer/data/app_database.dart';
import 'package:mai_budget_planer/domain/budget.dart';

/// Testdaten-Bausteine (frei erfundener Beispielhaushalt).
final _t = DateTime(2026);

Person person(String id, {int color = 0}) => Person(
  id: id,
  name: id,
  colorIndex: color,
  sortOrder: color,
  createdAt: _t,
  updatedAt: _t,
);

Income income(
  String personId,
  int netEuro, {
  int? grossEuro,
  PayInterval interval = PayInterval.monthly,
}) => Income(
  id: 'inc_${personId}_$netEuro',
  personId: personId,
  label: 'Gehalt',
  netCents: netEuro * 100,
  grossCents: grossEuro == null ? null : grossEuro * 100,
  interval: interval,
  createdAt: _t,
  updatedAt: _t,
);

Account account(
  String id, {
  AccountKind kind = AccountKind.checking,
  String? owner,
  bool main = false,
  double? rate,
  int? balanceEuro,
}) => Account(
  id: id,
  name: id,
  kind: kind,
  ownerPersonId: owner,
  isMain: main,
  interestRate: rate,
  balanceCents: balanceEuro == null ? null : balanceEuro * 100,
  createdAt: _t,
  updatedAt: _t,
);

Category category(String key, BudgetBucket bucket, {int order = 0}) =>
    Category(
      id: 'cat_$key',
      name: key,
      systemKey: key,
      icon: 'category',
      bucket: bucket,
      sortOrder: order,
      createdAt: _t,
      updatedAt: _t,
    );

final standardCategories = [
  category(CategoryKey.housing, BudgetBucket.needs, order: 0),
  category(CategoryKey.insurance, BudgetBucket.needs, order: 1),
  category(CategoryKey.subscriptions, BudgetBucket.wants, order: 2),
  category(CategoryKey.groceries, BudgetBucket.needs, order: 3),
  category(CategoryKey.leisure, BudgetBucket.wants, order: 4),
  category(CategoryKey.savings, BudgetBucket.savings, order: 5),
];

var _n = 0;

BudgetItem item(
  String label,
  num euro, {
  String category = CategoryKey.housing,
  PayInterval interval = PayInterval.monthly,
  String? payer,
  String? forWhom,
  String? accountId,
  BudgetBucket? bucket,
  String? tag,
  int? dueMonth,
  int? potentialEuro,
}) => BudgetItem(
  id: 'item_${_n++}',
  categoryId: 'cat_$category',
  label: label,
  amountCents: (euro * 100).round(),
  interval: interval,
  payerPersonId: payer,
  beneficiaryPersonId: forWhom,
  accountId: accountId,
  bucketOverride: bucket,
  tag: tag,
  dueMonth: dueMonth,
  savingsPotentialCents: potentialEuro == null ? null : potentialEuro * 100,
  createdAt: _t,
  updatedAt: _t,
);

AppSetting settings({SplitMode split = SplitMode.proportional}) => AppSetting(
  id: 1,
  onboardingCompleted: true,
  appLockEnabled: false,
  ruleNeeds: 50,
  ruleWants: 30,
  ruleSavings: 20,
  splitMode: split,
);

BudgetSnapshot snapshot({
  List<Person> persons = const [],
  List<Income> incomes = const [],
  List<Account> accounts = const [],
  List<Category>? categories,
  List<BudgetItem> items = const [],
  SplitMode split = SplitMode.proportional,
}) => BudgetSnapshot(
  persons: persons,
  incomes: incomes,
  accounts: accounts,
  categories: categories ?? standardCategories,
  items: items,
  settings: settings(split: split),
);
