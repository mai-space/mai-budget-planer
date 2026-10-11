import 'package:flutter/material.dart';

import '../data/database_provider.dart';
import '../data/repositories/budget_repository.dart';
import '../domain/budget.dart';

/// Eigener Live-Stand für Seiten außerhalb der Tab-Navigation.
class SnapshotBuilder extends StatefulWidget {
  const SnapshotBuilder({super.key, required this.builder});

  final Widget Function(BuildContext context, BudgetSnapshot snapshot) builder;

  @override
  State<SnapshotBuilder> createState() => _SnapshotBuilderState();
}

class _SnapshotBuilderState extends State<SnapshotBuilder> {
  Stream<BudgetSnapshot>? _stream;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _stream ??= BudgetRepository(DatabaseScope.of(context)).watchSnapshot();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BudgetSnapshot>(
      stream: _stream,
      builder: (context, snap) => snap.data == null
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : widget.builder(context, snap.data!),
    );
  }
}
