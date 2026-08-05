import 'package:flutter/material.dart';

import '../theme/colors/royal_colors.dart';
import '../theme/decorations/royal_radius.dart';
import '../theme/typography/royal_text_styles.dart';

class MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback onTap;
  final Color? iconColor;

  const MenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.trailing,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: RoyalRadius.md,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 14,
          ),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: RoyalColors.surface,
                  borderRadius: RoyalRadius.sm,
                ),
                child: Icon(
                  icon,
                  color: iconColor ?? RoyalColors.primary,
                  size: 22,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: RoyalTextStyles.bodyBold,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: RoyalTextStyles.caption,
                      ),
                    ],
                  ],
                ),
              ),

              trailing ??
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: RoyalColors.textSecondary,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}