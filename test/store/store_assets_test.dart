// Erzeugt Screenshots und Feature-Grafik für den Play Store (store/android/).
//
//   flutter test test/store/store_assets_test.dart \
//     --dart-define=STORE_ASSETS=true
//
// Ohne den Schalter wird der Test übersprungen (normaler `flutter test`).
// Alle Zahlen stammen aus dem frei erfundenen Beispielhaushalt „Alex“/„Sam“
// unten — keine echten Finanzdaten.
import 'dart:io';
import 'dart:ui' as ui;

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mai_budget_planer/data/app_database.dart';
import 'package:mai_budget_planer/data/repositories/budget_repository.dart';
import 'package:mai_budget_planer/data/repositories/household_repository.dart';
import 'package:mai_budget_planer/data/repositories/settings_repository.dart';
import 'package:mai_budget_planer/l10n/l10n.dart';
import 'package:mai_budget_planer/main.dart';
import 'package:mai_budget_planer/theme/app_theme.dart';

const _enabled = bool.fromEnvironment('STORE_ASSETS');

/// Ausgabegröße: 1080 × 1920 px (9:16), logisch 432 × 768 dp.
const _phone = Size(1080, 1920);
const _ratio = 2.5;

final _out = Directory('store/android');

/// drift-Streams brauchen echte Zeit; abwechselnd laufen lassen und zeichnen.
Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 10; i++) {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 10)),
    );
    await tester.pump(const Duration(milliseconds: 100));
  }
  await tester.pumpAndSettle();
}

/// Echte Schriften statt der Test-Schrift laden (Roboto, Material Icons).
Future<void> _loadFonts() async {
  // flutter_tester liegt unter bin/cache/artifacts/engine/<plattform>/.
  final engine = File(Platform.resolvedExecutable).parent;
  final fonts = Directory('${engine.parent.parent.path}/material_fonts');
  Future<void> load(String family, List<String> files) async {
    final loader = FontLoader(family);
    for (final f in files) {
      final bytes = File('${fonts.path}/$f').readAsBytesSync();
      loader.addFont(Future.value(ByteData.sublistView(bytes)));
    }
    await loader.load();
  }

  await load('Roboto', [
    'Roboto-Regular.ttf',
    'Roboto-Medium.ttf',
    'Roboto-Bold.ttf',
    'Roboto-Light.ttf',
  ]);
  await load('MaterialIcons', ['MaterialIcons-Regular.otf']);
}

Future<void> _capture(WidgetTester tester, Key key, String path) async {
  final boundary =
      tester.renderObject(find.byKey(key)) as RenderRepaintBoundary;
  await tester.runAsync(() async {
    final image = await boundary.toImage(pixelRatio: _ratio);
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    final file = File(path)..parent.createSync(recursive: true);
    file.writeAsBytesSync(data!.buffer.asUint8List());
  });
}

