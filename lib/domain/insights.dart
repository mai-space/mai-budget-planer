import '../data/app_database.dart';
import 'budget.dart';

/// Art eines Optimierungsvorschlags; Texte baut die Oberfläche.
enum InsightKind {
  /// Ausgaben übersteigen das Einkommen.
  deficit,

  /// Fixkosten über dem Zielanteil der Budgetregel.
  needsOverTarget,

  /// Sparquote unter dem Zielanteil.
  savingsUnderTarget,

  /// Selbst markierte Sparpotenziale an Posten.
  flaggedPotential,

  /// Gleiches Abo/gleicher Vertrag mehrfach (Partner-/Familientarif?).
  duplicateContract,

  /// Mehrere Abos mit derselben Unterkategorie (z. B. Streaming).
  overlappingSubscriptions,

  /// Versicherungen mit unterjähriger Zahlweise.
  insurancePaidMonthly,

  /// Posten ohne Betrag.
  zeroAmount,

  /// Sparkonto ohne oder mit niedrigem Zins.
  lowInterest,

  /// Notgroschen (3 Monate Fixkosten) noch nicht erreicht/unbekannt.
  emergencyFund,

  /// Größter Wunsch-Posten im Verhältnis zum Einkommen.
  biggestWant,

  /// Posten ohne Konto — Verteiler unvollständig.
  missingAccount,

  /// Monatliche Rücklage für Jahreszahlungen.
  annualReserve,
}

enum InsightSeverity { warning, tip, info }

class Insight {
  const Insight({
    required this.kind,
    required this.severity,
    this.monthlyPotential,
    this.items = const [],
    this.accounts = const [],
    this.percent,
    this.targetPercent,
    this.amount,
    this.label,
  });

  final InsightKind kind;
  final InsightSeverity severity;

  /// Geschätzte Ersparnis je Monat in Cent (falls abschätzbar).
  final double? monthlyPotential;
  final List<BudgetItem> items;
  final List<Account> accounts;

  /// Ist-Anteil in % (Budgetregel).
  final double? percent;

  /// Ziel-Anteil in %.
  final int? targetPercent;

  /// Zusätzlicher Betrag in Cent (Bedeutung je [kind]).
  final double? amount;

  /// Zusätzlicher Text (z. B. Name des Postens/der Unterkategorie).
  final String? label;
}

/// Regeln für Optimierungsvorschläge — rein lokal, ohne Netz.
abstract final class Insights {
  /// Zins, ab dem ein Tagesgeld als „marktüblich“ gilt (% p. a.).
  static const fairInterestRate = 2.0;

  /// Typische Ersparnis bei jährlicher statt monatlicher Zahlweise.
  static const annualPaymentDiscount = 0.04;

  /// Anteil am Nettoeinkommen, ab dem ein Wunsch-Posten auffällt.
  static const bigWantShare = 0.05;

