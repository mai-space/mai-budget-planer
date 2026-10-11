import 'dart:convert';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../data/app_database.dart';
import '../domain/budget.dart';
import '../domain/money.dart';

/// Was ein Tipp auf ein Widget in der App auslösen soll.
enum WidgetLaunchAction {
  /// „+ Posten“: Formular für einen neuen Posten öffnen.
  addItem,

  /// Übersicht zeigen.
  overview;

  static WidgetLaunchAction? parse(Object? value) => switch (value) {
    'add_item' => addItem,
    'overview' => overview,
    _ => null,
  };
}

/// Daten für die Android-Widgets auf dem Startbildschirm (Format v1).
///
/// Beträge kommen fertig formatiert in der App-Sprache. Mit [hideAmounts]
/// enthält die Nutzlast gar keine Beträge — sie landen dann auch nicht im
/// (unverschlüsselten) Widget-Speicher des Systems. Neue Felder nur
/// ergänzen; das Widget ignoriert unbekannte Felder.
Map<String, Object?> widgetPayload(
  BudgetSnapshot s, {
  required bool hideAmounts,
}) {
  String? amount(num cents, {bool whole = true}) =>
      hideAmounts ? null : Money.format(cents, whole: whole);
  final upcoming = [
    for (final item in s.items)
      if (dueMonthsOf(item) case final months when months.isNotEmpty)
        {
          'label': item.label,
          'amount': amount(item.amountCents, whole: false),
          'months': months,
        },
  ];
  return {
    'v': 1,
    'hidden': hideAmounts,
    'hasData': s.items.isNotEmpty || s.incomes.isNotEmpty,
    'free': amount(s.freeRemainder),
    'freeNegative': s.freeRemainder < 0,
    'income': amount(s.totalIncome),
    'planned': amount(s.totalPlanned),
    'hasReserve': s.annualReserve > 0,
    'reserve': s.annualReserve > 0 ? amount(s.annualReserve) : null,
    // Anteile am Netto (0–1) je Topf — keine Beträge, daher immer dabei.
    'buckets': [
      for (final bucket in BudgetBucket.values)
        {'share': s.shareOf(bucket) ?? 0.0, 'target': s.targetOf(bucket)},
    ],
    // Höchstens 20 Einträge; die Reihenfolge nach Fälligkeit bestimmt das
    // Widget selbst (der Monat ändert sich auch ohne geöffnete App).
    'upcoming': upcoming.take(20).toList(),
  };
}

/// Plattformkanal zu den Widgets (siehe `HomeWidgetChannel.kt`).
class HomeWidgetChannel {
  const HomeWidgetChannel();

  static const _channel = MethodChannel('mai/home_widgets');

  static bool get _supported => !kIsWeb && Platform.isAndroid;

  Future<T?> _invoke<T>(String method, [Object? arguments]) async {
    if (!_supported) return null;
    try {
      return await _channel.invokeMethod<T>(method, arguments);
    } on MissingPluginException {
      return null;
    } on PlatformException catch (e) {
      debugPrint('Widgets: ${e.code}');
      return null;
    }
  }

  Future<void> publish(String json) => _invoke<void>('publish', json);

  /// Eigene Wahl „Beträge ausblenden“; `null` = nie eingestellt.
  Future<bool?> hideAmounts() => _invoke<bool>('getHideAmounts');

  Future<void> setHideAmounts(bool value) =>
      _invoke<void>('setHideAmounts', value);

  /// Aktion, mit der die App aus einem Widget gestartet wurde (einmalig).
  Future<WidgetLaunchAction?> takeLaunchAction() async =>
      WidgetLaunchAction.parse(await _invoke<String>('takeLaunchAction'));

  /// Meldet Aktionen, wenn die laufende App erneut aus einem Widget
  /// geöffnet wird.
  void listen(VoidCallback onLaunchAction) {
    if (!_supported) return;
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'launchAction') onLaunchAction();
    });
  }

  void stopListening() {
    if (!_supported) return;
    _channel.setMethodCallHandler(null);
  }
}

/// Hält die Widgets aktuell und verwaltet „Beträge ausblenden“.
class HomeWidgetController extends ChangeNotifier {
  HomeWidgetController([this._channel = const HomeWidgetChannel()]);

  final HomeWidgetChannel _channel;

  bool? _hideOverride;
  bool _loaded = false;
  BudgetSnapshot? _snapshot;
  String? _published;

  /// Ohne eigene Wahl: ausgeblendet, sobald die App-Sperre an ist — wer die
  /// App sperrt, will die Zahlen nicht offen auf dem Startbildschirm.
  bool hideAmounts(AppSetting settings) =>
      _hideOverride ?? settings.appLockEnabled;

  Future<void> load() async {
    _hideOverride = await _channel.hideAmounts();
    _loaded = true;
    notifyListeners();
    if (_snapshot case final s?) await update(s);
  }

  Future<void> setHideAmounts(bool value) async {
    _hideOverride = value;
    notifyListeners();
    await _channel.setHideAmounts(value);
    if (_snapshot case final s?) await update(s);
  }

  /// Schickt den neuen Stand, wenn er sich für die Widgets geändert hat.
  Future<void> update(BudgetSnapshot snapshot) async {
    _snapshot = snapshot;
    // Erst nach dem Lesen der Einstellung, sonst blitzen Beträge kurz auf.
    if (!_loaded) return;
    final json = jsonEncode(
      widgetPayload(snapshot, hideAmounts: hideAmounts(snapshot.settings)),
    );
    if (json == _published) return;
    _published = json;
    await _channel.publish(json);
  }
}
