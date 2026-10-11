import 'package:flutter/material.dart';

import '../../data/database_provider.dart';
import '../../data/repositories/settings_repository.dart';
import '../../l10n/l10n.dart';
import '../../services/app_lock.dart';

/// Einstellungen → App-Sperre (wie in Mai Doctor Hub).
class SecuritySection extends StatelessWidget {
  const SecuritySection({super.key});

  Future<void> _toggle(BuildContext context, bool value) async {
    final lock = AppLockScope.of(context);
    final settings = SettingsRepository(DatabaseScope.of(context));
    final messenger = ScaffoldMessenger.of(context);
    final l10n = context.l10n;
    if (value) {
      if (!await lock.authenticator.isAvailable()) {
        messenger.showSnackBar(
          SnackBar(content: Text(l10n.settingsLockNoDeviceLock)),
        );
        return;
      }
      if (!await lock.enableWithConfirmation()) return;
    } else {
      if (!await lock.disableWithConfirmation()) return;
    }
    await settings.setAppLock(value);
  }

  @override
  Widget build(BuildContext context) {
    final lock = AppLockScope.of(context);
    final l10n = context.l10n;
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      secondary: const Icon(Icons.fingerprint),
      title: Text(l10n.settingsLockTitle),
      subtitle: Text(l10n.settingsLockSubtitle),
      value: lock.enabled,
      onChanged: lock.authenticating ? null : (v) => _toggle(context, v),
    );
  }
}
