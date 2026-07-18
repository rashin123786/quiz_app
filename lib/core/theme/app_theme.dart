import 'package:flutter/material.dart';

class AppColors {
  // Brand
  static const Color primary = Color(0xFF4F46E5); // indigo
  static const Color primaryLight = Color(0xFFEEF2FF);
  static const Color primaryDark = Color(0xFF3730A3);

  // Status
  static const Color correct = Color(0xFF16A34A);
  static const Color correctBg = Color(0xFFF0FDF4);
  static const Color correctBorder = Color(0xFF86EFAC);

  static const Color incorrect = Color(0xFFDC2626);
  static const Color incorrectBg = Color(0xFFFEF2F2);
  static const Color incorrectBorder = Color(0xFFFCA5A5);

  // Neutral
  static const Color surface = Color(0xFFF8F9FC);
  static const Color card = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE5E7EB);
  static const Color borderStrong = Color(0xFFD1D5DB);

  static const Color text1 = Color(0xFF111827);
  static const Color text2 = Color(0xFF6B7280);
  static const Color text3 = Color(0xFF9CA3AF);

  // Question selector states
  static const Color selectorAnswered = Color(0xFF4F46E5);
  static const Color selectorCurrent = Color(0xFF818CF8);
  static const Color selectorUnanswered = Color(0xFFE5E7EB);
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        surface: AppColors.surface,
      ),
      scaffoldBackgroundColor: AppColors.surface,
      fontFamily: 'Inter',
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.card,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        titleTextStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: AppColors.text1,
        ),
        iconTheme: IconThemeData(color: AppColors.text1),
      ),
      cardTheme: CardThemeData(
        color: AppColors.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.border, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 0,
      ),
    );
  }
}
