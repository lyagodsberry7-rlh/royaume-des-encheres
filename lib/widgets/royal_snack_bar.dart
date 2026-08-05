import 'package:flutter/material.dart';
import '../theme/royal_colors.dart';
import '../theme/royal_text_styles.dart';

class RoyalSnackBar {
  RoyalSnackBar._();

  static void show(BuildContext context, String message, {Duration duration = const Duration(seconds: 3)}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message, style: RoyalTextStyles.body(context)),
      duration: duration,
      backgroundColor: RoyalColors.surface,
    ));
  }
}
