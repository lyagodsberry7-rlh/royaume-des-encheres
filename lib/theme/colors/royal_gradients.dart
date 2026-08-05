import 'package:flutter/material.dart';

import 'royal_colors.dart';

class RoyalGradients {
  RoyalGradients._();

  static const LinearGradient primary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      RoyalColors.secondary,
      RoyalColors.primary,
    ],
  );

  static const LinearGradient card = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF252525),
      Color(0xFF1A1A1A),
    ],
  );

  static const LinearGradient button = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      RoyalColors.secondary,
      RoyalColors.secondaryDark,
    ],
  );

  static const LinearGradient premium = LinearGradient(
    colors: [
      Color(0xFFFFE082),
      RoyalColors.primary,
    ],
  );
}