import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Längengrenzen der Play Console für die Texte in store/android/.
const _limits = {
  'title.txt': 30,
  'short-description.txt': 80,
  'full-description.txt': 4000,
  'release-notes.txt': 500,
};

void main() {
  for (final lang in ['de-DE', 'en-US']) {
    test('Store-Texte $lang innerhalb der Play-Grenzen', () {
      for (final entry in _limits.entries) {
        final file = File('store/android/$lang/${entry.key}');
        expect(file.existsSync(), isTrue, reason: file.path);
        final text = file.readAsStringSync().trimRight();
        expect(text, isNotEmpty, reason: file.path);
        expect(
          text.runes.length,
          lessThanOrEqualTo(entry.value),
          reason: file.path,
        );
      }
    });
  }
}
