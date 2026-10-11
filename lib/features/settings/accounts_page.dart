import 'package:flutter/material.dart';

import '../../data/app_database.dart';
import '../../data/database_provider.dart';
import '../../data/repositories/household_repository.dart';
import '../../domain/budget.dart';
import '../../domain/money.dart';
import '../../l10n/l10n.dart';
import '../../widgets/common.dart';
import '../../widgets/snapshot_builder.dart';

/// Konten und Unterkonten (Ziele im Einkommensverteiler).
class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SnapshotBuilder(
      builder: (context, s) => Scaffold(
        appBar: AppBar(title: Text(l10n.settingsAccounts)),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showAccountSheet(context, s),
          icon: const Icon(Icons.add),
          label: Text(l10n.accountsAdd),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
          children: [
            Text(l10n.accountsIntro),
            const SizedBox(height: 12),
            for (final a in s.accounts)
              Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: Icon(
                    a.kind == AccountKind.savings
                        ? Icons.savings_outlined
                        : a.kind == AccountKind.card
                        ? Icons.credit_card
                        : Icons.account_balance_outlined,
                  ),
                  title: Text(a.name),
                  subtitle: Text(
                    [
                      l10n.accountKindName(a.kind),
                      s.personById(a.ownerPersonId)?.name ??
                          l10n.accountsJoint,
                      if (a.isMain) l10n.accountsMain,
                      if (a.interestRate case final r?)
                        '${Money.rate(r)} %',
                    ].join(' · '),
                  ),
                  trailing: a.balanceCents == null
                      ? null
                      : Text(Money.format(a.balanceCents!)),
                  onTap: () => _showAccountSheet(context, s, account: a),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

Future<void> _showAccountSheet(
  BuildContext context,
  BudgetSnapshot snapshot, {
  Account? account,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (_) => _AccountSheet(snapshot: snapshot, account: account),
  );
}

class _AccountSheet extends StatefulWidget {
  const _AccountSheet({required this.snapshot, this.account});

  final BudgetSnapshot snapshot;
  final Account? account;

  @override
  State<_AccountSheet> createState() => _AccountSheetState();
}

class _AccountSheetState extends State<_AccountSheet> {
  final _form = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.account?.name ?? '');
  late final _rate = TextEditingController(
    text: widget.account?.interestRate?.toString() ?? '',
  );
  late final _balance = TextEditingController(
    text: widget.account?.balanceCents == null
        ? ''
        : Money.edit(widget.account!.balanceCents!),
  );
  late AccountKind _kind = widget.account?.kind ?? AccountKind.savings;
  late String? _owner = widget.account?.ownerPersonId;
  late bool _main = widget.account?.isMain ?? false;

  @override
  void dispose() {
    _name.dispose();
    _rate.dispose();
    _balance.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    await HouseholdRepository(DatabaseScope.of(context)).saveAccount(
      id: widget.account?.id,
      name: _name.text,
      kind: _kind,
      ownerPersonId: _owner,
      isMain: _main && _owner != null,
      interestRate: double.tryParse(_rate.text.replaceAll(',', '.')),
      balanceCents: _balance.text.trim().isEmpty
          ? null
          : Money.parse(_balance.text),
    );
    if (mounted) Navigator.pop(context);
  }

  Future<void> _delete() async {
    await HouseholdRepository(
      DatabaseScope.of(context),
    ).archiveAccount(widget.account!.id);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    const gap = SizedBox(height: 16);
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        16,
        16,
        16 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Form(
        key: _form,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.account == null ? l10n.accountsAdd : l10n.accountsEdit,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              gap,
              TextFormField(
                controller: _name,
                decoration: InputDecoration(labelText: l10n.commonName),
                validator: (v) =>
                    (v ?? '').trim().isEmpty ? l10n.commonRequired : null,
              ),
              gap,
              DropdownButtonFormField<AccountKind>(
                isExpanded: true,
                initialValue: _kind,
                decoration: InputDecoration(labelText: l10n.accountsKind),
                items: [
                  for (final k in AccountKind.values)
                    DropdownMenuItem(
                      value: k,
                      child: Text(l10n.accountKindName(k)),
                    ),
                ],
                onChanged: (v) => setState(() => _kind = v!),
              ),
              gap,
              DropdownButtonFormField<String?>(
                isExpanded: true,
                initialValue: _owner,
                decoration: InputDecoration(labelText: l10n.accountsOwner),
                items: [
                  DropdownMenuItem(value: null, child: Text(l10n.accountsJoint)),
                  for (final p in widget.snapshot.persons)
                    DropdownMenuItem(value: p.id, child: Text(p.name)),
                ],
                onChanged: (v) => setState(() => _owner = v),
              ),
              if (_owner != null)
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.accountsMain),
                  subtitle: Text(l10n.accountsMainHint),
                  value: _main,
                  onChanged: (v) => setState(() => _main = v),
                ),
              if (_kind == AccountKind.savings) ...[
                gap,
                TextFormField(
                  controller: _rate,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    labelText: l10n.accountsRate,
                    suffixText: '% p. a.',
                  ),
                  validator: (v) {
                    final t = (v ?? '').trim();
                    if (t.isEmpty) return null;
                    final r = double.tryParse(t.replaceAll(',', '.'));
                    return r == null || r < 0 || r > 100
                        ? l10n.commonInvalidAmount
                        : null;
                  },
                ),
              ],
              gap,
              MoneyField(
                controller: _balance,
                label: l10n.accountsBalance,
                helper: l10n.accountsBalanceHint,
              ),
              gap,
              Row(
                children: [
                  if (widget.account != null)
                    TextButton(
                      onPressed: _delete,
                      child: Text(l10n.commonDelete),
                    ),
                  const Spacer(),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(120, 48),
                    ),
                    onPressed: _save,
                    child: Text(l10n.commonSave),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
