import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: GoogleFonts.roboto().fontFamily,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Color.fromRGBO(217, 217, 217, 1),
    ),
  ),
  colorScheme: const ColorScheme.dark(
    background: Color.fromRGBO(8, 8, 8, 1),
    primary: Color.fromRGBO(198, 202, 235, 1),
    secondary: Color.fromRGBO(115, 123, 165, 1),
  ),
  textTheme: TextTheme(
    labelSmall: const TextStyle(
        color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
    labelMedium: const TextStyle(
        color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
    labelLarge: const TextStyle(
        color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold),
    bodyLarge: const TextStyle(
      color: Colors.white,
    ),
    bodySmall: const TextStyle(
      color: Colors.white,
    ),
    bodyMedium: const TextStyle(
      color: Colors.white,
    ),
  ),
);
