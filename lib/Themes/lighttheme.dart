import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: GoogleFonts.roboto().fontFamily,
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Color.fromRGBO(38, 38, 38, 1),
    ),
  ),
  colorScheme: const ColorScheme.light(
    background: Color.fromRGBO(247, 247, 247, 1),
    primary: Color.fromRGBO(20, 24, 57, 1),
    secondary: Color.fromRGBO(90, 98, 140, 1),
  ),
  textTheme: TextTheme(
    labelSmall: const TextStyle(
        color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
    labelMedium: const TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    labelLarge: const TextStyle(
        color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold),
    bodyLarge: const TextStyle(
      color: Colors.white,
      fontSize: 36,
    ),
    bodySmall: const TextStyle(
      color: Colors.white,
    ),
    bodyMedium: const TextStyle(
      color: Colors.white,
    ),
  ),
);
