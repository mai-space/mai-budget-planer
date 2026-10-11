import 'package:intl/intl.dart';

/// Formatiert und liest Geldbeträge (Cent als `int`, Euro).
abstract final class Money {
  static NumberFormat _format(int digits) => NumberFormat.currency(
    locale: Intl.defaultLocale,
    name: 'EUR',
    symbol: '€',
    decimalDigits: digits,
  );

  /// „1.234,56 €“ bzw. „€1,234.56“.
  static String format(num cents, {bool whole = false}) =>
      _format(whole ? 0 : 2).format(cents / 100);

  /// Wie [format], mit Vorzeichen bei positiven Werten.
  static String signed(num cents) =>
      cents > 0 ? '+${format(cents)}' : format(cents);

  /// Prozentwert mit zwei Nachkommastellen in der App-Sprache („2,80“).
  static String rate(double percent) =>
      NumberFormat('0.00', Intl.defaultLocale).format(percent);

  /// Für Eingabefelder: „12,50“ (ohne Symbol, ohne Tausenderpunkte).
  static String edit(int cents) {
    final decimal = NumberFormat.decimalPattern(Intl.defaultLocale)
        .symbols
        .DECIMAL_SEP;
    final euros = cents ~/ 100;
    final rest = (cents.abs() % 100).toString().padLeft(2, '0');
    final sign = cents < 0 && euros == 0 ? '-' : '';
    return rest == '00' ? '$sign$euros' : '$sign$euros$decimal$rest';
  }

  /// Liest Eingaben wie „12,50“, „1.234,56“, „12.5“ und einfache Rechnungen
  /// wie „2,49 + 2,49 + 5“ oder „195,05 / 12“ (wie in einer Tabelle).
  /// `null` bei ungültiger Eingabe.
  static int? parse(String input) {
    final text = input.replaceAll(RegExp(r'[€\s]'), '');
    if (text.isEmpty) return null;
    final tokens = RegExp(r'[0-9.,]+|[-+*/]').allMatches(text).toList();
    if (tokens.map((m) => m.group(0)!).join() != text) return null;

    // Shunting-yard light: * und / vor + und -.
    final values = <double>[];
    final ops = <String>[];
    var expectNumber = true;
    var negate = false;
    void reduce() {
      final b = values.removeLast();
      final a = values.removeLast();
      values.add(switch (ops.removeLast()) {
        '+' => a + b,
        '-' => a - b,
        '*' => a * b,
        _ => a / b,
      });
    }

    int rank(String op) => op == '+' || op == '-' ? 1 : 2;
    for (final m in tokens) {
      final t = m.group(0)!;
      if (expectNumber) {
        if (t == '-' && !negate) {
          negate = true;
          continue;
        }
        final value = _number(t);
        if (value == null) return null;
        values.add(negate ? -value : value);
        negate = false;
        expectNumber = false;
      } else {
        if (!'+-*/'.contains(t)) return null;
        while (ops.isNotEmpty && rank(ops.last) >= rank(t)) {
          reduce();
        }
        ops.add(t);
        expectNumber = true;
      }
    }
    if (expectNumber) return null;
    while (ops.isNotEmpty) {
      reduce();
    }
    final result = values.single;
    if (result.isNaN || result.isInfinite) return null;
    return (result * 100).round();
  }

  /// Eine Zahl mit Komma oder Punkt als Dezimaltrenner. Ein einzelner
  /// Trenner vor genau drei Ziffern gilt als Tausendertrenner, wenn er das
  /// in der App-Sprache ist („1.234“ auf Deutsch, „1,234“ auf Englisch).
  static double? _number(String t) {
    var s = t;
    final comma = s.lastIndexOf(',');
    final dot = s.lastIndexOf('.');
    if (comma >= 0 && dot >= 0) {
      // Der hintere Trenner ist der Dezimaltrenner.
      final decimal = comma > dot ? ',' : '.';
      final thousands = decimal == ',' ? '.' : ',';
      s = s.replaceAll(thousands, '').replaceAll(decimal, '.');
    } else {
      final group = NumberFormat.decimalPattern(Intl.defaultLocale)
          .symbols
          .GROUP_SEP;
      final grouped = RegExp('^\\d{1,3}(${RegExp.escape(group)}\\d{3})+\$');
      s = grouped.hasMatch(s) ? s.replaceAll(group, '') : s.replaceAll(',', '.');
    }
    if (s.split('.').length > 2) return null;
    return double.tryParse(s);
  }
}
