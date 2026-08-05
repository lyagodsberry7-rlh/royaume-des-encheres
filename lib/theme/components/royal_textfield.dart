import 'package:flutter/material.dart';

import '../colors/royal_colors.dart';
import '../decorations/royal_radius.dart';
import '../typography/royal_text_styles.dart';

class RoyalTextField extends StatelessWidget {
  final TextEditingController? controller;

  final String hint;

  final IconData? prefixIcon;

  final TextInputType keyboardType;

  final bool obscureText;

  final int maxLines;

  final String? Function(String?)? validator;

  const RoyalTextField({
    super.key,
    this.controller,
    required this.hint,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      style: RoyalTextStyles.body,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: RoyalColors.hint,
        ),
        prefixIcon: prefixIcon == null
            ? null
            : Icon(
                prefixIcon,
                color: RoyalColors.icon,
              ),
        filled: true,
        fillColor: RoyalColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: RoyalRadius.md,
          borderSide: const BorderSide(
            color: RoyalColors.border,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: RoyalRadius.md,
          borderSide: const BorderSide(
            color: RoyalColors.border,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: RoyalRadius.md,
          borderSide: const BorderSide(
            color: RoyalColors.secondary,
            width: 2,
          ),
        ),
      ),
    );
  }
}