/// Frei erfundener Beispielhaushalt in der jeweiligen Sprache.
Future<void> _seed(AppDatabase db, {required bool de}) async {
  final household = HouseholdRepository(db);
  final budget = BudgetRepository(db);
  await household.setUpHousehold(
    [(name: 'Alex', netCents: 310000), (name: 'Sam', netCents: 245000)],
    mainAccountName: (n) => de ? 'Girokonto $n' : '$n checking',
    incomeLabel: de ? 'Gehalt' : 'Salary',
  );
  final persons = await household.persons();
  final alex = persons[0].id;
  final sam = persons[1].id;
  final joint = await household.saveAccount(
    name: de ? 'Gemeinschaftskonto' : 'Joint account',
    kind: AccountKind.checking,
  );
  final daily = await household.saveAccount(
    name: de ? 'Tagesgeld' : 'Savings account',
    kind: AccountKind.savings,
    interestRate: 2.5,
    balanceCents: 640000,
  );
  final travel = await household.saveAccount(
    name: de ? 'Urlaubskasse' : 'Holiday pot',
    kind: AccountKind.savings,
    interestRate: 0,
    balanceCents: 85000,
  );
  final s = await budget.snapshot();
  String cat(String key) =>
      s.categories.firstWhere((c) => c.systemKey == key).id;

  Future<void> item(
    String category,
    String deLabel,
    String enLabel,
    int cents, {
    PayInterval interval = PayInterval.monthly,
    String? payer,
    String? account,
    String? tag,
    String? provider,
    int? dueMonth,
    BudgetBucket? bucket,
    int? potential,
  }) => budget.saveItem(
    BudgetItemsCompanion(
      categoryId: Value(cat(category)),
      label: Value(de ? deLabel : enLabel),
      amountCents: Value(cents),
      interval: Value(interval),
      payerPersonId: Value(payer),
      accountId: Value(account ?? joint),
      tag: Value(tag),
      provider: Value(provider),
      dueMonth: Value(dueMonth),
      bucketOverride: Value(bucket),
      savingsPotentialCents: Value(potential),
    ),
  );

  await item(CategoryKey.housing, 'Miete', 'Rent', 115000);
  await item(CategoryKey.housing, 'Nebenkosten', 'Utilities', 22000);
  await item(CategoryKey.housing, 'Strom', 'Electricity', 8500,
      provider: de ? 'Stadtwerke' : 'City utility');
  await item(CategoryKey.insurance, 'Haftpflicht', 'Liability insurance',
      6900, interval: PayInterval.yearly, dueMonth: 3);
  await item(CategoryKey.insurance, 'Hausrat', 'Home contents', 1150,
      interval: PayInterval.quarterly, dueMonth: 1);
  await item(CategoryKey.mobility, 'Kfz-Versicherung', 'Car insurance', 48000,
      interval: PayInterval.yearly, dueMonth: 11, payer: alex);
  await item(CategoryKey.mobility, 'Deutschlandticket', 'Transit pass', 5800,
      payer: sam, account: null);
  await item(CategoryKey.communication, 'Internet', 'Internet', 3999);
  await item(CategoryKey.communication, 'Handy Alex', 'Phone Alex', 1499,
      payer: alex);
  await item(CategoryKey.communication, 'Handy Sam', 'Phone Sam', 1299,
      payer: sam);
  await item(CategoryKey.subscriptions, 'Serien-Abo', 'Series streaming',
      1399, tag: 'Streaming');
  await item(CategoryKey.subscriptions, 'Film-Abo', 'Movie streaming', 999,
      tag: 'Streaming');
  await item(CategoryKey.subscriptions, 'Musik', 'Music', 1099,
      tag: de ? 'Musik' : 'Music', payer: sam);
  await item(CategoryKey.banking, 'Kontoführung', 'Account fee', 590);
  await item(CategoryKey.groceries, 'Lebensmittel', 'Groceries', 65000);
  await item(CategoryKey.groceries, 'Kaffee & Süßes', 'Coffee & treats',
      4000, bucket: BudgetBucket.wants, potential: 1500);
  await item(CategoryKey.leisure, 'Essen gehen', 'Eating out', 16000);
  await item(CategoryKey.leisure, 'Fitnessstudio', 'Gym', 3500, payer: alex);
  await item(CategoryKey.savings, 'Notgroschen', 'Emergency fund', 25000,
      account: daily);
  await item(CategoryKey.savings, 'Urlaub', 'Holidays', 15000,
      account: travel);
  await item(CategoryKey.savings, 'ETF-Sparplan', 'ETF savings plan', 30000,
      account: daily);
  await SettingsRepository(db).completeOnboarding();
}