  static List<Insight> analyze(BudgetSnapshot s) {
    final result = <Insight>[];
    final income = s.totalIncome;

    if (income > 0 && s.freeRemainder < -50) {
      result.add(
        Insight(
          kind: InsightKind.deficit,
          severity: InsightSeverity.warning,
          amount: -s.freeRemainder,
        ),
      );
    }

    if (income > 0) {
      final needs = s.shareOf(BudgetBucket.needs)!;
      if (needs > s.targetOf(BudgetBucket.needs) + 0.005) {
        result.add(
          Insight(
            kind: InsightKind.needsOverTarget,
            severity: InsightSeverity.tip,
            percent: needs * 100,
            targetPercent: s.settings.ruleNeeds,
            amount: (needs - s.targetOf(BudgetBucket.needs)) * income,
          ),
        );
      }
      final savings = s.shareOf(BudgetBucket.savings)!;
      if (savings < s.targetOf(BudgetBucket.savings) - 0.005) {
        result.add(
          Insight(
            kind: InsightKind.savingsUnderTarget,
            severity: InsightSeverity.tip,
            percent: savings * 100,
            targetPercent: s.settings.ruleSavings,
            amount: (s.targetOf(BudgetBucket.savings) - savings) * income,
          ),
        );
      }
    }

    final flagged = [
      for (final i in s.items)
        if ((i.savingsPotentialCents ?? 0) > 0) i,
    ];
    if (flagged.isNotEmpty) {
      result.add(
        Insight(
          kind: InsightKind.flaggedPotential,
          severity: InsightSeverity.tip,
          items: flagged,
          monthlyPotential: flagged.fold<double>(
            0,
            (sum, i) => sum + i.savingsPotentialCents!,
          ),
        ),
      );
    }

    // Gleicher Name mehrfach (z. B. Fitnessstudio für beide).
    final byLabel = <String, List<BudgetItem>>{};
    for (final item in s.items) {
      if (s.bucketOf(item) == BudgetBucket.savings) continue;
      byLabel.putIfAbsent(_normalize(item.label), () => []).add(item);
    }
    for (final group in byLabel.values) {
      if (group.length < 2) continue;
      result.add(
        Insight(
          kind: InsightKind.duplicateContract,
          severity: InsightSeverity.tip,
          items: group,
          label: group.first.label,
          amount: group.fold<double>(
            0,
            (sum, i) => sum + BudgetSnapshot.monthly(i),
          ),
        ),
      );
    }

    // Mehrere Abos derselben Unterkategorie → rotieren statt parallel.
    final byTag = <String, List<BudgetItem>>{};
    for (final item in s.items) {
      final tag = item.tag?.trim();
      if (tag == null || tag.isEmpty) continue;
      if (s.categoryOf(item)?.systemKey != CategoryKey.subscriptions) continue;
      byTag.putIfAbsent(tag.toLowerCase(), () => []).add(item);
    }
    for (final group in byTag.values) {
      // Gleiche Abos zählen schon als Duplikat.
      final distinct = group.map((i) => _normalize(i.label)).toSet();
      if (distinct.length < 2) continue;
      final sums = group.map(BudgetSnapshot.monthly).toList()..sort();
      result.add(
        Insight(
          kind: InsightKind.overlappingSubscriptions,
          severity: InsightSeverity.tip,
          items: group,
          label: group.first.tag!.trim(),
          // Nur das teuerste behalten.
          monthlyPotential:
              sums.fold(0.0, (a, b) => a + b) - sums.last,
        ),
      );
    }

    final insuranceMonthly = [
      for (final i in s.items)
        if (s.categoryOf(i)?.systemKey == CategoryKey.insurance &&
            i.amountCents > 0 &&
            (i.interval == PayInterval.monthly ||
                i.interval == PayInterval.quarterly ||
                i.interval == PayInterval.halfYearly))
          i,
    ];
    if (insuranceMonthly.isNotEmpty) {
      final sum = insuranceMonthly.fold(
        0.0,
        (a, i) => a + BudgetSnapshot.monthly(i),
      );
      result.add(
        Insight(
          kind: InsightKind.insurancePaidMonthly,
          severity: InsightSeverity.tip,
          items: insuranceMonthly,
          monthlyPotential: sum * annualPaymentDiscount,
        ),
      );
    }

    final zero = [
      for (final i in s.items)
        if (i.amountCents == 0) i,
    ];
    if (zero.isNotEmpty) {
      result.add(
        Insight(
          kind: InsightKind.zeroAmount,
          severity: InsightSeverity.info,
          items: zero,
        ),
      );
    }

    final lowInterest = <Account>[];
    var lostInterest = 0.0;
    for (final p in s.projections) {
      final rate = p.account.interestRate ?? 0;
      if (rate >= fairInterestRate) continue;
      if (p.monthlyDeposit <= 0 && (p.account.balanceCents ?? 0) <= 0) {
        continue;
      }
      lowInterest.add(p.account);
      // Grob: Durchschnittsguthaben im Jahr × Zinsdifferenz.
      final average = p.startBalance + p.monthlyDeposit * 6;
      lostInterest += average * (fairInterestRate - rate) / 100 / 12;
    }
    if (lowInterest.isNotEmpty) {
      result.add(
        Insight(
          kind: InsightKind.lowInterest,
          severity: InsightSeverity.tip,
          accounts: lowInterest,
          monthlyPotential: lostInterest,
        ),
      );
    }

    final needsMonthly = s.byBucket[BudgetBucket.needs]!;
    if (needsMonthly > 0) {
      final target = needsMonthly * 3;
      final known = [
        for (final a in s.accounts)
          if (a.kind == AccountKind.savings && a.balanceCents != null) a,
      ];
      final balance = known.fold(0.0, (sum, a) => sum + a.balanceCents!);
      if (known.isEmpty || balance < target) {
        result.add(
          Insight(
            kind: InsightKind.emergencyFund,
            severity: known.isEmpty ? InsightSeverity.info : InsightSeverity.tip,
            amount: target,
            percent: known.isEmpty ? null : balance / target * 100,
          ),
        );
      }
    }

    if (income > 0) {
      BudgetItem? biggest;
      for (final i in s.items) {
        if (s.bucketOf(i) != BudgetBucket.wants) continue;
        if (biggest == null ||
            BudgetSnapshot.monthly(i) > BudgetSnapshot.monthly(biggest)) {
          biggest = i;
        }
      }
      if (biggest != null &&
          BudgetSnapshot.monthly(biggest) >= income * bigWantShare) {
        result.add(
          Insight(
            kind: InsightKind.biggestWant,
            severity: InsightSeverity.info,
            items: [biggest],
            label: biggest.label,
            percent: BudgetSnapshot.monthly(biggest) / income * 100,
            amount: monthlyOf(biggest.amountCents, biggest.interval) * 12,
          ),
        );
      }
    }

    final noAccount = [
      for (final i in s.items)
        if (i.accountId == null) i,
    ];
    if (noAccount.isNotEmpty && s.accounts.isNotEmpty) {
      result.add(
        Insight(
          kind: InsightKind.missingAccount,
          severity: InsightSeverity.info,
          items: noAccount,
        ),
      );
    }

    if (s.annualReserve > 0) {
      result.add(
        Insight(
          kind: InsightKind.annualReserve,
          severity: InsightSeverity.info,
          amount: s.annualReserve,
          items: [
            for (final i in s.items)
              if (i.interval != PayInterval.monthly &&
                  i.interval != PayInterval.weekly)
                i,
          ],
        ),
      );
    }

    result.sort((a, b) {
      final bySeverity = a.severity.index.compareTo(b.severity.index);
      if (bySeverity != 0) return bySeverity;
      return (b.monthlyPotential ?? 0).compareTo(a.monthlyPotential ?? 0);
    });
    return result;
  }

  /// Summe aller abschätzbaren Ersparnisse je Monat.
  static double totalPotential(List<Insight> insights) =>
      insights.fold(0.0, (sum, i) => sum + (i.monthlyPotential ?? 0));

  static String _normalize(String label) =>
      label.toLowerCase().replaceAll(RegExp(r'\s*\(.*?\)'), '').trim();
}
