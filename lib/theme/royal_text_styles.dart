import 'package:flutter/material.dart';
import 'royal_colors.dart';
import 'royal_spacing.dart';

class RoyalTextStyles {
  RoyalTextStyles._();

  static TextStyle _base(BuildContext context) => TextStyle(
        color: RoyalColors.text,
        fontFamily: 'Inter',
        height: 1.2,
      );

  static TextStyle h1(BuildContext context) =>
      _base(context).copyWith(fontSize: 28 * (MediaQuery.of(context).size.width / 390.0), fontWeight: FontWeight.w700);

  static TextStyle h2(BuildContext context) =>
      _base(context).copyWith(fontSize: 20 * (MediaQuery.of(context).size.width / 390.0), fontWeight: FontWeight.w700);

  static TextStyle h3(BuildContext context) =>
      _base(context).copyWith(fontSize: 16 * (MediaQuery.of(context).size.width / 390.0), fontWeight: FontWeight.w600);

  static TextStyle body(BuildContext context) =>
      _base(context).copyWith(fontSize: 14 * (MediaQuery.of(context).size.width / 390.0), fontWeight: FontWeight.w400);

  static TextStyle caption(BuildContext context) =>
      _base(context).copyWith(fontSize: 12 * (MediaQuery.of(context).size.width / 390.0), color: RoyalColors.hint);

  static TextStyle button(BuildContext context) =>
      _base(context).copyWith(fontSize: 14 * (MediaQuery.of(context).size.width / 390.0), fontWeight: FontWeight.w600);
}
