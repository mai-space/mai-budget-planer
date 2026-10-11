import 'package:flutter/material.dart';

import '../../domain/budget.dart';
import '../../domain/insights.dart';
import '../../domain/money.dart';
import '../../l10n/l10n.dart';
import '../../shell/app_shell.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common.dart';
import '../items/item_form_page.dart';

/// Optimierungsvorschläge aus festen, nachvollziehbaren Regeln — lokal
/// berechnet, keine Anlageberatung.
class InsightsPage extends StatelessWidget {
  const InsightsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = SnapshotScope.of(context).snapshot;
    final l10n = context.l10n;
    final insights = Insights.analyze(s);
    final potential = Insights.totalPotential(insights);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.tabInsights)),
      body: insights.isEmpty
          ? Center(
              child: EmptyState(
                icon: Icons.thumb_up_alt_outlined,
                title: l10n.insightsEmptyTitle,
                message: l10n.insightsEmptyText,
              ),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
              children: [
                if (potential >= 100)
                  PaddedCard(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(l10n.insightsPotentialTitle),
                        Text(
                          l10n.insightsPotentialValue(
                            Money.format(potential),
                            Money.format(potential * 12, whole: true),
                          ),
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 12),
                for (final insight in insights) ...[
                  _InsightCard(snapshot: s, insight: insight),
                  const SizedBox(height: 12),
                ],
                Text(
                  l10n.insightsDisclaimer,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.muted,
                  ),
                ),
              ],
            ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  const _InsightCard({required this.snapshot, required this.insight});

  final BudgetSnapshot snapshot;
  final Insight insight;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final (title, body) = insightTexts(l10n, insight);
    final (icon, color) = switch (insight.severity) {
      InsightSeverity.warning => (Icons.warning_amber_rounded, AppColors.danger),
      InsightSeverity.tip => (Icons.lightbulb_outline, AppColors.warning),
      InsightSeverity.info => (Icons.info_outline, AppColors.needs),
    };
    return PaddedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if ((insight.monthlyPotential ?? 0) >= 100)
                Text(
                  l10n.insightsPerMonth(Money.format(insight.monthlyPotential!)),
                  style: const TextStyle(
                    color: AppColors.positive,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(body),
          if (insight.items.isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final item in insight.items.take(8))
                  ActionChip(
                    label: Text(item.label),
                    onPressed: () =>
                        openItemForm(context, snapshot, item: item),
                  ),
                if (insight.items.length > 8)
                  Chip(label: Text('+${insight.items.length - 8}')),
              ],
            ),
          ],
          if (insight.accounts.isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              children: [
                for (final a in insight.accounts) Chip(label: Text(a.name)),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// Titel und Text eines Vorschlags in der App-Sprache.
(String, String) insightTexts(AppLocalizations l10n, Insight i) {
  String money(double? cents) => Money.format(cents ?? 0);
  String pct(double? v) => (v ?? 0).toStringAsFixed(0);
  return switch (i.kind) {
    InsightKind.deficit => (
      l10n.insightDeficitTitle,
      l10n.insightDeficitText(money(i.amount)),
    ),
    InsightKind.needsOverTarget => (
      l10n.insightNeedsTitle,
      l10n.insightNeedsText(pct(i.percent), i.targetPercent!, money(i.amount)),
    ),
    InsightKind.savingsUnderTarget => (
      l10n.insightSavingsTitle,
      l10n.insightSavingsText(
        pct(i.percent),
        i.targetPercent!,
        money(i.amount),
      ),
    ),
    InsightKind.flaggedPotential => (
      l10n.insightFlaggedTitle,
      l10n.insightFlaggedText(i.items.length),
    ),
    InsightKind.duplicateContract => (
      l10n.insightDuplicateTitle(i.label ?? ''),
      l10n.insightDuplicateText(i.items.length, money(i.amount)),
    ),
    InsightKind.overlappingSubscriptions => (
      l10n.insightOverlapTitle(i.label ?? ''),
      l10n.insightOverlapText(i.items.length),
    ),
    InsightKind.insurancePaidMonthly => (
      l10n.insightInsuranceTitle,
      l10n.insightInsuranceText(i.items.length),
    ),
    InsightKind.zeroAmount => (
      l10n.insightZeroTitle,
      l10n.insightZeroText(i.items.length),
    ),
    InsightKind.lowInterest => (
      l10n.insightInterestTitle,
      l10n.insightInterestText(Insights.fairInterestRate.toStringAsFixed(1)),
    ),
    InsightKind.emergencyFund => (
      l10n.insightEmergencyTitle,
      i.percent == null
          ? l10n.insightEmergencyUnknown(money(i.amount))
          : l10n.insightEmergencyText(money(i.amount), pct(i.percent)),
    ),
    InsightKind.biggestWant => (
      l10n.insightBiggestWantTitle(i.label ?? ''),
      l10n.insightBiggestWantText(pct(i.percent), money(i.amount)),
    ),
    InsightKind.missingAccount => (
      l10n.insightMissingAccountTitle,
      l10n.insightMissingAccountText(i.items.length),
    ),
    InsightKind.annualReserve => (
      l10n.insightReserveTitle,
      l10n.insightReserveText(money(i.amount)),
    ),
  };
}
