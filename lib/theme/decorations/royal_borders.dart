import 'package:flutter/material.dart';

import '../colors/royal_colors.dart';

class RoyalBorders {
  RoyalBorders._();

  static Border normal = Border.all(
    color: RoyalColors.border,
    width: 1,
  );

  static Border gold = Border.all(
    color: RoyalColors.primary,
    width: 1.2,
  );

  static Border purple = Border.all(
    color: RoyalColors.secondary,
    width: 1.2,
  );
}