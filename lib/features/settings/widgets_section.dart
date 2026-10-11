import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';
import '../../shell/app_shell.dart';
import '../../theme/app_theme.dart';

/// Einstellungen → Widgets auf dem Startbildschirm.
class WidgetsSection extends StatelessWidget {
  const WidgetsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final widgets = HomeWidgetScope.of(context);
    final settings = SnapshotScope.of(context).snapshot.settings;
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          secondary: const Icon(Icons.visibility_off_outlined),
          title: Text(l10n.settingsWidgetsHideAmounts),
          subtitle: Text(l10n.settingsWidgetsHideAmountsSubtitle),
          value: widgets.hideAmounts(settings),
          onChanged: widgets.setHideAmounts,
        ),
        Text(
          l10n.settingsWidgetsHint,
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(color: AppColors.muted),
        ),
      ],
    );
  }
}
