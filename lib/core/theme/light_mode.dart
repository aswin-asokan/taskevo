import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightmode = ThemeData(
  colorScheme: ColorScheme.light(
    primary: Color(0xfffed1b8),
    secondary: Color(0xfffef6e9),
    tertiary: Color(0xff4B2E2B),
    inversePrimary: Color(0xff664639),
    onSurface: Color(0xffd0bdac),
  ),
  textTheme: TextTheme(
    titleLarge: GoogleFonts.outfit(
      fontWeight: FontWeight.w400,
      fontSize: 28,
      color: Color(0xff4B2E2B),
    ),
    titleMedium: GoogleFonts.outfit(
      fontWeight: FontWeight.w400,
      fontSize: 20,
      color: Color(0xff4B2E2B),
    ),
    bodyMedium: GoogleFonts.outfit(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: Color(0xffd0bdac),
    ),
    bodySmall: GoogleFonts.outfit(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: Color(0xffd0bdac),
    ),
    displayMedium: GoogleFonts.outfit(fontSize: 16, color: Color(0xff4B2E2B)),
    labelMedium: GoogleFonts.outfit(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Color(0xff4B2E2B),
    ),
  ),
  scaffoldBackgroundColor: Color(0xfffefcf4),
);
