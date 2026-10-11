import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mai_budget_planer/l10n/l10n.dart';

void main() {
  test('system language picks German or English, otherwise English', () {
    expect(AppLocale.resolve(const [Locale('de', 'AT')]), AppLocale.german);
    expect(AppLocale.resolve(const [Locale('en', 'US')]), AppLocale.english);
    expect(
      AppLocale.resolve(const [Locale('fr'), Locale('de')]),
      AppLocale.german,
    );
    expect(AppLocale.resolve(const [Locale('fr')]), AppLocale.english);
    expect(AppLocale.resolve(const []), AppLocale.english);
  });

  test('every part exists in German and English with the same keys', () {
    final parts = Directory('lib/l10n/parts').listSync().whereType<File>();
    final byPart = <String, Map<String, Set<String>>>{};
    for (final file in parts) {
      final name = file.uri.pathSegments.last; // bereich.de.json
      final [part, lang, _] = name.split('.');
      final keys = (jsonDecode(file.readAsStringSync()) as Map<String, dynamic>)
          .keys
          .where((k) => !k.startsWith('@'))
          .toSet();
      byPart.putIfAbsent(part, () => {})[lang] = keys;
    }
    expect(byPart, isNotEmpty);
    for (final MapEntry(key: part, value: langs) in byPart.entries) {
      expect(langs.keys.toSet(), {'de', 'en'}, reason: part);
      expect(langs['de'], langs['en'], reason: part);
    }
  });

  test('generated ARB files are up to date with the parts', () {
    for (final lang in ['de', 'en']) {
      final arb =
          jsonDecode(File('lib/l10n/app_$lang.arb').readAsStringSync())
              as Map<String, dynamic>;
      final parts = Directory('lib/l10n/parts')
          .listSync()
          .whereType<File>()
          .where((f) => f.path.endsWith('.$lang.json'));
      for (final file in parts) {
        final entries =
            jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
        for (final MapEntry(:key, :value) in entries.entries) {
          expect(
            arb[key],
            value,
            reason: '$key — python3 tool/merge_arb.py ausführen',
          );
        }
      }
    }
  });
}
