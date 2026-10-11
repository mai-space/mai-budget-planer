import 'package:flutter/material.dart';

/// App-Logo (gleiche Vorlage wie das Launcher-Icon, tool/generate_icons.py).
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 40});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/branding/logo.png',
      width: size,
      height: size,
      semanticLabel: 'Mai Budget',
    );
  }
}
