import 'package:flutter/material.dart';

import '../theme/colors/royal_colors.dart';
import '../theme/colors/royal_gradients.dart';
import '../theme/colors/royal_shadows.dart';
import '../theme/decorations/royal_radius.dart';
import '../theme/typography/royal_text_styles.dart';

class StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color? color;
  final VoidCallback? onTap;

  const StatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = color ?? RoyalColors.primary;

    Widget child = Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 14,
      ),
      decoration: BoxDecoration(
        gradient: RoyalGradients.card,
        borderRadius: RoyalRadius.lg,
        border: Border.all(
          color: RoyalColors.border,
        ),
        boxShadow: RoyalShadows.small,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: .12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
          ),

          const SizedBox(height: 14),

          Text(
            value,
            style: RoyalTextStyles.price,
          ),

          const SizedBox(height: 6),

          Text(
            label,
            textAlign: TextAlign.center,
            style: RoyalTextStyles.caption,
          ),
        ],
      ),
    );

    if (onTap == null) return child;

    return InkWell(
      borderRadius: RoyalRadius.lg,
      onTap: onTap,
      child: child,
    );
  }
}