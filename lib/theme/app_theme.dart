import 'package:flutter/material.dart';

import 'colors/royal_colors.dart';
import 'royal_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => RoyalTheme.light;

  static ThemeData get dark => RoyalTheme.dark;

  static ThemeMode defaultThemeMode = ThemeMode.system;

  static Color get primary => RoyalColors.primary;

  static Color get secondary => RoyalColors.secondary;
}