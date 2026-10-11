import 'package:flutter/material.dart';

import '../../data/app_database.dart';
import '../../data/database_provider.dart';
import '../../data/repositories/household_repository.dart';
import '../../domain/budget.dart';
import '../../domain/money.dart';
import '../../l10n/l10n.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common.dart';
import '../../widgets/snapshot_builder.dart';

/// Personen und ihre Einkommen (Blatt „Einkommen“).
class HouseholdPage extends StatelessWidget {
  const HouseholdPage({super.key});

  Future<void> _addPerson(BuildContext context) async {
    final name = await _askText(context, context.l10n.householdAddPerson);
    if (name == null || !context.mounted) return;
    final l10n = context.l10n;
    final repo = HouseholdRepository(DatabaseScope.of(context));
    final id = await repo.addPerson(name);
    await repo.saveAccount(
      name: l10n.onboardingMainAccount(name),
      kind: AccountKind.checking,
      ownerPersonId: id,
      isMain: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SnapshotBuilder(
      builder: (context, s) => Scaffold(
        appBar: AppBar(title: Text(l10n.settingsHousehold)),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _addPerson(context),
          icon: const Icon(Icons.person_add_alt),
          label: Text(l10n.householdAddPerson),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
          children: [
            for (final person in s.persons) ...[
              _PersonCard(snapshot: s, person: person),
              const SizedBox(height: 12),
            ],
            if (s.deductionRate case final rate?)
              Text(
                l10n.overviewDeductions((rate * 100).toStringAsFixed(1)),
                style: const TextStyle(color: AppColors.muted),
              ),
          ],
        ),
      ),
    );
  }
}

class _PersonCard extends StatelessWidget {
  const _PersonCard({required this.snapshot, required this.person});

  final BudgetSnapshot snapshot;
  final Person person;

  Future<void> _rename(BuildContext context) async {
    final name = await _askText(
      context,
      context.l10n.householdRename,
      initial: person.name,
    );
    if (name == null || !context.mounted) return;
    await HouseholdRepository(
      DatabaseScope.of(context),
    ).renamePerson(person.id, name);
  }

  Future<void> _archive(BuildContext context) async {
    final l10n = context.l10n;
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.householdRemoveTitle(person.name)),
        content: Text(l10n.householdRemoveText),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.commonDelete),
          ),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      await HouseholdRepository(
        DatabaseScope.of(context),
      ).archivePerson(person.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final incomes = snapshot.incomes
        .where((i) => i.personId == person.id)
        .toList();
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              leading: PersonDot(colorIndex: person.colorIndex, size: 16),
              title: Text(
                person.name,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                l10n.householdNet(Money.format(snapshot.incomeOf(person.id))),
              ),
              trailing: PopupMenuButton<String>(
                onSelected: (v) => v == 'rename'
                    ? _rename(context)
                    : _archive(context),
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: 'rename',
                    child: Text(l10n.householdRename),
                  ),
                  if (snapshot.persons.length > 1)
                    PopupMenuItem(
                      value: 'archive',
                      child: Text(l10n.commonDelete),
                    ),
                ],
              ),
            ),
            for (final income in incomes)
              ListTile(
                contentPadding: const EdgeInsets.only(left: 56, right: 16),
                title: Text(income.label),
                subtitle: Text(
                  [
                    l10n.intervalName(income.interval),
                    if (income.grossCents case final g?)
                      l10n.householdGross(Money.format(g)),
                  ].join(' · '),
                ),
                trailing: Text(Money.format(income.netCents)),
                onTap: () => showIncomeSheet(context, person, income: income),
              ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 44),
                child: TextButton.icon(
                  onPressed: () => showIncomeSheet(context, person),
                  icon: const Icon(Icons.add),
                  label: Text(l10n.householdAddIncome),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Einkommen anlegen/bearbeiten.
Future<void> showIncomeSheet(
  BuildContext context,
  Person person, {
  Income? income,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (_) => _IncomeSheet(person: person, income: income),
  );
}

class _IncomeSheet extends StatefulWidget {
  const _IncomeSheet({required this.person, this.income});

  final Person person;
  final Income? income;

  @override
  State<_IncomeSheet> createState() => _IncomeSheetState();
}

class _IncomeSheetState extends State<_IncomeSheet> {
  final _form = GlobalKey<FormState>();
  late final _label = TextEditingController(text: widget.income?.label ?? '');
  late final _net = TextEditingController(
    text: widget.income == null ? '' : Money.edit(widget.income!.netCents),
  );
  late final _gross = TextEditingController(
    text: widget.income?.grossCents == null
        ? ''
        : Money.edit(widget.income!.grossCents!),
  );
  late PayInterval _interval = widget.income?.interval ?? PayInterval.monthly;

  @override
  void dispose() {
    _label.dispose();
    _net.dispose();
    _gross.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    final l10n = context.l10n;
    await HouseholdRepository(DatabaseScope.of(context)).saveIncome(
      id: widget.income?.id,
      personId: widget.person.id,
      label: _label.text.trim().isEmpty
          ? l10n.onboardingIncomeLabel
          : _label.text,
      netCents: Money.parse(_net.text)!,
      grossCents: _gross.text.trim().isEmpty ? null : Money.parse(_gross.text),
      interval: _interval,
    );
    if (mounted) Navigator.pop(context);
  }

  Future<void> _delete() async {
    await HouseholdRepository(
      DatabaseScope.of(context),
    ).archiveIncome(widget.income!.id);
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.householdIncomeOf(widget.person.name),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            gap,
            TextFormField(
              controller: _label,
              decoration: InputDecoration(
                labelText: l10n.householdIncomeLabel,
                hintText: l10n.onboardingIncomeLabel,
              ),
            ),
            gap,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: MoneyField(
                    controller: _net,
                    label: l10n.householdNetLabel,
                    required: true,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<PayInterval>(
                    isExpanded: true,
                    initialValue: _interval,
                    decoration: InputDecoration(labelText: l10n.itemsInterval),
                    items: [
                      for (final i in PayInterval.values)
                        DropdownMenuItem(
                          value: i,
                          child: Text(l10n.intervalName(i)),
                        ),
                    ],
                    onChanged: (v) => setState(() => _interval = v!),
                  ),
                ),
              ],
            ),
            gap,
            MoneyField(
              controller: _gross,
              label: l10n.householdGrossLabel,
              helper: l10n.householdGrossHint,
            ),
            gap,
            Row(
              children: [
                if (widget.income != null)
                  TextButton(
                    onPressed: _delete,
                    child: Text(l10n.commonDelete),
                  ),
                const Spacer(),
                FilledButton(
                  style: FilledButton.styleFrom(minimumSize: const Size(120, 48)),
                  onPressed: _save,
                  child: Text(l10n.commonSave),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Fragt einen Namen ab; `null` bei Abbruch oder leerer Eingabe.
Future<String?> _askText(
  BuildContext context,
  String title, {
  String initial = '',
}) {
  final controller = TextEditingController(text: initial);
  final l10n = context.l10n;
  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: TextField(
        controller: controller,
        autofocus: true,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(labelText: l10n.commonName),
        onSubmitted: (v) =>
            Navigator.pop(context, v.trim().isEmpty ? null : v.trim()),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.commonCancel),
        ),
        FilledButton(
          onPressed: () {
            final v = controller.text.trim();
            Navigator.pop(context, v.isEmpty ? null : v);
          },
          child: Text(l10n.commonSave),
        ),
      ],
    ),
  );
}
