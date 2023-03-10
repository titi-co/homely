import 'package:flutter/material.dart';
import 'package:homely/src/theme/constants.dart';

enum Themes { darkTheme, lightTheme }

final theme = {
  Themes.darkTheme: ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Colors.black,
      onPrimary: Colors.white,

      // Colors that are not relevant to AppBar in LIGHT mode:
      secondary: Colors.tealAccent,
      onSecondary: Colors.black,
      background: Colors.grey,
      onBackground: Colors.grey,
      surface: Colors.transparent,
      onSurface: Colors.white,
      error: Colors.grey,
      onError: Colors.grey,
    ),
  ),
  Themes.lightTheme: ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Colors.white,
      onPrimary: Colors.black,

      // Colors that are not relevant to AppBar in LIGHT mode:
      secondary: ThemeVariables.redColor,
      onSecondary: Colors.white,
      background: Colors.white,
      onBackground: Colors.white,
      surface: Colors.white,
      onSurface: Colors.white,
      error: Colors.white,
      onError: Colors.white,
    ),
  ),
};
