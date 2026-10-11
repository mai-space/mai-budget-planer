import 'package:flutter/material.dart';

import '../../data/app_database.dart';
import '../../data/database_provider.dart';
import '../../data/repositories/budget_repository.dart';
import '../../l10n/l10n.dart';
import '../../widgets/common.dart';
import '../../widgets/snapshot_builder.dart';

/// Bereiche und ihr Topf in der Budgetregel.
class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SnapshotBuilder(
      builder: (context, s) => Scaffold(
        appBar: AppBar(title: Text(l10n.settingsCategories)),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _edit(context),
          icon: const Icon(Icons.add),
          label: Text(l10n.categoriesAdd),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
          children: [
            Text(l10n.categoriesIntro),
            const SizedBox(height: 12),
            for (final c in s.categories)
              Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: Icon(
                    categoryIcon(c.icon),
                    color: bucketColor(c.bucket),
                  ),
                  title: Text(c.name),
                  subtitle: Text(l10n.bucketName(c.bucket)),
                  trailing: Text(
                    l10n.itemsCount(
                      s.items.where((i) => i.categoryId == c.id).length,
                    ),
                  ),
                  onTap: () => _edit(context, category: c),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _edit(BuildContext context, {Category? category}) {
    return showDialog<void>(
      context: context,
      builder: (_) => _CategoryDialog(category: category),
    );
  }
}

class _CategoryDialog extends StatefulWidget {
  const _CategoryDialog({this.category});

  final Category? category;

  @override
  State<_CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<_CategoryDialog> {
  late final _name = TextEditingController(text: widget.category?.name ?? '');
  late BudgetBucket _bucket = widget.category?.bucket ?? BudgetBucket.needs;
  late String _icon = widget.category?.icon ?? 'category';

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_name.text.trim().isEmpty) return;
    await BudgetRepository(DatabaseScope.of(context)).saveCategory(
      id: widget.category?.id,
      name: _name.text,
      bucket: _bucket,
      icon: _icon,
    );
    if (mounted) Navigator.pop(context);
  }

  Future<void> _delete() async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = context.l10n;
    final ok = await BudgetRepository(
      DatabaseScope.of(context),
    ).archiveCategory(widget.category!.id);
    if (!ok) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.categoriesNotEmpty)));
      return;
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(
        widget.category == null ? l10n.categoriesAdd : l10n.categoriesEdit,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _name,
              autofocus: widget.category == null,
              decoration: InputDecoration(labelText: l10n.commonName),
            ),
            const SizedBox(height: 16),
            Text(l10n.itemsBucket),
            const SizedBox(height: 8),
            SegmentedButton<BudgetBucket>(
              showSelectedIcon: false,
              segments: [
                for (final b in BudgetBucket.values)
                  ButtonSegment(value: b, label: Text(l10n.bucketName(b))),
              ],
              selected: {_bucket},
              onSelectionChanged: (v) => setState(() => _bucket = v.first),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: [
                for (final MapEntry(key: key, value: icon)
                    in categoryIcons.entries)
                  IconButton(
                    isSelected: _icon == key,
                    icon: Icon(icon),
                    style: IconButton.styleFrom(
                      backgroundColor: _icon == key
                          ? Theme.of(context).colorScheme.primaryContainer
                          : null,
                    ),
                    onPressed: () => setState(() => _icon = key),
                  ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        if (widget.category != null)
          TextButton(onPressed: _delete, child: Text(l10n.commonDelete)),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.commonCancel),
        ),
        FilledButton(onPressed: _save, child: Text(l10n.commonSave)),
      ],
    );
  }
}
