import 'package:flutter/material.dart';

import 'colors/royal_colors.dart';
import 'typography/royal_text_styles.dart';

class RoyalTheme {
  RoyalTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,

      brightness: Brightness.light,

      scaffoldBackgroundColor: RoyalColors.background,

      primaryColor: RoyalColors.primary,

      colorScheme: const ColorScheme.light(
        primary: RoyalColors.primary,
        secondary: RoyalColors.secondary,
        surface: RoyalColors.surface,
      ),

      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: RoyalColors.background,
        foregroundColor: RoyalColors.text,
      ),

      textTheme: const TextTheme(
        displayLarge: RoyalTextStyles.display,
        headlineMedium: RoyalTextStyles.headline,
        titleLarge: RoyalTextStyles.title,
        titleMedium: RoyalTextStyles.subtitle,
        bodyLarge: RoyalTextStyles.body,
        bodyMedium: RoyalTextStyles.body,
        labelLarge: RoyalTextStyles.button,
      ),

      cardColor: RoyalColors.card,

      dividerColor: RoyalColors.divider,

      iconTheme: const IconThemeData(
        color: RoyalColors.icon,
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,

      brightness: Brightness.dark,

      scaffoldBackgroundColor: RoyalColors.background,

      primaryColor: RoyalColors.primary,

      colorScheme: const ColorScheme.dark(
        primary: RoyalColors.primary,
        secondary: RoyalColors.secondary,
        surface: RoyalColors.surface,
      ),

      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: RoyalColors.background,
        foregroundColor: RoyalColors.text,
      ),

      textTheme: const TextTheme(
        displayLarge: RoyalTextStyles.display,
        headlineMedium: RoyalTextStyles.headline,
        titleLarge: RoyalTextStyles.title,
        titleMedium: RoyalTextStyles.subtitle,
        bodyLarge: RoyalTextStyles.body,
        bodyMedium: RoyalTextStyles.body,
        labelLarge: RoyalTextStyles.button,
      ),

      cardColor: RoyalColors.card,

      dividerColor: RoyalColors.divider,

      iconTheme: const IconThemeData(
        color: RoyalColors.icon,
      ),
    );
  }
}