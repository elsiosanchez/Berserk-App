import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'berserk_colors.dart';
import 'berserk_typography.dart';

class BerserkTheme {
  BerserkTheme._();

  static ThemeData get dark {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: BerserkColors.bg,
      primaryColor: BerserkColors.accent,
      colorScheme: const ColorScheme.dark(
        primary: BerserkColors.accent,
        secondary: BerserkColors.amber,
        surface: BerserkColors.card,
        error: BerserkColors.accent,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: BerserkColors.textPrimary,
        onError: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: BerserkColors.bg,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: BerserkTypography.h3,
        iconTheme: const IconThemeData(color: BerserkColors.textPrimary),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      cardTheme: CardTheme(
        color: BerserkColors.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: EdgeInsets.zero,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: BerserkColors.bg,
        selectedItemColor: BerserkColors.accent,
        unselectedItemColor: BerserkColors.textSecondary,
        selectedLabelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontSize: 10),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: BerserkColors.accent,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: BerserkColors.separator,
        thickness: 0.5,
      ),
      useMaterial3: true,
    );
  }
}
