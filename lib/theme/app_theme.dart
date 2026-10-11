import 'package:flutter/material.dart';

/// Design-Tokens für Mai Budget Planer — ruhig, klar, gleiche Familie wie
/// Mai Doctor Hub (gleiche Formen, eigene Grundfarbe).
abstract final class AppColors {
  static const Color seed = Color(0xFF2F5D7C);
  static const Color surface = Color(0xFFF5F7F9);
  static const Color ink = Color(0xFF15202B);
  static const Color muted = Color(0xFF5B6B78);
  static const Color positive = Color(0xFF2E7D5B);
  static const Color warning = Color(0xFFB7791F);
  static const Color danger = Color(0xFFB33A3A);

  /// Töpfe der Budgetregel.
  static const Color needs = Color(0xFF3F7CAC);
  static const Color wants = Color(0xFFE09F3E);
  static const Color savings = Color(0xFF2E9E6B);

  /// Personenfarben (Index = `Persons.colorIndex`).
  static const List<Color> persons = [
    Color(0xFF3F7CAC),
    Color(0xFFC0587E),
    Color(0xFF6A8D3A),
    Color(0xFF8A5CC2),
    Color(0xFFD9822B),
    Color(0xFF2B9AA0),
  ];

  static Color person(int index) => persons[index % persons.length];
}

abstract final class AppTheme {
  static ThemeData light() {
    final base = ColorScheme.fromSeed(
      seedColor: AppColors.seed,
      brightness: Brightness.light,
      surface: AppColors.surface,
    );
    final textTheme = ThemeData(brightness: Brightness.light).textTheme.apply(
      bodyColor: AppColors.ink,
      displayColor: AppColors.ink,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: base,
      scaffoldBackgroundColor: AppColors.surface,
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.ink,
      ),
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: base.primaryContainer,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        height: 72,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(64, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(64, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.white,
      ),
      listTileTheme: const ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      textTheme: textTheme,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      dividerTheme: const DividerThemeData(thickness: 1, space: 1),
    );
  }
}
