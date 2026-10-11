import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mai_budget_planer/data/app_database.dart';

/// Hält das aktuelle Schema fest. Ändert es sich, schlägt der Test fehl,
/// bis Migration, Migrationstest und Fixture angepasst sind (siehe
/// CLAUDE.md): `UPDATE_SCHEMA=1 flutter test test/schema_contract_test.dart`
const _fixture = 'test/schema/current.sql';

Future<String> currentSchema() async {
  final db = AppDatabase(NativeDatabase.memory());
  final rows = await db
      .customSelect(
        'SELECT sql FROM sqlite_master WHERE sql IS NOT NULL ORDER BY name',
      )
      .get();
  await db.close();
  return [
    '-- schemaVersion ${db.schemaVersion}',
    for (final r in rows) '${r.read<String>('sql').trim()};',
  ].join('\n---\n');
}

void main() {
  test('schema fixture matches the app schema', () async {
    final schema = await currentSchema();
    if (Platform.environment['UPDATE_SCHEMA'] == '1') {
      File(_fixture)
        ..parent.createSync(recursive: true)
        ..writeAsStringSync('$schema\n');
    }
    expect(File(_fixture).readAsStringSync().trim(), schema.trim());
  });

  test('v1 snapshot (oldest released schema) opens and keeps data', () async {
    // Vorlage für künftige Migrationstests: echtes v1-Schema mit Bestandsdaten.
    final db = AppDatabase(NativeDatabase.memory(setup: (raw) {
      final sql = File('test/migrations/v1.sql').readAsStringSync();
      for (final statement in sql.split('---')) {
        final body = statement
            .split('\n')
            .where((l) => !l.startsWith('--'))
            .join('\n')
            .trim();
        if (body.isNotEmpty) raw.execute(body);
      }
      raw.execute(
        "INSERT INTO persons (id, name, created_at, updated_at) "
        "VALUES ('p1', 'Alex', 0, 0)",
      );
      raw.execute('PRAGMA user_version = 1');
    }));
    addTearDown(db.close);
    final persons = await db.select(db.persons).get();
    expect(persons.single.name, 'Alex');
    final settings = await db.select(db.appSettings).getSingle();
    expect(settings.ruleNeeds, 50);
  });
}
