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
      primaryContainer: Colors.black),
  iconTheme: const IconThemeData(color: Colors.white),
  textTheme: const TextTheme(
    labelSmall: TextStyle(
      color: Color.fromRGBO(217, 217, 217, 1),
    ),
    labelMedium: TextStyle(
      color: Color.fromRGBO(217, 217, 217, 1),
    ),
    labelLarge: TextStyle(
      color: Color.fromRGBO(217, 217, 217, 1),
    ),
    bodyLarge: TextStyle(
      color: Color.fromRGBO(217, 217, 217, 1),
    ),
    bodySmall: TextStyle(
      color: Color.fromRGBO(217, 217, 217, 1),
    ),
    bodyMedium: TextStyle(
      color: Color.fromRGBO(217, 217, 217, 1),
    ),
    titleSmall: TextStyle(
      color: Colors.black,
    ),
    titleMedium: TextStyle(
      color: Color.fromRGBO(217, 217, 217, 1),
    ),
    titleLarge: TextStyle(
      color: Color.fromRGBO(217, 217, 217, 1),
    ),
    headlineSmall: TextStyle(
      color: Color.fromRGBO(217, 217, 217, 1),
    ),
    headlineMedium: TextStyle(
      color: Color.fromRGBO(217, 217, 217, 1),
    ),
  ),
);
