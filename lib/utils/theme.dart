import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DictionaryTheme {
  static Color primaryColor = Color(0xFFc71c40);
  static Color secondaryColor = Color(0xFFf8f1e7);

  static final ColorScheme lightColorScheme = ColorScheme.light().copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
  );

  static ThemeData lightTheme(BuildContext context) =>
      ThemeData.light().copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: lightColorScheme,
        textTheme: GoogleFonts.merriweatherTextTheme(),
        primaryColor: primaryColor,
        toggleableActiveColor: primaryColor,
        accentColor: secondaryColor,
        cursorColor: primaryColor,
        indicatorColor: primaryColor,
        textSelectionColor: primaryColor,
        textSelectionHandleColor: primaryColor,
        inputDecorationTheme: InputDecorationTheme()
            .copyWith(border: OutlineInputBorder(), isDense: true),
      );
}
