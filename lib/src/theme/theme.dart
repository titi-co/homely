import 'package:flutter/material.dart';
import 'package:homely/src/theme/constants.dart';

enum Themes { darkTheme, lightTheme }

final theme = {
  Themes.darkTheme: ThemeData(
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: Colors.tealAccent,
      selectionHandleColor: Colors.tealAccent,
    ),
    scaffoldBackgroundColor: Colors.grey[850],
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Colors.black,
      onPrimary: Colors.white,

      // Colors that are not relevant to AppBar in LIGHT mode:
      secondary: Colors.tealAccent,
      onSecondary: Colors.black,
      background: Colors.grey.shade900,
      onBackground: Colors.grey,
      surface: Colors.grey[850] ?? Colors.grey.shade900,
      onSurface: Colors.white,
      error: Colors.red,
      onError: Colors.grey,
    ),
  ),
  Themes.lightTheme: ThemeData(
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: ThemeVariables.redColor,
      selectionHandleColor: ThemeVariables.redColor,
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Colors.white,
      onPrimary: Colors.black,

      // Colors that are not relevant to AppBar in LIGHT mode:
      secondary: ThemeVariables.redColor,
      onSecondary: Colors.white,
      background: Colors.white,
      onBackground: Colors.grey,
      surface: Colors.white,
      onSurface: Colors.grey,
      error: Colors.red,
      onError: Colors.grey,
    ),
  ),
};
