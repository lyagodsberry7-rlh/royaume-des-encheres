import 'package:flutter/material.dart';

import '../theme/colors/royal_colors.dart';
import '../theme/colors/royal_shadows.dart';
import '../theme/decorations/royal_radius.dart';
import '../theme/typography/royal_text_styles.dart';

class NotificationTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String time;
  final bool unread;
  final VoidCallback? onTap;

  const NotificationTile({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    required this.time,
    this.unread = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: RoyalRadius.lg,
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: unread
                ? RoyalColors.secondary.withValues(alpha: .08)
                : RoyalColors.card,
            borderRadius: RoyalRadius.lg,
            border: Border.all(
              color: unread
                  ? RoyalColors.secondary
                  : RoyalColors.border,
            ),
            boxShadow: RoyalShadows.small,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: RoyalColors.primary.withValues(alpha: .12),
                  borderRadius: RoyalRadius.md,
                ),
                child: Icon(
                  icon,
                  color: RoyalColors.primary,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: RoyalTextStyles.bodyBold,
                          ),
                        ),
                        if (unread)
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: RoyalColors.secondary,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Text(
                      message,
                      style: RoyalTextStyles.caption,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 10),

                    Text(
                      time,
                      style: RoyalTextStyles.caption.copyWith(
                        color: RoyalColors.hint,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}