import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mai_budget_planer/data/app_database.dart';
import 'package:mai_budget_planer/l10n/l10n.dart';
import 'package:mai_budget_planer/main.dart';

/// drift-Streams brauchen echte Zeit; abwechselnd laufen lassen und zeichnen.
Future<void> settle(WidgetTester tester) async {
  for (var i = 0; i < 8; i++) {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 10)),
    );
    await tester.pump(const Duration(milliseconds: 50));
  }
}

Future<void> tapAndSettle(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pump();
  await tester.tap(finder);
  await settle(tester);
}

void useTallPhone(WidgetTester tester) {
  tester.view.physicalSize = const Size(1080, 2600);
  tester.view.devicePixelRatio = 2.5;
  addTearDown(tester.view.reset);
}

Future<void> disposeApp(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump(const Duration(milliseconds: 100));
}

void main() {
  testWidgets('onboarding → add item → overview, split and tips', (
    tester,
  ) async {
    useTallPhone(tester);
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await tester.pumpWidget(MaiBudgetApp(database: db));
    await settle(tester);

    expect(find.text('Dein Budget bleibt bei dir'), findsOneWidget);
    await tapAndSettle(tester, find.text('Weiter'));

    // Haushalt mit zwei Personen.
    await tester.enterText(find.widgetWithText(TextFormField, 'Name'), 'Alex');
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Netto pro Monat'),
      '3000',
    );
    await tapAndSettle(tester, find.text('Person hinzufügen'));
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Name').last,
      'Sam',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Netto pro Monat').last,
      '2000',
    );
    await tapAndSettle(tester, find.text("Los geht's"));

    // Übersicht: alles frei, noch keine Posten.
    expect(find.text('Frei verfügbar'), findsOneWidget);
    expect(find.text('5.000,00 €'), findsWidgets);
    expect(find.text('Noch keine Posten'), findsWidgets);

    // Posten anlegen (Rechnung im Betragsfeld wie in einer Tabelle).
    await tapAndSettle(tester, find.text('Posten').last);
    await tapAndSettle(tester, find.text('Posten hinzufügen').last);
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Bezeichnung'),
      'Miete',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Betrag'),
      '1000 + 200',
    );
    await settle(tester);
    await tapAndSettle(tester, find.text('Speichern'));

    expect(find.text('Miete'), findsWidgets);
    expect(find.text('1.200,00 €'), findsWidgets);

    // Jahresansicht rechnet ×12.
    await tapAndSettle(tester, find.text('Jahr').first);
    expect(find.text('14.400,00 €'), findsWidgets);
    await tapAndSettle(tester, find.text('Monat').first);

    // Übersicht zieht nach.
    await tapAndSettle(tester, find.text('Übersicht'));
    expect(find.text('3.800,00 €'), findsOneWidget);
    expect(find.textContaining('Budgetregel 50/30/20'), findsOneWidget);

    // Verteiler: Gemeinschaftskonto wird nach Einkommen befüllt.
    await tapAndSettle(tester, find.text('Verteiler'));
    expect(find.text('Fairer Ausgleich'), findsOneWidget);
    expect(find.text('720,00 €'), findsWidgets); // 60 % von 1200
    expect(find.text('480,00 €'), findsWidgets); // 40 % von 1200

    // Tipps: Notgroschen und Sparquote.
    await tapAndSettle(tester, find.text('Tipps'));
    expect(find.text('Notgroschen'), findsOneWidget);
    expect(find.text('Sparquote unter dem Ziel'), findsOneWidget);

    await disposeApp(tester);
  });

  testWidgets('English device: onboarding in English', (tester) async {
    useTallPhone(tester);
    AppLocale.update(AppLocale.english);
    tester.platformDispatcher.localesTestValue = const [Locale('en', 'US')];
    addTearDown(() {
      tester.platformDispatcher.clearLocalesTestValue();
      AppLocale.update(AppLocale.german);
    });
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await tester.pumpWidget(MaiBudgetApp(database: db));
    await settle(tester);
    expect(find.text('Your budget stays with you'), findsOneWidget);
    expect(find.textContaining('Dein Budget'), findsNothing);
    // Standardkategorien entstehen in der Sprache beim ersten Start.
    final categories = await db.select(db.categories).get();
    expect(categories.first.name, 'Housing');
    await disposeApp(tester);
  });
}
