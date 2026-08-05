import 'package:flutter/material.dart';

import '../theme/colors/royal_colors.dart';
import '../theme/decorations/royal_radius.dart';
import '../theme/typography/royal_text_styles.dart';

class CategoryChip extends StatelessWidget {
  final String title;
  final IconData? icon;
  final bool selected;
  final VoidCallback? onTap;

  const CategoryChip({
    super.key,
    required this.title,
    this.icon,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final background =
        selected ? RoyalColors.secondary : RoyalColors.surface;

    final foreground =
        selected ? Colors.white : RoyalColors.text;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: RoyalRadius.pill,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: background,
            borderRadius: RoyalRadius.pill,
            border: Border.all(
              color: selected
                  ? RoyalColors.secondary
                  : RoyalColors.border,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 18,
                  color: foreground,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                title,
                style: RoyalTextStyles.bodyBold.copyWith(
                  color: foreground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}