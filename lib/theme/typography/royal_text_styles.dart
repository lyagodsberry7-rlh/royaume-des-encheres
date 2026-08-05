import 'package:flutter/material.dart';

import '../colors/royal_colors.dart';

class RoyalTextStyles {
  RoyalTextStyles._();

  static const TextStyle display = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: RoyalColors.text,
    letterSpacing: -.8,
  );

  static const TextStyle headline = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: RoyalColors.text,
  );

  static const TextStyle title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: RoyalColors.text,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: RoyalColors.textSecondary,
  );

  static const TextStyle body = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: RoyalColors.text,
    height: 1.45,
  );

  static const TextStyle bodyBold = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: RoyalColors.text,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: RoyalColors.textSecondary,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    letterSpacing: .3,
  );

  static const TextStyle price = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: RoyalColors.primary,
  );

  static const TextStyle smallPrice = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: RoyalColors.primary,
  );

  static const TextStyle timer = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: RoyalColors.primary,
  );

  static const TextStyle badge = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    letterSpacing: .5,
  );
}