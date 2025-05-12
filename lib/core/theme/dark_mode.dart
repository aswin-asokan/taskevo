import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkmode = ThemeData(
  colorScheme: ColorScheme.light(
    primary: Color(0xff336fd2),
    secondary: Color(0xff191c24),
    tertiary: Color(0xff3c4551),
    inversePrimary: Color(0xffe0dfe3),
    onSurface: Color(0xff4f596c),
  ),
  textTheme: TextTheme(
    titleLarge: GoogleFonts.outfit(
      fontWeight: FontWeight.w400,
      fontSize: 28,
      color: Color(0xff3c4551),
    ),
    titleMedium: GoogleFonts.outfit(
      fontWeight: FontWeight.w400,
      fontSize: 20,
      color: Color(0xff3c4551),
    ),
    bodyMedium: GoogleFonts.outfit(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: Color(0xff4f596c),
    ),
    bodySmall: GoogleFonts.outfit(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: Color(0xff4f596c),
    ),
    displayMedium: GoogleFonts.outfit(fontSize: 16, color: Color(0xff3c4551)),
    labelMedium: GoogleFonts.outfit(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Color(0xff3c4551),
    ),
  ),
  scaffoldBackgroundColor: Color(0xff13161b),
);
