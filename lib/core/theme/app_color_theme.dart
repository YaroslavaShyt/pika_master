import 'package:flutter/material.dart';

import 'color_palette.dart';

ColorScheme getColorScheme(BuildContext context) =>
    Theme.of(context).colorScheme;

class AppColorTheme {
  static ThemeData theme(BuildContext context) => ThemeData(
        colorScheme: _lightColorScheme,
      );

  static final ColorScheme _lightColorScheme = ColorScheme(
    surface: ColorPalette.yellow1,
    onSurface: ColorPalette.black,
    primary: ColorPalette.red,
    onPrimary: ColorPalette.black,
    error: ColorPalette.red,
    secondary: ColorPalette.yellow1,
    onSecondary: Colors.black,
    onError: ColorPalette.red,
    brightness: Brightness.light,
  );
}
