import 'package:flutter/material.dart';

class DictionaryTheme {
  static Color primaryColor = Color(0xFF43A047);
  static Color secondaryColor = Color(0xFF43A047);

  static final ColorScheme lightColorScheme = ColorScheme.light().copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
  );

  static final ColorScheme darkColorScheme = ColorScheme.dark().copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
  );

  static ThemeData lightTheme(BuildContext context) =>
      ThemeData.light().copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        splashColor: Colors.green.withOpacity(0.2),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: lightColorScheme,
        primaryColor: primaryColor,
        toggleableActiveColor: primaryColor,
        accentColor: secondaryColor,
        cursorColor: primaryColor,
        indicatorColor: primaryColor,
        textSelectionColor: primaryColor,
        snackBarTheme: SnackBarThemeData(
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6)))),
        textSelectionHandleColor: primaryColor,
        iconTheme: IconThemeData(color: Color(0xFF3E3E3E)),
        inputDecorationTheme: InputDecorationTheme()
            .copyWith(border: OutlineInputBorder(), isDense: true),
      );

  static ThemeData darkTheme(BuildContext context) => ThemeData.dark().copyWith(
        colorScheme: darkColorScheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        splashColor: Colors.green.withOpacity(0.2),
        primaryColor: primaryColor,
        toggleableActiveColor: primaryColor,
        accentColor: secondaryColor,
        cursorColor: primaryColor,
        indicatorColor: primaryColor,
        snackBarTheme: SnackBarThemeData(
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6)))),
        textSelectionColor: primaryColor,
        textSelectionHandleColor: primaryColor,
        iconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
        inputDecorationTheme: InputDecorationTheme()
            .copyWith(border: OutlineInputBorder(), isDense: true),
        brightness: Brightness.dark,
      );
}
