import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: GoogleFonts.montserrat().fontFamily,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.black, // Adjust title text color as needed
    ),
  ),
  colorScheme: const ColorScheme.light(
      background: Color.fromRGBO(247, 247, 247, 1),
      primary: Color.fromRGBO(20, 24, 57, 1),
      secondary: Color.fromRGBO(90, 98, 140, 1),
      primaryContainer: Colors.white,
      onBackground: Colors.black),
  iconTheme: const IconThemeData(color: Colors.white),
  textTheme: const TextTheme(
    // Define text styles with different sizes
    labelSmall: TextStyle(
      color: Colors.black,
    ),
    labelMedium: TextStyle(
      color: Colors.white,
    ),
  ),
);
