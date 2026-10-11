import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/app_database.dart';
import '../../data/database_provider.dart';
import '../../data/item_catalog.dart';
import '../../data/repositories/budget_repository.dart';
import '../../domain/budget.dart';
import '../../domain/money.dart';
import '../../l10n/l10n.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common.dart';

/// Öffnet das Formular für einen neuen ([item] = `null`) oder bestehenden
/// Posten.
Future<void> openItemForm(
  BuildContext context,
  BudgetSnapshot snapshot, {
  BudgetItem? item,
  String? categoryId,
}) {
  return Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => ItemFormPage(
        snapshot: snapshot,
        item: item,
        categoryId: categoryId,
      ),
    ),
  );
}

class ItemFormPage extends StatefulWidget {
  const ItemFormPage({
    super.key,
    required this.snapshot,
    this.item,
    this.categoryId,
  });

  /// Personen, Kategorien und Konten zum Zeitpunkt des Öffnens.
  final BudgetSnapshot snapshot;
  final BudgetItem? item;
  final String? categoryId;

  @override
  State<ItemFormPage> createState() => _ItemFormPageState();
}

class _ItemFormPageState extends State<ItemFormPage> {
  final _form = GlobalKey<FormState>();
  late final TextEditingController _label;
  late final TextEditingController _amount;
  late final TextEditingController _tag;
  late final TextEditingController _provider;
  late final TextEditingController _contract;
  late final TextEditingController _phone;
  late final TextEditingController _potential;
  late final TextEditingController _target;
  late final TextEditingController _notes;

  late String? _categoryId;
  late PayInterval _interval;
  late String? _payer;
  late String? _beneficiary;
  late String? _account;
  late BudgetBucket? _bucket;
  late int? _dueMonth;
  late bool _details;
  bool _saving = false;

  BudgetSnapshot get _s => widget.snapshot;

  @override
  void initState() {
    super.initState();
    final item = widget.item;
    String money(int? cents) => cents == null ? '' : Money.edit(cents);
    _label = TextEditingController(text: item?.label ?? '');
    _amount = TextEditingController(text: money(item?.amountCents));
    _tag = TextEditingController(text: item?.tag ?? '');
    _provider = TextEditingController(text: item?.provider ?? '');
    _contract = TextEditingController(text: item?.contractNumber ?? '');
    _phone = TextEditingController(text: item?.phone ?? '');
    _potential = TextEditingController(
      text: money(item?.savingsPotentialCents),
    );
    _target = TextEditingController(text: money(item?.targetCents));
    _notes = TextEditingController(text: item?.notes ?? '');
    _categoryId =
        item?.categoryId ??
        widget.categoryId ??
        (_s.categories.isEmpty ? null : _s.categories.first.id);
    _interval = item?.interval ?? PayInterval.monthly;
    _payer =
        item?.payerPersonId ??
        (item == null && _s.persons.length == 1 ? _s.persons.first.id : null);
    _beneficiary = item?.beneficiaryPersonId;
    _account = item?.accountId;
    _bucket = item?.bucketOverride;
    _dueMonth = item?.dueMonth;
    _details =
        item != null &&
        [
          item.tag,
          item.provider,
          item.contractNumber,
          item.phone,
          item.notes,
          item.bucketOverride,
          item.savingsPotentialCents,
          item.targetCents,
        ].any((v) => v != null);
  }

