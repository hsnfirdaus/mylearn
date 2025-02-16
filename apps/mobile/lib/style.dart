import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFFF8FAFC);
  static const Color background200 = Color(0xFFE2E8F0);
  static const Color primary = Color(0xFF155DFC);
  static const Color error = Color(0xFFD61355);

  static const Color text = Color(0xFF0F172B);
  static const Color textPlaceholder = Color(0xDD0F172B);
  static const Color textPrimary = Color(0xFF1C398E);
}

class AppTextStyles {
  static TextStyle heading1 = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 32,
    fontWeight: FontWeight.w900,
  );

  static TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w900,
    color: AppColors.textPrimary,
  );

  static TextStyle bodyText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.text,
  );

  static TextStyle buttonText = TextStyle(fontSize: 16, color: Colors.white);
  static TextStyle elevatedButtonText = TextStyle(
    fontSize: 16,
    color: AppColors.textPrimary,
  );
}

class AppThemeData {
  static ThemeData theme = ThemeData(
    fontFamily: "Lato",
    scaffoldBackgroundColor: AppColors.background,
    colorSchemeSeed: AppColors.primary,
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        splashFactory: NoSplash.splashFactory,
        elevation: 0,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.background200,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        splashFactory: NoSplash.splashFactory,
        elevation: 0,
      ),
    ),
    textTheme: TextTheme(
      displayLarge: AppTextStyles.heading1, // For big titles
      displayMedium: AppTextStyles.heading2, // For subtitles
      bodyLarge: AppTextStyles.bodyText, // For normal paragraphs
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.background200,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.background200, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.background200, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.error, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.error, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      labelStyle: TextStyle(color: AppColors.text),
      floatingLabelStyle: TextStyle(
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
      ),
      errorStyle: TextStyle(
        color: AppColors.error,
        fontWeight: FontWeight.bold,
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.background200,
      selectedColor: AppColors.primary,
      side: BorderSide.none,
      checkmarkColor: Colors.white,
    ),
    listTileTheme: ListTileThemeData(
      tileColor: AppColors.background,
      selectedTileColor: AppColors.primary,
      selectedColor: Colors.white,
      enableFeedback: false,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
