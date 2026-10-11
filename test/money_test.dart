import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mai_budget_planer/domain/money.dart';
import 'package:mai_budget_planer/l10n/l10n.dart';

void main() {
  tearDown(() => AppLocale.update(AppLocale.german));

  test('formats euros in German', () {
    expect(Money.format(123456), '1.234,56 €');
    expect(Money.format(-5000), '-50,00 €');
    expect(Money.format(123456, whole: true), '1.235 €');
    expect(Money.signed(100), startsWith('+'));
  });

  test('edit text round-trips through parse', () {
    for (final cents in [0, 5, 50, 1999, 120000, 123456]) {
      expect(Money.parse(Money.edit(cents)), cents, reason: '$cents');
    }
    expect(Money.edit(120000), '1200');
    expect(Money.edit(1999), '19,99');
  });

  test('parses German input', () {
    expect(Money.parse('12,50'), 1250);
    expect(Money.parse('12.5'), 1250);
    expect(Money.parse('1.234,56'), 123456);
    expect(Money.parse('1.234'), 123400, reason: 'Tausenderpunkt');
    expect(Money.parse('1.234.567'), 123456700);
    expect(Money.parse(' 99 € '), 9900);
    expect(Money.parse('0,99'), 99);
  });

  test('parses simple calculations like a spreadsheet', () {
    expect(Money.parse('2,49 + 2,49 + 5'), 998);
    expect(Money.parse('195,05/12'), 1625);
    expect(Money.parse('15*4'), 6000);
    expect(Money.parse('110,45 - 50'), 6045);
    expect(Money.parse('10 + 2 * 3'), 1600);
    expect(Money.parse('-5 + 10'), 500);
  });

  test('rejects garbage', () {
    for (final input in ['', 'abc', '12,,5', '1+', '*3', '1.2.3,4,5', '5/0']) {
      expect(Money.parse(input), isNull, reason: input);
    }
  });

  test('English input uses comma as thousands separator', () {
    AppLocale.update(AppLocale.english);
    expect(Intl.defaultLocale, 'en');
    expect(Money.parse('1,234'), 123400);
    expect(Money.parse('1,234.56'), 123456);
    expect(Money.parse('12.50'), 1250);
    expect(Money.format(123456), '€1,234.56');
  });
}
