import 'package:flutter/material.dart';

import '../../data/database_provider.dart';
import '../../data/repositories/settings_repository.dart';
import '../../domain/money.dart';
import '../../l10n/l10n.dart';
import '../../shell/app_shell.dart';
import '../../theme/app_theme.dart';
import 'accounts_page.dart';
import 'backup_section.dart';
import 'categories_page.dart';
import 'household_page.dart';
import 'security_section.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Future<void> _editRule(BuildContext context) async {
    final s = SnapshotScope.of(context).snapshot.settings;
    final result = await showDialog<(int, int, int)>(
      context: context,
      builder: (_) => _RuleDialog(
        needs: s.ruleNeeds,
        wants: s.ruleWants,
        savings: s.ruleSavings,
      ),
    );
    if (result != null && context.mounted) {
      await SettingsRepository(DatabaseScope.of(context)).setRule(
        needs: result.$1,
        wants: result.$2,
        savings: result.$3,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = SnapshotScope.of(context).snapshot;
    final l10n = context.l10n;
    final theme = Theme.of(context);
    Widget section(String title) => Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 4),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
    void push(Widget page) => Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (_) => page));
    return Scaffold(
      appBar: AppBar(title: Text(l10n.tabSettings)),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          section(l10n.settingsBudgetSection),
          ListTile(
            leading: const Icon(Icons.people_outline),
            title: Text(l10n.settingsHousehold),
            subtitle: Text(
              l10n.settingsHouseholdSummary(
                s.persons.length,
                Money.format(s.totalIncome),
              ),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => push(const HouseholdPage()),
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_outlined),
            title: Text(l10n.settingsAccounts),
            subtitle: Text(l10n.settingsAccountsSummary(s.accounts.length)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => push(const AccountsPage()),
          ),
          ListTile(
            leading: const Icon(Icons.category_outlined),
            title: Text(l10n.settingsCategories),
            subtitle: Text(
              l10n.settingsCategoriesSummary(s.categories.length),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => push(const CategoriesPage()),
          ),
          ListTile(
            leading: const Icon(Icons.pie_chart_outline),
            title: Text(l10n.settingsRule),
            subtitle: Text(
              l10n.settingsRuleValue(
                s.settings.ruleNeeds,
                s.settings.ruleWants,
                s.settings.ruleSavings,
              ),
            ),
            onTap: () => _editRule(context),
          ),
          section(l10n.settingsSecuritySection),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SecuritySection(),
          ),
          section(l10n.settingsBackupSection),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: BackupSection(),
          ),
          section(l10n.settingsPrivacySection),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              l10n.settingsPrivacyText,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.muted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Budgetregel bearbeiten: Vorlagen oder eigene Werte (Summe 100 %).
class _RuleDialog extends StatefulWidget {
  const _RuleDialog({
    required this.needs,
    required this.wants,
    required this.savings,
  });

  final int needs;
  final int wants;
  final int savings;

  @override
  State<_RuleDialog> createState() => _RuleDialogState();
}

class _RuleDialogState extends State<_RuleDialog> {
  late int _needs = widget.needs;
  late int _wants = widget.wants;

  int get _savings => 100 - _needs - _wants;

  static const _presets = [(50, 30, 20), (60, 20, 20), (70, 20, 10)];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(l10n.settingsRule),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.settingsRuleHint),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              for (final (n, w, s) in _presets)
                ChoiceChip(
                  label: Text('$n/$w/$s'),
                  selected: _needs == n && _wants == w,
                  onSelected: (_) => setState(() {
                    _needs = n;
                    _wants = w;
                  }),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text('${l10n.bucketNeeds}: $_needs %'),
          Slider(
            value: _needs.toDouble(),
            max: 100,
            divisions: 20,
            onChanged: (v) => setState(() {
              _needs = v.round();
              if (_needs + _wants > 100) _wants = 100 - _needs;
            }),
          ),
          Text('${l10n.bucketWants}: $_wants %'),
          Slider(
            value: _wants.toDouble(),
            max: (100 - _needs).toDouble(),
            divisions: ((100 - _needs) ~/ 5).clamp(1, 20),
            onChanged: (v) => setState(() => _wants = v.round()),
          ),
          Text('${l10n.bucketSavings}: $_savings %'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.commonCancel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, (_needs, _wants, _savings)),
          child: Text(l10n.commonSave),
        ),
      ],
    );
  }
}
