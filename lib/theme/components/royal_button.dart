import 'package:flutter/material.dart';

import '../colors/royal_gradients.dart';
import '../decorations/royal_radius.dart';
import '../typography/royal_text_styles.dart';

class RoyalButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;
  final double height;

  const RoyalButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.height = 56,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: RoyalGradients.button,
          borderRadius: RoyalRadius.pill,
        ),
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: icon == null
              ? const SizedBox.shrink()
              : Icon(icon, color: Colors.white),
          label: Text(
            text,
            style: RoyalTextStyles.button,
          ),
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: RoyalRadius.pill,
            ),
          ),
        ),
      ),
    );
  }
}