import 'package:flutter/material.dart';

class AppThemeData {
  final Color background = Color(0xFFF8FAFC);
  final Color background200 = Color(0xFFE2E8F0);
  final Color backgroundLighest = Color(0xFFFFFFFF);

  final Color primary = Color(0xFF5E77F3);
  final Color error = Color(0xFFD61355);

  final Color text = Color(0xFF0F172B);
  final Color textPlaceholder = Color(0xDD0F172B);
  final Color textTransparent = Color(0x800F172B);
  final Color textPrimary = Color(0xFF5E77F3);
  final Color textLight = Color(0xFFFFFFFF);

  TextStyle get heading1 =>
      TextStyle(color: textPrimary, fontSize: 32, fontWeight: FontWeight.w900);

  TextStyle get heading2 =>
      TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: textPrimary);

  TextStyle get heading3 =>
      TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: textPrimary);

  TextStyle get bodyText =>
      TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: text);

  TextStyle get metaText => TextStyle(
    fontWeight: FontWeight.bold,
    color: textTransparent,
    fontSize: 14,
  );

  TextStyle get buttonText => TextStyle(fontSize: 16, color: Colors.white);
  TextStyle get elevatedButtonText =>
      TextStyle(fontSize: 16, color: textPrimary);

  ThemeData get materialTheme {
    return ThemeData(
      fontFamily: "Lato",
      scaffoldBackgroundColor: background,
      colorSchemeSeed: primary,
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primary,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          splashFactory: NoSplash.splashFactory,
          elevation: 0,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: background200,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          splashFactory: NoSplash.splashFactory,
          elevation: 0,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: heading1, // For big titles
        displayMedium: heading2, // For subtitles
        bodyLarge: bodyText, // For normal paragraphs
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: background200,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: background200, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: background200, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: error, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: error, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        labelStyle: TextStyle(color: text),
        floatingLabelStyle: TextStyle(
          color: primary,
          fontWeight: FontWeight.bold,
        ),
        errorStyle: TextStyle(color: error, fontWeight: FontWeight.bold),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: background200,
        selectedColor: primary,
        side: BorderSide.none,
        checkmarkColor: Colors.white,
      ),
      listTileTheme: ListTileThemeData(
        tileColor: background,
        selectedTileColor: primary,
        selectedColor: Colors.white,
        enableFeedback: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: background200),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primary,
        titleTextStyle: TextStyle(
          color: textLight,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: textLight),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(splashFactory: NoSplash.splashFactory),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        splashColor: Colors.transparent,
        backgroundColor: primary,
        foregroundColor: textLight,
        extendedSizeConstraints: BoxConstraints.tightFor(height: 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        disabledElevation: 0,
      ),
    );
  }
}
