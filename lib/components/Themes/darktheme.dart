import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: GoogleFonts.montserrat().fontFamily,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Color.fromRGBO(255, 255, 255, 1),
    ),
  ),
  colorScheme: const ColorScheme.dark(
      surface: Color.fromRGBO(8, 8, 8, 1),
      primary: Color.fromRGBO(198, 202, 235, 1),
      secondary: Color.fromRGBO(115, 123, 165, 1),
      primaryContainer: Colors.black,
      onSurface: Colors.white),
  iconTheme: const IconThemeData(color: Colors.black),
  textTheme: const TextTheme(
    // Define text styles with different sizes
    labelSmall: TextStyle(
      color: Colors.white,
    ),
    labelMedium: TextStyle(
      color: Colors.black,
    ),
  ),
);
