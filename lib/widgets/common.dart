import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/app_database.dart';
import '../domain/money.dart';
import '../l10n/l10n.dart';
import '../theme/app_theme.dart';

/// Monat oder Jahr — gilt app-weit für alle Beträge.
final showYearly = ValueNotifier<bool>(false);

/// Betrag je Monat (Cent) im gewählten Zeitraum.
class PeriodAmount extends StatelessWidget {
  const PeriodAmount(this.monthlyCents, {super.key, this.style, this.signed = false});

  final double monthlyCents;
  final TextStyle? style;
  final bool signed;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: showYearly,
      builder: (context, yearly, _) {
        final value = yearly ? monthlyCents * 12 : monthlyCents;
        return Text(
          signed ? Money.signed(value) : Money.format(value),
          style: style,
          textAlign: TextAlign.end,
        );
      },
    );
  }
}

/// Umschalter Monat/Jahr für die App-Leiste.
class PeriodToggle extends StatelessWidget {
  const PeriodToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: ValueListenableBuilder<bool>(
        valueListenable: showYearly,
        builder: (context, yearly, _) => SegmentedButton<bool>(
          showSelectedIcon: false,
          style: const ButtonStyle(visualDensity: VisualDensity.compact),
          segments: [
            ButtonSegment(value: false, label: Text(l10n.commonPerMonth)),
            ButtonSegment(value: true, label: Text(l10n.commonPerYear)),
          ],
          selected: {yearly},
          onSelectionChanged: (s) => showYearly.value = s.first,
        ),
      ),
    );
  }
}

/// Überschrift einer Karte/eines Abschnitts.
class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key, this.trailing});

  final String text;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

/// Karte mit Innenabstand.
class PaddedCard extends StatelessWidget {
  const PaddedCard({super.key, required this.child, this.color});

  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) => Card(
    color: color,
    child: Padding(padding: const EdgeInsets.all(16), child: child),
  );
}

/// Farbiger Punkt + Name einer Person.
class PersonDot extends StatelessWidget {
  const PersonDot({super.key, required this.colorIndex, this.size = 10});

  final int colorIndex;
  final double size;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: AppColors.person(colorIndex),
      shape: BoxShape.circle,
    ),
  );
}

/// Leerer Zustand einer Liste.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 48, 32, 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 56, color: theme.colorScheme.primary),
          const SizedBox(height: 16),
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.muted),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Betragsfeld: akzeptiert „12,50“ und einfache Rechnungen („195,05/12“).
class MoneyField extends StatelessWidget {
  const MoneyField({
    super.key,
    required this.controller,
    required this.label,
    this.required = false,
    this.helper,
    this.onChanged,
  });

  final TextEditingController controller;
  final String label;
  final bool required;
  final String? helper;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        suffixText: '€',
        helperText: helper,
      ),
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
        signed: true,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.,+\-*/ €]')),
      ],
      onChanged: onChanged,
      validator: (value) {
        final text = value?.trim() ?? '';
        if (text.isEmpty) return required ? l10n.commonRequired : null;
        final cents = Money.parse(text);
        if (cents == null) return l10n.commonInvalidAmount;
        if (cents < 0) return l10n.commonNegativeAmount;
        return null;
      },
    );
  }
}

/// Symbol einer Kategorie.
const categoryIcons = <String, IconData>{
  'home': Icons.home_outlined,
  'shield': Icons.shield_outlined,
  'car': Icons.directions_car_outlined,
  'phone': Icons.smartphone_outlined,
  'subscriptions': Icons.subscriptions_outlined,
  'bank': Icons.account_balance_outlined,
  'cart': Icons.shopping_cart_outlined,
  'leisure': Icons.celebration_outlined,
  'savings': Icons.savings_outlined,
  'pets': Icons.pets_outlined,
  'child': Icons.child_care_outlined,
  'health': Icons.favorite_border,
  'education': Icons.school_outlined,
  'travel': Icons.flight_outlined,
  'gift': Icons.card_giftcard_outlined,
  'work': Icons.work_outline,
  'category': Icons.category_outlined,
};

IconData categoryIcon(String key) =>
    categoryIcons[key] ?? Icons.category_outlined;

Color bucketColor(BudgetBucket bucket) => switch (bucket) {
  BudgetBucket.needs => AppColors.needs,
  BudgetBucket.wants => AppColors.wants,
  BudgetBucket.savings => AppColors.savings,
};

extension BudgetLabels on AppLocalizations {
  String bucketName(BudgetBucket bucket) => switch (bucket) {
    BudgetBucket.needs => bucketNeeds,
    BudgetBucket.wants => bucketWants,
    BudgetBucket.savings => bucketSavings,
  };

  String intervalName(PayInterval interval) => switch (interval) {
    PayInterval.monthly => intervalMonthly,
    PayInterval.quarterly => intervalQuarterly,
    PayInterval.halfYearly => intervalHalfYearly,
    PayInterval.yearly => intervalYearly,
    PayInterval.weekly => intervalWeekly,
  };

  String accountKindName(AccountKind kind) => switch (kind) {
    AccountKind.checking => accountKindChecking,
    AccountKind.savings => accountKindSavings,
    AccountKind.card => accountKindCard,
    AccountKind.other => accountKindOther,
  };

  String splitModeName(SplitMode mode) => switch (mode) {
    SplitMode.proportional => splitProportional,
    SplitMode.equal => splitEqual,
    SplitMode.equalRemainder => splitEqualRemainder,
  };

  String splitModeHint(SplitMode mode) => switch (mode) {
    SplitMode.proportional => splitProportionalHint,
    SplitMode.equal => splitEqualHint,
    SplitMode.equalRemainder => splitEqualRemainderHint,
  };
}
