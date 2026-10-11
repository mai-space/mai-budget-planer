import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Vorläufiges Logo (Symbol statt Grafik), bis ein eigenes Icon existiert.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 40});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.seed,
        borderRadius: BorderRadius.circular(size * 0.28),
      ),
      child: Icon(
        Icons.account_balance_wallet_outlined,
        color: Colors.white,
        size: size * 0.58,
        semanticLabel: 'Mai Budget Planer',
      ),
    );
  }
}
