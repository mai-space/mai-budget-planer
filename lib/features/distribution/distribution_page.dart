import 'package:flutter/material.dart';

import '../../data/app_database.dart';
import '../../data/database_provider.dart';
import '../../data/repositories/settings_repository.dart';
import '../../domain/budget.dart';
import '../../domain/money.dart';
import '../../l10n/l10n.dart';
import '../../shell/app_shell.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common.dart';

/// Einkommensverteiler: wer überweist am Monatsanfang wie viel auf welches
/// Konto, was bleibt frei, und wie gleicht der Haushalt fair aus.
class DistributionPage extends StatelessWidget {
  const DistributionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = SnapshotScope.of(context).snapshot;
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.tabDistribution),
        actions: const [PeriodToggle()],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          Text(
            l10n.distributionIntro,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.muted),
          ),
          const SizedBox(height: 12),
          for (final plan in s.plans) ...[
            _PlanCard(plan: plan),
            const SizedBox(height: 12),
          ],
          if (s.persons.length > 1) ...[
            _FairnessCard(snapshot: s),
            const SizedBox(height: 12),
          ],
          if (s.projections.isNotEmpty) _SavingsCard(snapshot: s),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({required this.plan});

  final PersonPlan plan;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final negative = plan.remainder < 0;
    return PaddedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              PersonDot(colorIndex: plan.person.colorIndex, size: 14),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  plan.person.name,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              PeriodAmount(plan.income),
            ],
          ),
          const SizedBox(height: 8),
          for (final t in plan.transfers)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Icon(
                    t.account?.kind == AccountKind.savings
                        ? Icons.savings_outlined
                        : Icons.arrow_forward,
                    size: 18,
                    color: AppColors.muted,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      t.account?.name ?? l10n.distributionNoAccount,
                      style: t.account == null
                          ? const TextStyle(fontStyle: FontStyle.italic)
                          : null,
                    ),
                  ),
                  PeriodAmount(t.monthly),
                ],
              ),
            ),
          const Divider(height: 20),
          Row(
            children: [
              Icon(
                Icons.account_balance_wallet_outlined,
                size: 18,
                color: negative ? AppColors.danger : AppColors.positive,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  plan.mainAccount == null
                      ? l10n.distributionRemainder
                      : l10n.distributionRemainderTo(plan.mainAccount!.name),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              PeriodAmount(
                plan.remainder,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: negative ? AppColors.danger : AppColors.positive,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Fairer Ausgleich zwischen den Personen.
class _FairnessCard extends StatelessWidget {
  const _FairnessCard({required this.snapshot});

  final BudgetSnapshot snapshot;

  Future<void> _chooseMode(BuildContext context) async {
    final l10n = context.l10n;
    final current = snapshot.settings.splitMode;
    final mode = await showDialog<SplitMode>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(l10n.splitTitle),
        children: [
          RadioGroup<SplitMode>(
            groupValue: current,
            onChanged: (v) => Navigator.pop(context, v),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final m in SplitMode.values)
                  RadioListTile<SplitMode>(
                    value: m,
                    title: Text(l10n.splitModeName(m)),
                    subtitle: Text(l10n.splitModeHint(m)),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
    if (mode != null && context.mounted) {
      await SettingsRepository(DatabaseScope.of(context)).setSplitMode(mode);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final mode = snapshot.settings.splitMode;
    return PaddedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionTitle(
            l10n.distributionFairness,
            trailing: TextButton(
              onPressed: () => _chooseMode(context),
              child: Text(l10n.commonChange),
            ),
          ),
          Text(
            '${l10n.splitModeName(mode)} — ${l10n.splitModeHint(mode)}',
            style: const TextStyle(color: AppColors.muted),
          ),
          const SizedBox(height: 12),
          if (snapshot.settlements.isEmpty)
            Row(
              children: [
                const Icon(Icons.check_circle_outline, color: AppColors.positive),
                const SizedBox(width: 8),
                Expanded(child: Text(l10n.distributionBalanced)),
              ],
            )
          else
            for (final st in snapshot.settlements)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    PersonDot(colorIndex: st.from.colorIndex),
                    const SizedBox(width: 6),
                    const Icon(Icons.arrow_forward, size: 16),
                    const SizedBox(width: 6),
                    PersonDot(colorIndex: st.to.colorIndex),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        l10n.distributionSettlement(st.from.name, st.to.name),
                      ),
                    ),
                    PeriodAmount(
                      st.monthly,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}

/// Sparkonten: Einzahlung, Zins und Stand nach zwölf Monaten.
class _SavingsCard extends StatelessWidget {
  const _SavingsCard({required this.snapshot});

  final BudgetSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    return PaddedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionTitle(l10n.distributionSavings),
          for (final p in snapshot.projections)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          p.account.name,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(Money.format(p.balanceAfterYear)),
                    ],
                  ),
                  Text(
                    l10n.distributionProjection(
                      Money.format(p.monthlyDeposit),
                      Money.rate(p.account.interestRate ?? 0),
                      Money.format(p.interest),
                    ),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.muted,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 4),
          Text(
            l10n.distributionProjectionHint,
            style: theme.textTheme.bodySmall?.copyWith(color: AppColors.muted),
          ),
        ],
      ),
    );
  }
}
