import 'package:flutter/material.dart';
import 'royal_colors.dart';

class RoyalShadows {
  RoyalShadows._();

  static List<BoxShadow> subtle = [
    BoxShadow(
      color: RoyalColors.black.withOpacity(0.35),
      blurRadius: 18,
      offset: Offset(0, 6),
    ),
  ];

  static List<BoxShadow> light = [
    BoxShadow(
      color: RoyalColors.black.withOpacity(0.16),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];

  static List<BoxShadow> none = [];
}
