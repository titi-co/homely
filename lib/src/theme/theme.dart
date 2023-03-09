import 'package:flutter/material.dart';

enum Themes { darkTheme, lightTheme }

final theme = {
  Themes.darkTheme: ThemeData(
    brightness: Brightness.dark,
  ),
  Themes.lightTheme: ThemeData(
    brightness: Brightness.light,
  ),
};
