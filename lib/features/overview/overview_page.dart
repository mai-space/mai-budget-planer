import 'package:flutter/material.dart';

import '../../data/app_database.dart';
import '../../domain/budget.dart';
import '../../domain/insights.dart';
import '../../domain/money.dart';
import '../../l10n/l10n.dart';
import '../../shell/app_shell.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common.dart';
import '../items/item_form_page.dart';

/// Übersicht: Einkommen, geplante Posten, frei verfügbar, Budgetregel,
/// Bereiche und Rücklagen — entspricht dem Blatt „Übersicht“.
class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = SnapshotScope.of(context);
    final s = scope.snapshot;
    final l10n = context.l10n;
    final insights = Insights.analyze(s);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.tabOverview),
        actions: const [PeriodToggle()],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _SummaryCard(snapshot: s),
          const SizedBox(height: 12),
          if (s.items.isEmpty)
            PaddedCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(l10n.overviewEmptyTitle,
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(l10n.overviewEmptyText),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed: () => openItemForm(context, s),
                    icon: const Icon(Icons.add),
                    label: Text(l10n.itemsAdd),
                  ),
                ],
              ),
            )
          else ...[
            _RuleCard(snapshot: s),
            const SizedBox(height: 12),
            _CategoryCard(snapshot: s),
            const SizedBox(height: 12),
            _ReserveCard(snapshot: s),
          ],
          if (insights.isNotEmpty) ...[
            const SizedBox(height: 12),
            _InsightsTeaser(
              insights: insights,
              onOpen: () => scope.openTab(AppTab.insights),
            ),
          ],
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.snapshot});

  final BudgetSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final s = snapshot;
    final free = s.freeRemainder;
    return PaddedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.overviewFree, style: theme.textTheme.labelLarge),
          PeriodAmount(
            free,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: free < 0 ? AppColors.danger : AppColors.positive,
            ),
          ),
          const SizedBox(height: 12),
          _Line(label: l10n.overviewIncome, monthly: s.totalIncome),
          _Line(
            label: l10n.overviewPlanned,
            monthly: -s.totalPlanned,
            hint: l10n.overviewPlannedHint,
          ),
          if (s.persons.length > 1) ...[
            const Divider(height: 24),
            for (final plan in s.plans)
              _Line(
                label: l10n.overviewFreeOf(plan.person.name),
                monthly: plan.remainder,
                leading: PersonDot(colorIndex: plan.person.colorIndex),
              ),
          ],
          if (s.deductionRate case final rate?) ...[
            const SizedBox(height: 8),
            Text(
              l10n.overviewDeductions((rate * 100).toStringAsFixed(1)),
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.muted,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({
    required this.label,
    required this.monthly,
    this.hint,
    this.leading,
  });

  final String label;
  final double monthly;
  final String? hint;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          if (leading != null) ...[leading!, const SizedBox(width: 8)],
          Expanded(
            child: hint == null
                ? Text(label)
                : Tooltip(message: hint, child: Text(label)),
          ),
          PeriodAmount(monthly),
        ],
      ),
    );
  }
}

/// Budgetregel (z. B. 50/30/20): Ist gegen Ziel je Topf.
class _RuleCard extends StatelessWidget {
  const _RuleCard({required this.snapshot});

  final BudgetSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final s = snapshot.settings;
    return PaddedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionTitle(
            l10n.overviewRuleTitle(s.ruleNeeds, s.ruleWants, s.ruleSavings),
          ),
          if (snapshot.totalIncome <= 0)
            Text(l10n.overviewRuleNoIncome)
          else
            for (final bucket in BudgetBucket.values) ...[
              _BucketBar(snapshot: snapshot, bucket: bucket),
              const SizedBox(height: 10),
            ],
          Text(
            l10n.overviewRuleHint,
            style: theme.textTheme.bodySmall?.copyWith(color: AppColors.muted),
          ),
        ],
      ),
    );
  }
}

class _BucketBar extends StatelessWidget {
  const _BucketBar({required this.snapshot, required this.bucket});

  final BudgetSnapshot snapshot;
  final BudgetBucket bucket;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final share = snapshot.shareOf(bucket) ?? 0;
    final target = snapshot.targetOf(bucket);
    final color = bucketColor(bucket);
    final over = bucket == BudgetBucket.savings
        ? share < target - 0.005
        : share > target + 0.005;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: Text(l10n.bucketName(bucket))),
            Text(
              l10n.overviewRuleShare(
                (share * 100).toStringAsFixed(0),
                (target * 100).round(),
              ),
              style: TextStyle(
                color: over ? AppColors.warning : null,
                fontWeight: over ? FontWeight.w600 : null,
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 96,
              child: PeriodAmount(snapshot.byBucket[bucket]!),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            return Stack(
              children: [
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Container(
                  height: 8,
                  width: width * share.clamp(0.0, 1.0),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                // Zielmarke.
                Positioned(
                  left: (width * target).clamp(0.0, width - 2),
                  child: Container(width: 2, height: 8, color: AppColors.ink),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

/// Summen je Bereich (Wohnen, Versicherungen, …).
class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.snapshot});

  final BudgetSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final income = snapshot.totalIncome;
    return PaddedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionTitle(l10n.overviewCategories),
          for (final (category, sum) in snapshot.byCategory)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Icon(
                    categoryIcon(category.icon),
                    size: 20,
                    color: bucketColor(category.bucket),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(category.name, overflow: TextOverflow.ellipsis),
                  ),
                  const SizedBox(width: 8),
                  if (income > 0)
                    Text(
                      '${(sum / income * 100).toStringAsFixed(0)} %',
                      style: const TextStyle(color: AppColors.muted),
                    ),
                  const SizedBox(width: 12),
                  SizedBox(width: 96, child: PeriodAmount(sum)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// Rücklage für Jahres-/Quartalszahlungen und demnächst fällige Posten.
class _ReserveCard extends StatelessWidget {
  const _ReserveCard({required this.snapshot});

  final BudgetSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final due = snapshot.dueSoon(DateTime.now());
    if (snapshot.annualReserve <= 0) return const SizedBox.shrink();
    return PaddedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionTitle(l10n.overviewReserveTitle),
          Text(l10n.overviewReserveText(Money.format(snapshot.annualReserve))),
          if (due.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(l10n.overviewDueSoon, style: theme.textTheme.labelLarge),
            for (final (item, months) in due)
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: Text(item.label),
                subtitle: Text(
                  months == 0
                      ? l10n.overviewDueThisMonth
                      : l10n.overviewDueInMonths(months),
                ),
                trailing: Text(
                  Money.format(item.amountCents),
                  style: theme.textTheme.bodyLarge,
                ),
                onTap: () => openItemForm(context, snapshot, item: item),
              ),
          ],
        ],
      ),
    );
  }
}

class _InsightsTeaser extends StatelessWidget {
  const _InsightsTeaser({required this.insights, required this.onOpen});

  final List<Insight> insights;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final potential = Insights.totalPotential(insights);
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: const Icon(Icons.lightbulb_outline),
        title: Text(l10n.overviewInsights(insights.length)),
        subtitle: potential >= 100
            ? Text(l10n.overviewInsightsPotential(Money.format(potential)))
            : null,
        trailing: const Icon(Icons.chevron_right),
        onTap: onOpen,
      ),
    );
  }
}