  @override
  void dispose() {
    for (final c in [
      _label,
      _amount,
      _tag,
      _provider,
      _contract,
      _phone,
      _potential,
      _target,
      _notes,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Category? get _category {
    for (final c in _s.categories) {
      if (c.id == _categoryId) return c;
    }
    return null;
  }

  String _accountLabel(Account a) {
    final owner = _s.personById(a.ownerPersonId);
    return owner == null ? a.name : '${a.name} (${owner.name})';
  }

  BudgetBucket get _effectiveBucket =>
      _bucket ?? _category?.bucket ?? BudgetBucket.needs;

  /// Vorschläge: bisherige Posten + Katalog in der App-Sprache.
  Iterable<String> _suggestions(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return const [];
    final lang = AppLocale.current.languageCode;
    final seen = <String>{};
    return [
      for (final i in _s.items) i.label,
      for (final e in itemCatalog) e.label(lang),
    ].where((l) => l.toLowerCase().contains(q) && seen.add(l.toLowerCase()))
        .take(8);
  }

  /// Übernimmt Kategorie, Rhythmus und Unterkategorie aus dem Katalog.
  void _applySuggestion(String label) {
    final lang = AppLocale.current.languageCode;
    for (final e in itemCatalog) {
      if (e.label(lang) != label) continue;
      for (final c in _s.categories) {
        if (c.systemKey == e.category) _categoryId = c.id;
      }
      _interval = e.interval;
      if (_tag.text.isEmpty && e.tag != null) _tag.text = e.tag!;
      if (e.bucket != null) _bucket = e.bucket;
      break;
    }
    setState(() {});
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate() || _categoryId == null) return;
    setState(() => _saving = true);
    String? text(TextEditingController c) =>
        c.text.trim().isEmpty ? null : c.text.trim();
    int? cents(TextEditingController c) =>
        c.text.trim().isEmpty ? null : Money.parse(c.text);
    final values = BudgetItemsCompanion(
      id: widget.item == null ? const Value.absent() : Value(widget.item!.id),
      categoryId: Value(_categoryId!),
      label: Value(_label.text.trim()),
      amountCents: Value(Money.parse(_amount.text) ?? 0),
      interval: Value(_interval),
      payerPersonId: Value(_payer),
      beneficiaryPersonId: Value(_beneficiary),
      accountId: Value(_account),
      bucketOverride: Value(
        _bucket == null || _bucket == _category?.bucket ? null : _bucket,
      ),
      tag: Value(text(_tag)),
      provider: Value(text(_provider)),
      contractNumber: Value(text(_contract)),
      phone: Value(text(_phone)),
      dueMonth: Value(_interval == PayInterval.monthly ? null : _dueMonth),
      savingsPotentialCents: Value(cents(_potential)),
      targetCents: Value(
        _effectiveBucket == BudgetBucket.savings ? cents(_target) : null,
      ),
      notes: Value(text(_notes)),
    );
    await BudgetRepository(DatabaseScope.of(context)).saveItem(values);
    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _archive() async {
    final repo = BudgetRepository(DatabaseScope.of(context));
    final messenger = ScaffoldMessenger.of(context);
    final l10n = context.l10n;
    final id = widget.item!.id;
    await repo.archiveItem(id);
    if (!mounted) return;
    Navigator.of(context).pop();
    messenger.showSnackBar(
      SnackBar(
        content: Text(l10n.itemsDeleted(widget.item!.label)),
        action: SnackBarAction(
          label: l10n.commonUndo,
          onPressed: () => repo.restoreItem(id),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final amount = Money.parse(_amount.text);
    const gap = SizedBox(height: 16);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item == null ? l10n.itemsAdd : l10n.itemsEdit),
        actions: [
          if (widget.item != null)
            IconButton(
              tooltip: l10n.commonDelete,
              icon: const Icon(Icons.delete_outline),
              onPressed: _archive,
            ),
        ],
      ),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: [
            Autocomplete<String>(
              initialValue: TextEditingValue(text: _label.text),
              optionsBuilder: (v) => _suggestions(v.text),
              onSelected: (v) {
                _label.text = v;
                _applySuggestion(v);
              },
              fieldViewBuilder: (context, controller, focus, onSubmit) {
                return TextFormField(
                  controller: controller,
                  focusNode: focus,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(labelText: l10n.itemsLabel),
                  onChanged: (v) => _label.text = v,
                  validator: (v) => (v ?? '').trim().isEmpty
                      ? l10n.commonRequired
                      : null,
                );
              },
            ),
            gap,
            DropdownButtonFormField<String>(
              isExpanded: true,
              // Key: Vorschläge setzen die Auswahl von außen.
              key: ValueKey('category:$_categoryId'),
              initialValue: _categoryId,
              decoration: InputDecoration(labelText: l10n.itemsCategory),
              items: [
                for (final c in _s.categories)
                  DropdownMenuItem(
                    value: c.id,
                    child: Row(
                      children: [
                        Icon(categoryIcon(c.icon), size: 18),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(c.name, overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
              ],
              onChanged: (v) => setState(() => _categoryId = v),
            ),
            gap,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: MoneyField(
                    controller: _amount,
                    label: l10n.itemsAmount,
                    required: true,
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<PayInterval>(
                    isExpanded: true,
                    key: ValueKey('interval:$_interval'),
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
            if (amount != null && _interval != PayInterval.monthly)
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 12),
                child: Text(
                  l10n.itemsMonthlyEquivalent(
                    Money.format(monthlyOf(amount, _interval)),
                  ),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.muted,
                  ),
                ),
              ),
            if (_interval != PayInterval.monthly &&
                _interval != PayInterval.weekly) ...[
              gap,
              DropdownButtonFormField<int?>(
                isExpanded: true,
                initialValue: _dueMonth,
                decoration: InputDecoration(labelText: l10n.itemsDueMonth),
                items: [
                  DropdownMenuItem(value: null, child: Text(l10n.commonNone)),
                  for (var m = 1; m <= 12; m++)
                    DropdownMenuItem(
                      value: m,
                      child: Text(DateFormat.MMMM().format(DateTime(2000, m))),
                    ),
                ],
                onChanged: (v) => setState(() => _dueMonth = v),
              ),
            ],
            gap,
            DropdownButtonFormField<String?>(
              isExpanded: true,
              initialValue: _payer,
              decoration: InputDecoration(labelText: l10n.itemsPayer),
              items: [
                DropdownMenuItem(value: null, child: Text(l10n.itemsJoint)),
                for (final p in _s.persons)
                  DropdownMenuItem(value: p.id, child: Text(p.name)),
              ],
              onChanged: (v) => setState(() => _payer = v),
            ),
            if (_s.persons.length > 1) ...[
              gap,
              DropdownButtonFormField<String?>(
                isExpanded: true,
                initialValue: _beneficiary,
                decoration: InputDecoration(
                  labelText: l10n.itemsBeneficiary,
                  helperText: l10n.itemsBeneficiaryHint,
                ),
                items: [
                  DropdownMenuItem(
                    value: null,
                    child: Text(l10n.itemsHousehold),
                  ),
                  for (final p in _s.persons)
                    DropdownMenuItem(value: p.id, child: Text(p.name)),
                ],
                onChanged: (v) => setState(() => _beneficiary = v),
              ),
            ],
            gap,
            DropdownButtonFormField<String?>(
              isExpanded: true,
              initialValue: _account,
              decoration: InputDecoration(
                labelText: _effectiveBucket == BudgetBucket.savings
                    ? l10n.itemsAccountSavings
                    : l10n.itemsAccount,
              ),
              items: [
                DropdownMenuItem(value: null, child: Text(l10n.commonNone)),
                for (final a in _s.accounts)
                  DropdownMenuItem(
                    value: a.id,
                    child: Text(_accountLabel(a)),
                  ),
              ],
              onChanged: (v) => setState(() => _account = v),
            ),
            const SizedBox(height: 8),
            ExpansionTile(
              tilePadding: EdgeInsets.zero,
              initiallyExpanded: _details,
              title: Text(l10n.itemsDetails),
              subtitle: Text(l10n.itemsDetailsHint),
              childrenPadding: const EdgeInsets.only(top: 8),
              children: [
                DropdownButtonFormField<BudgetBucket?>(
                  isExpanded: true,
                  key: ValueKey('bucket:$_bucket:$_categoryId'),
                  initialValue: _bucket,
                  decoration: InputDecoration(
                    labelText: l10n.itemsBucket,
                    helperText: l10n.itemsBucketHint,
                  ),
                  items: [
                    DropdownMenuItem(
                      value: null,
                      child: Text(
                        l10n.itemsBucketFromCategory(
                          l10n.bucketName(_category?.bucket ?? BudgetBucket.needs),
                        ),
                      ),
                    ),
                    for (final b in BudgetBucket.values)
                      DropdownMenuItem(value: b, child: Text(l10n.bucketName(b))),
                  ],
                  onChanged: (v) => setState(() => _bucket = v),
                ),
                gap,
                TextFormField(
                  controller: _tag,
                  decoration: InputDecoration(
                    labelText: l10n.itemsTag,
                    helperText: l10n.itemsTagHint,
                  ),
                ),
                gap,
                TextFormField(
                  controller: _provider,
                  decoration: InputDecoration(labelText: l10n.itemsProvider),
                ),
                gap,
                TextFormField(
                  controller: _contract,
                  decoration: InputDecoration(labelText: l10n.itemsContract),
                ),
                gap,
                TextFormField(
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(labelText: l10n.itemsPhone),
                ),
                gap,
                MoneyField(
                  controller: _potential,
                  label: l10n.itemsPotential,
                  helper: l10n.itemsPotentialHint,
                ),
                if (_effectiveBucket == BudgetBucket.savings) ...[
                  gap,
                  MoneyField(controller: _target, label: l10n.itemsTarget),
                ],
                gap,
                TextFormField(
                  controller: _notes,
                  minLines: 2,
                  maxLines: 5,
                  decoration: InputDecoration(labelText: l10n.itemsNotes),
                ),
              ],
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _saving ? null : _save,
              child: Text(l10n.commonSave),
            ),
          ],
        ),
      ),
    );
  }
}
