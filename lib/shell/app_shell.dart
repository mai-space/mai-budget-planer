import 'package:flutter/material.dart';

import '../data/database_provider.dart';
import '../data/repositories/budget_repository.dart';
import '../domain/budget.dart';
import '../features/distribution/distribution_page.dart';
import '../features/insights/insights_page.dart';
import '../features/items/items_page.dart';
import '../features/overview/overview_page.dart';
import '../features/items/item_form_page.dart';
import '../features/settings/settings_page.dart';
import '../l10n/l10n.dart';
import '../services/home_widgets.dart';

/// Stellt den aktuellen [BudgetSnapshot] und die Tab-Navigation bereit.
class SnapshotScope extends InheritedWidget {
  const SnapshotScope({
    super.key,
    required this.snapshot,
    required this.openTab,
    required super.child,
  });

  final BudgetSnapshot snapshot;

  /// Wechselt zu einem Tab (siehe [AppTab]).
  final ValueChanged<AppTab> openTab;

  static SnapshotScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<SnapshotScope>();
    assert(scope != null, 'SnapshotScope fehlt im Widget-Baum');
    return scope!;
  }

  @override
  bool updateShouldNotify(SnapshotScope oldWidget) =>
      snapshot != oldWidget.snapshot;
}

enum AppTab { overview, items, distribution, insights, settings }

/// Stellt den [HomeWidgetController] bereit (Einstellungen → Widgets).
class HomeWidgetScope extends InheritedNotifier<HomeWidgetController> {
  const HomeWidgetScope({
    super.key,
    required HomeWidgetController controller,
    required super.child,
  }) : super(notifier: controller);

  static HomeWidgetController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<HomeWidgetScope>();
    assert(scope != null, 'HomeWidgetScope fehlt im Widget-Baum');
    return scope!.notifier!;
  }
}

/// Untere Navigation: Übersicht · Posten · Verteiler · Tipps · Einstellungen.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  AppTab _tab = AppTab.overview;
  Stream<BudgetSnapshot>? _stream;
  final _widgets = HomeWidgetController();
  final _widgetChannel = const HomeWidgetChannel();
  BudgetSnapshot? _latest;
  WidgetLaunchAction? _pendingAction;

  static const _pages = <Widget>[
    OverviewPage(),
    ItemsPage(),
    DistributionPage(),
    InsightsPage(),
    SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    _widgets.load();
    _widgetChannel.listen(_takeLaunchAction);
    _takeLaunchAction();
  }

  @override
  void dispose() {
    _widgetChannel.stopListening();
    _widgets.dispose();
    super.dispose();
  }

  /// Aktion aus einem Widget-Tipp abholen und ausführen, sobald Daten da
  /// sind.
  Future<void> _takeLaunchAction() async {
    final action = await _widgetChannel.takeLaunchAction();
    if (action == null || !mounted) return;
    _pendingAction = action;
    _runPendingAction();
  }

  void _runPendingAction() {
    final action = _pendingAction;
    final snapshot = _latest;
    if (action == null || snapshot == null || !mounted) return;
    _pendingAction = null;
    // Offene Unterseiten schließen, damit nichts doppelt gestapelt wird.
    Navigator.of(context).popUntil((route) => route.isFirst);
    setState(() => _tab = AppTab.overview);
    if (action == WidgetLaunchAction.addItem) {
      openItemForm(context, snapshot);
    }
  }

  void _onSnapshot(BudgetSnapshot snapshot) {
    if (identical(snapshot, _latest)) return;
    _latest = snapshot;
    _widgets.update(snapshot);
    if (_pendingAction != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _runPendingAction());
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _stream ??= BudgetRepository(DatabaseScope.of(context)).watchSnapshot();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return StreamBuilder<BudgetSnapshot>(
      stream: _stream,
      builder: (context, snap) {
        final data = snap.data;
        if (data == null) {
          return Scaffold(
            body: Center(
              child: snap.hasError
                  ? Text('${snap.error}')
                  : const CircularProgressIndicator(),
            ),
          );
        }
        _onSnapshot(data);
        return SnapshotScope(
          snapshot: data,
          openTab: (tab) => setState(() => _tab = tab),
          child: HomeWidgetScope(
            controller: _widgets,
            child: Scaffold(
              body: IndexedStack(index: _tab.index, children: _pages),
              bottomNavigationBar: NavigationBar(
                selectedIndex: _tab.index,
                onDestinationSelected: (i) =>
                    setState(() => _tab = AppTab.values[i]),
                destinations: [
                  NavigationDestination(
                    icon: const Icon(Icons.dashboard_outlined),
                    selectedIcon: const Icon(Icons.dashboard),
                    label: l10n.tabOverview,
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.receipt_long_outlined),
                    selectedIcon: const Icon(Icons.receipt_long),
                    label: l10n.tabItems,
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.call_split_outlined),
                    selectedIcon: const Icon(Icons.call_split),
                    label: l10n.tabDistribution,
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.lightbulb_outline),
                    selectedIcon: const Icon(Icons.lightbulb),
                    label: l10n.tabInsights,
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.settings_outlined),
                    selectedIcon: const Icon(Icons.settings),
                    label: l10n.tabMore,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
