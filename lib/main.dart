import 'package:drift/drift.dart' show DriftWrappedException;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'data/app_database.dart';
import 'data/connection/connection.dart';
import 'data/connection/database_key.dart';
import 'data/database_provider.dart';
import 'data/repositories/settings_repository.dart';
import 'features/onboarding/onboarding_page.dart';
import 'l10n/l10n.dart';
import 'services/app_lock.dart';
import 'shell/app_shell.dart';
import 'theme/app_theme.dart';
import 'widgets/app_lock_gate.dart';

final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  AppLocale.update(
    AppLocale.resolve(WidgetsBinding.instance.platformDispatcher.locales),
  );
  await _start();
}

Future<void> _start() async {
  final database = AppDatabase();
  // Schlüssel vorübergehend nicht lesbar (Keystore hakt): nichts verwerfen,
  // sondern erneut versuchen lassen.
  try {
    await database.customSelect('SELECT 1').get();
  } catch (e) {
    if (!_isKeyUnavailable(e)) rethrow;
    await database.close().catchError((Object _) {});
    runApp(_KeyUnavailableApp(onRetry: _start));
    return;
  }

  var lockEnabled = false;
  try {
    lockEnabled = (await SettingsRepository(database).get()).appLockEnabled;
  } catch (_) {
    // Einstellungszeile fehlt ggf. in Tests — ignorieren.
  }
  // Sperre steht vor dem ersten Frame fest → kein Aufblitzen von Zahlen.
  final appLock = AppLockController(
    authenticator: DeviceLockAuthenticator(),
    enabled: lockEnabled,
  )..attach();
  if (lockEnabled) await SecureWindow.setSecure(true);

  runApp(MaiBudgetApp(database: database, appLock: appLock));

  if (databaseOpenStatus.value?.unreadableCopy != null) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _showUnreadableData());
  }
}

bool _isKeyUnavailable(Object e) =>
    e is DatabaseKeyUnavailable ||
    (e is DriftWrappedException && e.cause is DatabaseKeyUnavailable);

class _KeyUnavailableApp extends StatelessWidget {
  const _KeyUnavailableApp({required this.onRetry});

  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: AppLocale.supported,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: AppTheme.light(),
      home: Builder(
        builder: (context) => Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.lock_clock_outlined, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    context.l10n.settingsKeyUnavailableTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.l10n.settingsKeyUnavailableText,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: onRetry,
                    child: Text(context.l10n.commonRetry),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Die gespeicherte Datenbank ließ sich nicht entschlüsseln und wurde
/// beiseitegelegt — Wiederherstellung über eine Sicherung.
void _showUnreadableData() {
  final context = appNavigatorKey.currentContext;
  if (context == null) return;
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      icon: const Icon(Icons.lock_reset),
      title: Text(context.l10n.settingsUnreadableTitle),
      content: Text(context.l10n.settingsUnreadableText),
      actions: [
        FilledButton(
          onPressed: () => Navigator.pop(context),
          child: Text(context.l10n.commonUnderstood),
        ),
      ],
    ),
  );
}

class MaiBudgetApp extends StatefulWidget {
  const MaiBudgetApp({super.key, required this.database, this.appLock});

  final AppDatabase database;

  /// Ohne Angabe: Sperre aus (z. B. in Tests).
  final AppLockController? appLock;

  @override
  State<MaiBudgetApp> createState() => _MaiBudgetAppState();
}

class _MaiBudgetAppState extends State<MaiBudgetApp> {
  late final AppLockController _lock =
      widget.appLock ??
      AppLockController(authenticator: DeviceLockAuthenticator());

  @override
  void dispose() {
    if (widget.appLock == null) _lock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DatabaseScope(
      database: widget.database,
      child: AppLockScope(
        controller: _lock,
        child: MaterialApp(
          navigatorKey: appNavigatorKey,
          onGenerateTitle: (context) => context.l10n.appTitle,
          debugShowCheckedModeBanner: false,
          supportedLocales: AppLocale.supported,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeListResolutionCallback: (locales, _) {
            final locale = AppLocale.resolve(locales ?? const []);
            AppLocale.update(locale);
            return locale;
          },
          theme: AppTheme.light(),
          builder: (context, child) => AppLockGate(child: child!),
          home: const _Home(),
        ),
      ),
    );
  }
}

/// Einrichtung beim ersten Start, danach die App.
class _Home extends StatelessWidget {
  const _Home();

  @override
  Widget build(BuildContext context) {
    final db = DatabaseScope.of(context);
    return StreamBuilder<bool>(
      stream: SettingsRepository(
        db,
      ).watch().map((s) => s.onboardingCompleted).distinct(),
      builder: (context, snapshot) => switch (snapshot.data) {
        null => const Scaffold(body: SizedBox.shrink()),
        false => const OnboardingPage(),
        true => const AppShell(),
      },
    );
  }
}
