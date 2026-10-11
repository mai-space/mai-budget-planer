import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mai_budget_planer/data/app_database.dart';
import 'package:mai_budget_planer/domain/budget.dart';
import 'package:mai_budget_planer/domain/money.dart';
import 'package:mai_budget_planer/services/home_widgets.dart';

import 'helpers/builders.dart';

/// Beispielhaushalt „Alex“ mit einer Jahres- und einer Quartalszahlung.
BudgetSnapshot household({bool appLock = false}) => BudgetSnapshot(
  persons: [person('Alex')],
  incomes: [income('Alex', 3000)],
  accounts: const [],
  categories: standardCategories,
  items: [
    item('Miete', 1000),
    item(
      'Haftpflicht',
      59.9,
      category: CategoryKey.insurance,
      interval: PayInterval.yearly,
      dueMonth: 3,
    ),
    item('Wasser', 90, interval: PayInterval.quarterly, dueMonth: 2),
  ],
  settings: settings().copyWith(appLockEnabled: appLock),
);

/// Merkt sich, was an die Widgets ginge.
class FakeChannel implements HomeWidgetChannel {
  bool? storedHide;
  final published = <Map<String, dynamic>>[];

  @override
  Future<void> publish(String json) async =>
      published.add(jsonDecode(json) as Map<String, dynamic>);

  @override
  Future<bool?> hideAmounts() async => storedHide;

  @override
  Future<void> setHideAmounts(bool value) async => storedHide = value;

  @override
  Future<WidgetLaunchAction?> takeLaunchAction() async => null;

  @override
  void listen(void Function() onLaunchAction) {}

  @override
  void stopListening() {}
}

void main() {
  test('due months follow the payment rhythm from the due month', () {
    expect(
      dueMonthsOf(item('a', 1, interval: PayInterval.yearly, dueMonth: 3)),
      [3],
    );
    expect(
      dueMonthsOf(item('b', 1, interval: PayInterval.quarterly, dueMonth: 11)),
      [2, 5, 8, 11],
    );
    expect(
      dueMonthsOf(item('c', 1, interval: PayInterval.halfYearly, dueMonth: 8)),
      [2, 8],
    );
    expect(dueMonthsOf(item('d', 1, dueMonth: 3)), isEmpty);
    expect(dueMonthsOf(item('e', 1, interval: PayInterval.yearly)), isEmpty);
  });

  test('payload carries formatted amounts, shares and upcoming items', () {
    final s = household();
    final payload = widgetPayload(s, hideAmounts: false);
    expect(payload['v'], 1);
    expect(payload['hasData'], isTrue);
    expect(payload['free'], Money.format(s.freeRemainder, whole: true));
    expect(payload['freeNegative'], isFalse);
    expect(payload['income'], Money.format(300000, whole: true));
    expect(payload['hasReserve'], isTrue);
    expect(payload['buckets'], hasLength(3));
    expect(payload['upcoming'], [
      {
        'label': 'Haftpflicht',
        'amount': Money.format(5990),
        'months': [3],
      },
      {
        'label': 'Wasser',
        'amount': Money.format(9000),
        'months': [2, 5, 8, 11],
      },
    ]);
  });

  test('hidden amounts never leave the app', () {
    final payload = widgetPayload(household(), hideAmounts: true);
    final json = jsonEncode(payload);
    expect(json, isNot(contains('€')));
    expect(payload['free'], isNull);
    expect(payload['reserve'], isNull);
    // Namen, Monate und Anteile bleiben sichtbar.
    expect(json, contains('Haftpflicht'));
    expect(payload['hasReserve'], isTrue);
    expect((payload['buckets'] as List).first['share'], greaterThan(0));
  });

  test(
    'controller waits for the setting, dedupes and honours the lock',
    () async {
      final channel = FakeChannel();
      final controller = HomeWidgetController(channel);
      addTearDown(controller.dispose);

      // Vor dem Lesen der Einstellung geht nichts raus.
      await controller.update(household(appLock: true));
      expect(channel.published, isEmpty);

      // Ohne eigene Wahl: mit App-Sperre ausgeblendet.
      await controller.load();
      expect(channel.published, hasLength(1));
      expect(channel.published.last['hidden'], isTrue);

      // Gleicher Stand → nichts Neues.
      await controller.update(household(appLock: true));
      expect(channel.published, hasLength(1));

      // Eigene Wahl schlägt die App-Sperre und wird gespeichert.
      await controller.setHideAmounts(false);
      expect(channel.storedHide, isFalse);
      expect(channel.published, hasLength(2));
      expect(channel.published.last['hidden'], isFalse);
      expect(channel.published.last['free'], isNotNull);
    },
  );

  test('without the lock amounts are shown by default', () async {
    final channel = FakeChannel();
    final controller = HomeWidgetController(channel);
    addTearDown(controller.dispose);
    await controller.load();
    await controller.update(household());
    expect(channel.published.single['hidden'], isFalse);
  });

  test('launch actions are parsed tolerantly', () {
    expect(WidgetLaunchAction.parse('add_item'), WidgetLaunchAction.addItem);
    expect(WidgetLaunchAction.parse('overview'), WidgetLaunchAction.overview);
    expect(WidgetLaunchAction.parse('something_new'), isNull);
    expect(WidgetLaunchAction.parse(null), isNull);
  });
}
