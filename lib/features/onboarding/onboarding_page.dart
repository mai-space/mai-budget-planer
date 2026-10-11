import 'package:flutter/material.dart';

import '../../data/database_provider.dart';
import '../../data/repositories/household_repository.dart';
import '../../data/repositories/settings_repository.dart';
import '../../domain/money.dart';
import '../../l10n/l10n.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/common.dart';

/// Ersteinrichtung: Datenschutz erklären, Haushalt mit Nettoeinkommen anlegen.
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _Member {
  final name = TextEditingController();
  final net = TextEditingController();

  void dispose() {
    name.dispose();
    net.dispose();
  }
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _form = GlobalKey<FormState>();
  final _members = [_Member()];
  int _step = 0;
  bool _saving = false;

  @override
  void dispose() {
    for (final m in _members) {
      m.dispose();
    }
    super.dispose();
  }

  Future<void> _finish() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _saving = true);
    final db = DatabaseScope.of(context);
    final l10n = context.l10n;
    await HouseholdRepository(db).setUpHousehold(
      [
        for (final m in _members)
          (name: m.name.text, netCents: Money.parse(m.net.text) ?? 0),
      ],
      mainAccountName: l10n.onboardingMainAccount,
      incomeLabel: l10n.onboardingIncomeLabel,
    );
    await SettingsRepository(db).completeOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _step == 0 ? _welcome(context) : _household(context)),
    );
  }

  Widget _welcome(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    Widget point(IconData icon, String text) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: theme.colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(child: Text(text)),
        ],
      ),
    );
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const SizedBox(height: 24),
        const Align(alignment: Alignment.centerLeft, child: AppLogo(size: 64)),
        const SizedBox(height: 24),
        Text(
          l10n.onboardingTitle,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.onboardingSubtitle,
          style: theme.textTheme.bodyLarge?.copyWith(color: AppColors.muted),
        ),
        const SizedBox(height: 24),
        point(Icons.lock_outline, l10n.onboardingPointEncrypted),
        point(Icons.cloud_off_outlined, l10n.onboardingPointOffline),
        point(Icons.call_split, l10n.onboardingPointDistribution),
        point(Icons.lightbulb_outline, l10n.onboardingPointInsights),
        const SizedBox(height: 32),
        FilledButton(
          onPressed: () => setState(() => _step = 1),
          child: Text(l10n.commonContinue),
        ),
      ],
    );
  }

  Widget _household(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    return Form(
      key: _form,
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            l10n.onboardingHouseholdTitle,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(l10n.onboardingHouseholdText),
          const SizedBox(height: 24),
          for (final (i, m) in _members.indexed) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 12),
                  child: PersonDot(colorIndex: i, size: 14),
                ),
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    controller: m.name,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(labelText: l10n.commonName),
                    validator: (v) =>
                        (v ?? '').trim().isEmpty ? l10n.commonRequired : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 3,
                  child: MoneyField(
                    controller: m.net,
                    label: l10n.onboardingNet,
                  ),
                ),
                if (_members.length > 1)
                  IconButton(
                    padding: const EdgeInsets.only(top: 12),
                    tooltip: l10n.commonDelete,
                    onPressed: () => setState(() => _members.removeAt(i).dispose()),
                    icon: const Icon(Icons.close),
                  ),
              ],
            ),
            const SizedBox(height: 16),
          ],
          if (_members.length < AppColors.persons.length)
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () => setState(() => _members.add(_Member())),
                icon: const Icon(Icons.person_add_alt),
                label: Text(l10n.householdAddPerson),
              ),
            ),
          const SizedBox(height: 8),
          Text(
            l10n.onboardingHint,
            style: theme.textTheme.bodySmall?.copyWith(color: AppColors.muted),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _saving ? null : _finish,
            child: Text(l10n.onboardingStart),
          ),
          TextButton(
            onPressed: () => setState(() => _step = 0),
            child: Text(l10n.commonBack),
          ),
        ],
      ),
    );
  }
}
