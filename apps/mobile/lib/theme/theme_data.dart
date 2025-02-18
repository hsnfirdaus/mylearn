import 'package:flutter/material.dart';

class AppThemeData {
  // Color
  final Color background = Color(0xFFF8FAFC);
  final Color background200 = Color(0xFFE2E8F0);
  final Color backgroundLighest = Color(0xFFFFFFFF);
  final Color primary = Color(0xFF5E77F3);
  final Color error = Color(0xFFD61355);

  // Text Color
  final Color text = Color(0xFF0F172B);
  final Color textPlaceholder = Color(0xDD0F172B);
  final Color textTransparent = Color(0x800F172B);
  final Color textPrimary = Color(0xFF5E77F3);
  final Color textLight = Color(0xFFFFFFFF);

  // Text Style
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

  // Custom Button
  ButtonStyle get deleteButton => ButtonStyle(
    backgroundColor: WidgetStateColor.fromMap({WidgetState.any: error}),
  );

  // Material Theme
  ThemeData get materialTheme {
    // Text
    final textTheme = TextTheme(
      displayLarge: heading1,
      displayMedium: heading2,
      bodyLarge: bodyText,
    );

    // Button
    final filledButtonStyle = FilledButton.styleFrom(
      backgroundColor: primary,
      foregroundColor: textLight,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      splashFactory: NoSplash.splashFactory,
      elevation: 0,
      textStyle: TextStyle(fontWeight: FontWeight.bold),
    );
    final filledButtonTheme = FilledButtonThemeData(style: filledButtonStyle);

    final elevatedButtonStyle = FilledButton.styleFrom(
      backgroundColor: background200,
      foregroundColor: primary,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      splashFactory: NoSplash.splashFactory,
      elevation: 0,
      textStyle: TextStyle(fontWeight: FontWeight.bold),
    );
    final elevatedButtonTheme = ElevatedButtonThemeData(
      style: elevatedButtonStyle,
    );
    final iconButtonTheme = IconButtonThemeData(
      style: ButtonStyle(splashFactory: NoSplash.splashFactory),
    );
    final floatingActionButtonTheme = FloatingActionButtonThemeData(
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
    );

    // Input Decoration
    final inputDecorationTheme = InputDecorationTheme(
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
      errorStyle: TextStyle(
        color: error,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    );

    // List Tile
    final listTileTheme = ListTileThemeData(
      tileColor: background,
      selectedTileColor: primary,
      selectedColor: Colors.white,
      enableFeedback: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: background200),
      ),
      contentPadding: EdgeInsets.only(left: 12, right: 12),
    );

    // App Bar
    final appBarTheme = AppBarTheme(
      backgroundColor: primary,
      titleTextStyle: TextStyle(
        color: textLight,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      centerTitle: true,
      iconTheme: IconThemeData(color: textLight),
    );

    // Dialog
    final dialogTheme = DialogTheme(
      backgroundColor: background,
      titleTextStyle: heading3.copyWith(fontWeight: FontWeight.bold),
      contentTextStyle: bodyText,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );

    // Snack Bar
    final snackBarTheme = SnackBarThemeData(
      backgroundColor: background200,
      contentTextStyle: TextStyle(
        color: textPrimary,
        fontWeight: FontWeight.bold,
      ),
    );

    // Chip
    final chipTheme = ChipThemeData(
      backgroundColor: background200,
      selectedColor: primary,
      side: BorderSide.none,
      checkmarkColor: Colors.white,
    );

    // Date & Time Picker
    final datePickerTheme = DatePickerThemeData(
      headerBackgroundColor: primary,
      headerForegroundColor: textLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      inputDecorationTheme: inputDecorationTheme,
      backgroundColor: background,
      dayBackgroundColor: WidgetStateColor.fromMap({
        WidgetState.selected: primary,
        WidgetState.any: Colors.transparent,
      }),
      todayBackgroundColor: WidgetStateColor.fromMap({
        WidgetState.selected: primary,
        WidgetState.any: Colors.transparent,
      }),
      dayShape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      dividerColor: Colors.transparent,
      confirmButtonStyle: filledButtonStyle,
      cancelButtonStyle: elevatedButtonStyle,
    );
    final timePickerTheme = TimePickerThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      inputDecorationTheme: inputDecorationTheme,
      backgroundColor: background,
      confirmButtonStyle: filledButtonStyle,
      cancelButtonStyle: elevatedButtonStyle,
      dialBackgroundColor: background200,
      dialHandColor: primary,
      hourMinuteTextColor: primary,
      hourMinuteColor: background200,
      timeSelectorSeparatorTextStyle: WidgetStatePropertyAll(
        TextStyle(fontSize: 48),
      ),
    );

    return ThemeData(
      fontFamily: "Lato",
      scaffoldBackgroundColor: background,
      colorSchemeSeed: primary,
      filledButtonTheme: filledButtonTheme,
      elevatedButtonTheme: elevatedButtonTheme,
      textTheme: textTheme,
      inputDecorationTheme: inputDecorationTheme,
      chipTheme: chipTheme,
      listTileTheme: listTileTheme,
      appBarTheme: appBarTheme,
      iconButtonTheme: iconButtonTheme,
      floatingActionButtonTheme: floatingActionButtonTheme,
      dialogTheme: dialogTheme,
      snackBarTheme: snackBarTheme,
      datePickerTheme: datePickerTheme,
      timePickerTheme: timePickerTheme,
    );
  }
}
