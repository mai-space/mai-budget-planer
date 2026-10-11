import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../data/database_provider.dart';
import '../../l10n/l10n.dart';
import '../../services/backup_service.dart';

/// Einstellungen → verschlüsselte Sicherung (Export/Restore).
class BackupSection extends StatefulWidget {
  const BackupSection({super.key});

  @override
  State<BackupSection> createState() => _BackupSectionState();
}

class _BackupSectionState extends State<BackupSection> {
  bool _busy = false;

  Future<void> _run(Future<void> Function() task) async {
    setState(() => _busy = true);
    try {
      await task();
    } on BackupException catch (e) {
      _snack(e.message);
    } catch (e) {
      debugPrint('Sicherung fehlgeschlagen: $e');
      if (mounted) _snack(context.l10n.backupFailed);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _snack(String text) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  Future<void> _export() async {
    final passphrase = await _askPassphrase(context, confirm: true);
    if (passphrase == null || !mounted) return;
    final service = BackupService(DatabaseScope.of(context));
    final l10n = context.l10n;
    await _run(() async {
      final file = await service.createBackupFile(passphrase);
      try {
        final result = await SharePlus.instance.share(
          ShareParams(
            files: [XFile(file.path, mimeType: 'application/octet-stream')],
            fileNameOverrides: [
              BackupService.suggestedFileName(DateTime.now()),
            ],
            subject: l10n.backupShareSubject,
          ),
        );
        if (result.status != ShareResultStatus.dismissed) {
          _snack(l10n.backupCreated);
        }
      } finally {
        try {
          await file.delete();
        } catch (_) {}
      }
    });
  }

  Future<void> _import() async {
    final l10n = context.l10n;
    final files = await FilePicker.pickFiles(dialogTitle: l10n.backupPick);
    if (files.isEmpty || !mounted) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.backupRestoreConfirmTitle),
        content: Text(l10n.backupRestoreConfirmText),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.backupReplace),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    final passphrase = await _askPassphrase(context, confirm: false);
    if (passphrase == null || !mounted) return;
    final service = BackupService(DatabaseScope.of(context));
    await _run(() async {
      final (path, staged) = await _localPath(files.first);
      try {
        final createdAt = await service.restoreFile(path, passphrase);
        _snack(l10n.backupRestored(DateFormat.yMd().add_Hm().format(
          createdAt.toLocal(),
        )));
      } finally {
        if (staged) {
          try {
            await File(path).delete();
          } catch (_) {}
        }
      }
    });
  }

  /// Lokaler Pfad der Auswahl; ohne Pfad (`content://`) wird in den
  /// Temp-Ordner kopiert (staged = danach löschen).
  Future<(String, bool)> _localPath(PlatformFile file) async {
    final direct = file.path;
    if (direct != null) return (direct, false);
    final target = File(
      p.join(
        (await getTemporaryDirectory()).path,
        'import_${DateTime.now().microsecondsSinceEpoch}.maibudget',
      ),
    );
    final sink = target.openWrite();
    try {
      await sink.addStream(file.readAsByteStream());
    } finally {
      await sink.close();
    }
    return (target.path, true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (!backupSupported) return Text(l10n.backupUnsupported);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.backupIntro),
        const SizedBox(height: 12),
        if (_busy) const LinearProgressIndicator(),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _busy ? null : _export,
                icon: const Icon(Icons.upload_file),
                label: Text(l10n.backupCreate),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _busy ? null : _import,
                icon: const Icon(Icons.restore),
                label: Text(l10n.backupRestore),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Fragt das Sicherungspasswort ab (beim Erstellen doppelt).
Future<String?> _askPassphrase(BuildContext context, {required bool confirm}) {
  return showDialog<String>(
    context: context,
    builder: (_) => _PassphraseDialog(confirm: confirm),
  );
}

class _PassphraseDialog extends StatefulWidget {
  const _PassphraseDialog({required this.confirm});

  final bool confirm;

  @override
  State<_PassphraseDialog> createState() => _PassphraseDialogState();
}

class _PassphraseDialogState extends State<_PassphraseDialog> {
  final _form = GlobalKey<FormState>();
  final _first = TextEditingController();
  final _second = TextEditingController();

  @override
  void dispose() {
    _first.dispose();
    _second.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(widget.confirm ? l10n.backupCreate : l10n.backupRestore),
      content: Form(
        key: _form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.confirm
                  ? l10n.backupPassphraseCreateHint
                  : l10n.backupPassphraseRestoreHint,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _first,
              obscureText: true,
              autofocus: true,
              decoration: InputDecoration(labelText: l10n.backupPassphrase),
              validator: (v) =>
                  (v ?? '').length < BackupCrypto.minPassphraseLength
                  ? l10n.backupPassphraseTooShort
                  : null,
            ),
            if (widget.confirm) ...[
              const SizedBox(height: 12),
              TextFormField(
                controller: _second,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: l10n.backupPassphraseRepeat,
                ),
                validator: (v) =>
                    v != _first.text ? l10n.backupPassphraseMismatch : null,
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.commonCancel),
        ),
        FilledButton(
          onPressed: () {
            if (_form.currentState!.validate()) {
              Navigator.pop(context, _first.text);
            }
          },
          child: Text(l10n.commonContinue),
        ),
      ],
    );
  }
}
