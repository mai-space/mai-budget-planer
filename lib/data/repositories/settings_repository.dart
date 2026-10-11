import 'package:drift/drift.dart';

import '../app_database.dart';

class SettingsRepository {
  SettingsRepository(this._db);

  final AppDatabase _db;

  SimpleSelectStatement<$AppSettingsTable, AppSetting> get _row =>
      _db.select(_db.appSettings)..where((t) => t.id.equals(1));

  Stream<AppSetting> watch() => _row.watchSingle();

  Future<AppSetting> get() => _row.getSingle();

  Future<void> _write(AppSettingsCompanion values) =>
      (_db.update(_db.appSettings)..where((t) => t.id.equals(1))).write(values);

  Future<void> completeOnboarding() =>
      _write(const AppSettingsCompanion(onboardingCompleted: Value(true)));

  Future<void> setAppLock(bool enabled) =>
      _write(AppSettingsCompanion(appLockEnabled: Value(enabled)));

  /// Budgetregel in Prozent; die drei Werte ergeben zusammen 100.
  Future<void> setRule({
    required int needs,
    required int wants,
    required int savings,
  }) {
    if (needs < 0 || wants < 0 || savings < 0 || needs + wants + savings != 100) {
      throw ArgumentError('Budgetregel muss 100 % ergeben');
    }
    return _write(
      AppSettingsCompanion(
        ruleNeeds: Value(needs),
        ruleWants: Value(wants),
        ruleSavings: Value(savings),
      ),
    );
  }

  Future<void> setSplitMode(SplitMode mode) =>
      _write(AppSettingsCompanion(splitMode: Value(mode)));
}
