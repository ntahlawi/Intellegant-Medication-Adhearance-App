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
    primaryContainer: Colors.white
  ),
  iconTheme: IconThemeData(color: Colors.black),
  textTheme: const TextTheme(
    labelSmall: TextStyle(
      color: Colors.black,
    ),
    labelMedium: TextStyle(
      color: Colors.black,
    ),
    labelLarge: TextStyle(
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      color: Colors.black,
    ),
    bodySmall: TextStyle(
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      color: Colors.black,
    ),
    titleSmall: TextStyle(
      color: Colors.white,
    ),
    titleMedium: TextStyle(
      color: Colors.black,
    ),
    titleLarge: TextStyle(
      color: Colors.black,
    ),
    headlineSmall: TextStyle(
      color: Colors.black,
    ),
    headlineMedium: TextStyle(
      color: Colors.black,
    ),
  ),
);