void main() {
  for (final de in [true, false]) {
    final lang = de ? 'de-DE' : 'en-US';
    testWidgets('store screenshots $lang', skip: !_enabled, (tester) async {
      await _loadFonts();
      // Kein Tastatur-Fokusrahmen wie auf einem Touch-Gerät.
      FocusManager.instance.highlightStrategy =
          FocusHighlightStrategy.alwaysTouch;
      // Echte Schatten statt der schwarzen Test-Umrandung.
      debugDisableShadows = false;
      AppLocale.update(de ? AppLocale.german : AppLocale.english);
      final locale = de ? const Locale('de', 'DE') : const Locale('en', 'US');
      tester.platformDispatcher.localesTestValue = [locale];
      tester.platformDispatcher.localeTestValue = locale;
      tester.view.physicalSize = _phone;
      tester.view.devicePixelRatio = _ratio;
      addTearDown(tester.view.reset);
      addTearDown(tester.platformDispatcher.clearAllTestValues);

      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      await tester.runAsync(() => _seed(db, de: de));

      const key = Key('app');
      await tester.pumpWidget(
        RepaintBoundary(key: key, child: MaiBudgetApp(database: db)),
      );
      await _settle(tester);

      final dir = '${_out.path}/$lang/phone-screenshots';
      final l10n = lookupAppLocalizations(locale);
      var n = 0;
      Future<void> shot(String name) =>
          _capture(tester, key, '$dir/${++n}-$name.png');

      Future<void> tab(String label) async {
        await tester.tap(find.text(label).last);
        await _settle(tester);
      }

      await shot('overview');
      await tester.drag(find.byType(Scrollable).first, const Offset(0, -620));
      await _settle(tester);
      await shot('budget-rule');
      await tab(l10n.tabItems);
      await shot('items');
      // Neuer Posten: Betragsfeld rechnet wie eine Tabelle.
      await tester.tap(find.text(l10n.itemsAdd).last);
      await _settle(tester);
      await tester.enterText(
        find.widgetWithText(TextFormField, l10n.itemsLabel),
        de ? 'Putzmittel' : 'Cleaning supplies',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, l10n.itemsAmount),
        '2,49 + 2,49 + 5',
      );
      FocusManager.instance.primaryFocus?.unfocus();
      await _settle(tester);
      await shot('new-item');
      appNavigatorKey.currentState!.pop();
      await _settle(tester);
      await tab(l10n.tabDistribution);
      await shot('distribution');
      await tab(l10n.tabInsights);
      await shot('tips');
      // Einstellungen fehlen bewusst: dort steht „→“, das die hier geladene
      // Roboto nicht enthält (auf dem Gerät greift die Ersatzschrift).

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(milliseconds: 100));
      debugDisableShadows = true;
    });
  }

  for (final de in [true, false]) {
    final lang = de ? 'de-DE' : 'en-US';
    testWidgets('store feature graphic $lang', skip: !_enabled, (
      tester,
    ) async {
      await _loadFonts();
      tester.view.physicalSize = const Size(1024, 500);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      Future<ui.Image> decode(String path) async {
        final codec = await ui.instantiateImageCodec(
          File(path).readAsBytesSync(),
        );
        return (await codec.getNextFrame()).image;
      }

      final shotImage = (await tester.runAsync(
        () => decode('${_out.path}/$lang/phone-screenshots/1-overview.png'),
      ))!;
      final logoImage = (await tester.runAsync(
        () => decode('assets/branding/3.0x/logo.png'),
      ))!;

      const key = Key('feature');
      await tester.pumpWidget(
        RepaintBoundary(
          key: key,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: _FeatureGraphic(
              de: de,
              screenshot: shotImage,
              logo: logoImage,
            ),
          ),
        ),
      );
      await tester.pump();
      final boundary =
          tester.renderObject(find.byKey(key)) as RenderRepaintBoundary;
      await tester.runAsync(() async {
        final image = await boundary.toImage();
        final data = await image.toByteData(format: ui.ImageByteFormat.png);
        File('${_out.path}/$lang/feature-graphic.png')
            .writeAsBytesSync(data!.buffer.asUint8List());
      });
    });
  }
}

/// 1024 × 500: Logo, Name, Kernaussage und ein Ausschnitt der Übersicht.
class _FeatureGraphic extends StatelessWidget {
  const _FeatureGraphic({
    required this.de,
    required this.screenshot,
    required this.logo,
  });

  final bool de;
  final ui.Image screenshot;
  final ui.Image logo;

  @override
  Widget build(BuildContext context) {
    const white = Color(0xFFFFFFFF);
    return Container(
      width: 1024,
      height: 500,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4F95BF), AppColors.seed],
        ),
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned(
            left: 72,
            top: 0,
            bottom: 0,
            width: 520,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    RawImage(image: logo, width: 88, height: 88),
                    const SizedBox(width: 24),
                    const Text(
                      'Budget',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 64,
                        fontWeight: FontWeight.w700,
                        color: white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Text(
                  de
                      ? 'Haushaltsbudget planen –\nprivat und offline.'
                      : 'Plan your household budget –\nprivate and offline.',
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 34,
                    height: 1.25,
                    fontWeight: FontWeight.w500,
                    color: white,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  de
                      ? 'Kein Konto · keine Bankanbindung · verschlüsselt'
                      : 'No account · no bank login · encrypted',
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 22,
                    color: Color(0xE6FFFFFF),
                  ),
                ),
              ],
            ),
          ),
          // Telefon-Ausschnitt rechts, unten angeschnitten.
          Positioned(
            right: 70,
            top: 50,
            width: 300,
            height: 534,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF15202B),
                borderRadius: BorderRadius.circular(36),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x55000000),
                    blurRadius: 30,
                    offset: Offset(0, 12),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(27),
                child: RawImage(
                  image: screenshot,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
