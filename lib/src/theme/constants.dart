import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeVariables {
  static const double sheet = 32;
  static const double sectionHeader = 23;
  static const double body1 = 16;
  static const double body2 = 16;

  static const double xl = 64;
  static const double lg = 48;
  static const double md = 24;
  static const double sm = 16;
  static const double xs = 8;

  static Color redColor = const Color(0xFFD03660);
  static Color lightModeColor = const Color(0xFFF2CD5C);
  static Color darkModeColor = const Color(0xFF865DFF);

  static TextStyle logo = GoogleFonts.raleway(
    textStyle: const TextStyle(
      fontSize: ThemeVariables.sheet,
      fontWeight: FontWeight.w900,
    ),
  );

  static TextStyle sheetTitle = GoogleFonts.raleway(
    textStyle: const TextStyle(
      fontSize: ThemeVariables.sheet,
      fontWeight: FontWeight.bold,
    ),
  );
}
