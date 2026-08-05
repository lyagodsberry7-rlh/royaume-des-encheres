import 'package:flutter/material.dart';

import '../colors/royal_colors.dart';
import '../decorations/royal_radius.dart';

class RoyalChip extends StatelessWidget {
  final String text;

  final IconData? icon;

  final Color? color;

  final VoidCallback? onTap;

  const RoyalChip({
    super.key,
    required this.text,
    this.icon,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: RoyalRadius.pill,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: color ?? RoyalColors.surface,
          borderRadius: RoyalRadius.pill,
          border: Border.all(
            color: RoyalColors.border,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16,
                color: RoyalColors.primary,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              text,
              style: const TextStyle(
                color: RoyalColors.text,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}