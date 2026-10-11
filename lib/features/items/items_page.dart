import 'package:flutter/material.dart';

import '../../data/app_database.dart';
import '../../domain/budget.dart';
import '../../domain/money.dart';
import '../../l10n/l10n.dart';
import '../../shell/app_shell.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common.dart';
import 'item_form_page.dart';

/// Filter der Postenliste.
sealed class _Filter {
  const _Filter();
}

class _All extends _Filter {
  const _All();
}

class _Shared extends _Filter {
  const _Shared();
}

class _PaidBy extends _Filter {
  const _PaidBy(this.personId);
  final String personId;

  @override
  bool operator ==(Object other) => other is _PaidBy && other.personId == personId;

  @override
  int get hashCode => personId.hashCode;
}

/// Alle Posten nach Bereich — ersetzt die Blätter Wohnen, Versicherungen,
/// KFZ, Kommunikation, Abos, Kontoführung, Lebensmittel und Sparen.
class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  _Filter _filter = const _All();
  String _query = '';

  bool _matches(BudgetItem item) {
    final ok = switch (_filter) {
      _All() => true,
      _Shared() => item.payerPersonId == null,
      _PaidBy(:final personId) => item.payerPersonId == personId,
    };
    if (!ok) return false;
    if (_query.isEmpty) return true;
    final q = _query.toLowerCase();
    return [
      item.label,
      item.provider,
      item.tag,
      item.notes,
    ].any((v) => v != null && v.toLowerCase().contains(q));
  }

  @override
  Widget build(BuildContext context) {
    final s = SnapshotScope.of(context).snapshot;
    final l10n = context.l10n;
    final items = s.items.where(_matches).toList();
    final byCategory = <String, List<BudgetItem>>{};
    for (final item in items) {
      byCategory.putIfAbsent(item.categoryId, () => []).add(item);
    }
    final total = items.fold(0.0, (sum, i) => sum + BudgetSnapshot.monthly(i));
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.tabItems),
        actions: const [PeriodToggle()],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => openItemForm(context, s),
        icon: const Icon(Icons.add),
        label: Text(l10n.itemsAdd),
      ),
      body: s.items.isEmpty
          ? Center(
              child: EmptyState(
                icon: Icons.receipt_long_outlined,
                title: l10n.itemsEmptyTitle,
                message: l10n.itemsEmptyText,
              ),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 96),
              children: [
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: l10n.itemsSearch,
                    isDense: true,
                  ),
                  onChanged: (v) => setState(() => _query = v.trim()),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _chip(l10n.itemsFilterAll, const _All()),
                      for (final p in s.persons)
                        _chip(
                          p.name,
                          _PaidBy(p.id),
                          avatar: PersonDot(colorIndex: p.colorIndex),
                        ),
                      if (s.items.any((i) => i.payerPersonId == null))
                        _chip(l10n.itemsFilterShared, const _Shared()),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Expanded(child: Text(l10n.itemsCount(items.length))),
                      PeriodAmount(
                        total,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                for (final category in s.categories)
                  if (byCategory[category.id] case final list?)
                    _CategoryGroup(
                      snapshot: s,
                      category: category,
                      items: list,
                    ),
              ],
            ),
    );
  }

  Widget _chip(String label, _Filter filter, {Widget? avatar}) => Padding(
    padding: const EdgeInsets.only(right: 8),
    child: FilterChip(
      avatar: avatar,
      label: Text(label),
      selected: _filter == filter,
      showCheckmark: false,
      onSelected: (_) => setState(() => _filter = filter),
    ),
  );
}

class _CategoryGroup extends StatelessWidget {
  const _CategoryGroup({
    required this.snapshot,
    required this.category,
    required this.items,
  });

  final BudgetSnapshot snapshot;
  final Category category;
  final List<BudgetItem> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sum = items.fold(0.0, (s, i) => s + BudgetSnapshot.monthly(i));
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Row(
                children: [
                  Icon(
                    categoryIcon(category.icon),
                    size: 20,
                    color: bucketColor(category.bucket),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      category.name,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  PeriodAmount(
                    sum,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            for (final item in items)
              _ItemTile(snapshot: snapshot, item: item),
          ],
        ),
      ),
    );
  }
}

class _ItemTile extends StatelessWidget {
  const _ItemTile({required this.snapshot, required this.item});

  final BudgetSnapshot snapshot;
  final BudgetItem item;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final payer = snapshot.personById(item.payerPersonId);
    final account = snapshot.accountOf(item);
    final details = [
      if (item.interval != PayInterval.monthly)
        '${Money.format(item.amountCents)} ${l10n.intervalName(item.interval).toLowerCase()}',
      ?item.tag,
      ?item.provider,
      ?account?.name,
    ];
    final overridden =
        item.bucketOverride != null &&
        item.bucketOverride != snapshot.categoryOf(item)?.bucket;
    return ListTile(
      leading: payer == null
          ? const Icon(Icons.group_outlined, size: 20, color: AppColors.muted)
          : PersonDot(colorIndex: payer.colorIndex, size: 14),
      minLeadingWidth: 20,
      title: Row(
        children: [
          Flexible(child: Text(item.label, overflow: TextOverflow.ellipsis)),
          if (overridden) ...[
            const SizedBox(width: 6),
            Icon(
              Icons.circle,
              size: 8,
              color: bucketColor(item.bucketOverride!),
              semanticLabel: l10n.bucketName(item.bucketOverride!),
            ),
          ],
          if ((item.savingsPotentialCents ?? 0) > 0) ...[
            const SizedBox(width: 6),
            Icon(
              Icons.trending_down,
              size: 16,
              color: AppColors.positive,
              semanticLabel: l10n.itemsHasPotential,
            ),
          ],
        ],
      ),
      subtitle: details.isEmpty
          ? null
          : Text(details.join(' · '), maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: PeriodAmount(
        BudgetSnapshot.monthly(item),
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      onTap: () => openItemForm(context, snapshot, item: item),
    );
  }
}
