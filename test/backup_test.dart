import 'dart:io';
import 'dart:typed_data';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mai_backup_format/mai_backup_format.dart';
import 'package:mai_budget_planer/data/app_database.dart';
import 'package:mai_budget_planer/data/repositories/budget_repository.dart';
import 'package:mai_budget_planer/data/repositories/household_repository.dart';
import 'package:mai_budget_planer/services/backup_service.dart';
import 'package:sqlite3/sqlite3.dart';

void main() {
  late Directory tmp;
  late AppDatabase db;
  late BackupService service;

  setUp(() async {
    tmp = await Directory.systemTemp.createTemp('backup_');
    db = AppDatabase(NativeDatabase.memory());
    service = BackupService(db, tempDir: () async => tmp, iterations: 1000);
  });
  tearDown(() async {
    await db.close();
    await tmp.delete(recursive: true);
  });

  Future<void> seed() async {
    await HouseholdRepository(db).setUpHousehold(
      [(name: 'Alex', netCents: 250000)],
      mainAccountName: (n) => 'Giro $n',
      incomeLabel: 'Gehalt',
    );
    await BudgetRepository(db).saveItem(
      BudgetItemsCompanion(
        categoryId: const Value('cat_${CategoryKey.housing}'),
        label: const Value('Miete'),
        amountCents: const Value(90000),
        contractNumber: const Value('VN-123'),
      ),
    );
  }

  test('backup → change everything → restore brings data back', () async {
    await seed();
    final file = await service.createBackupFile('geheim123');
    expect(file.path, endsWith('.maibudget'));
    // Kein Klartext in der Datei.
    final bytes = await file.readAsBytes();
    expect(String.fromCharCodes(bytes), isNot(contains('Miete')));
    expect(BackupCrypto.looksLikeBackup(bytes), isTrue);

    final repo = BudgetRepository(db);
    final itemId = (await repo.snapshot()).items.single.id;
    await repo.archiveItem(itemId);
    await HouseholdRepository(db).addPerson('Sam');

    await service.restoreFile(file.path, 'geheim123');
    final s = await repo.snapshot();
    expect(s.persons.map((p) => p.name), ['Alex']);
    expect(s.items.single.label, 'Miete');
    expect(s.items.single.contractNumber, 'VN-123');
    expect(s.incomes.single.netCents, 250000);
    expect(s.categories, hasLength(9));
    // Arbeitsordner sind aufgeräumt; nur die Exportdatei bleibt.
    expect(tmp.listSync().whereType<Directory>(), isEmpty);
  });

  test('wrong password leaves data untouched', () async {
    await seed();
    final file = await service.createBackupFile('geheim123');
    await HouseholdRepository(db).addPerson('Sam');
    await expectLater(
      service.restoreFile(file.path, 'falsch!!!'),
      throwsA(isA<BackupException>()),
    );
    expect((await BudgetRepository(db).snapshot()).persons, hasLength(2));
  });

  test('short passwords are rejected before anything is written', () async {
    await expectLater(
      service.createBackupFile('kurz'),
      throwsA(isA<BackupException>()),
    );
  });

  test('backups of other Mai apps are rejected', () async {
    final foreign = File('${tmp.path}/doctor.maibackup');
    await foreign.writeAsBytes(
      await BackupCrypto.encrypt(
        BackupArchive.build(
          database: Uint8List(0),
          manifest: {'schemaVersion': 18, 'format': 2},
        ),
        'geheim123',
        iterations: 1000,
      ),
    );
    await expectLater(
      service.restoreFile(foreign.path, 'geheim123'),
      throwsA(
        isA<BackupException>().having(
          (e) => e.message,
          'message',
          contains('keine Budget-Sicherung'),
        ),
      ),
    );
  });

  test('backups from a newer schema are rejected', () async {
    await seed();
    final snapshot = '${tmp.path}/newer.sqlite';
    await db.customStatement('VACUUM INTO ?', [snapshot]);
    sqlite3.open(snapshot)
      ..execute('PRAGMA user_version = 99')
      ..close();
    final file = File('${tmp.path}/newer.maibudget');
    await file.writeAsBytes(
      await BackupCrypto.encrypt(
        BackupArchive.build(
          database: await File(snapshot).readAsBytes(),
          manifest: {'app': backupAppId, 'schemaVersion': 99},
        ),
        'geheim123',
        iterations: 1000,
      ),
    );
    await expectLater(
      service.restoreFile(file.path, 'geheim123'),
      throwsA(isA<BackupException>()),
    );
  });
}
