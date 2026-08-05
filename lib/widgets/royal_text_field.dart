import 'package:flutter/material.dart';

import '../theme/colors/royal_colors.dart';
import '../theme/decorations/royal_radius.dart';

class RoyalTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;

  final bool obscureText;

  final Widget? suffixIcon;

  final TextInputType keyboardType;

  final String? Function(String?)? validator;

  final ValueChanged<String>? onChanged;

  const RoyalTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(
        color: RoyalColors.text,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        hintText: hint,

        hintStyle: const TextStyle(
          color: RoyalColors.hint,
        ),

        prefixIcon: Icon(
          icon,
          color: RoyalColors.primary,
        ),

        suffixIcon: suffixIcon,

        filled: true,
        fillColor: RoyalColors.card,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),

        border: OutlineInputBorder(
          borderRadius: RoyalRadius.lg,
          borderSide: const BorderSide(
            color: RoyalColors.border,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: RoyalRadius.lg,
          borderSide: const BorderSide(
            color: RoyalColors.border,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: RoyalRadius.lg,
          borderSide: const BorderSide(
            color: RoyalColors.primary,
            width: 1.5,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: RoyalRadius.lg,
          borderSide: const BorderSide(
            color: Colors.redAccent,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: RoyalRadius.lg,
          borderSide: const BorderSide(
            color: Colors.redAccent,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}