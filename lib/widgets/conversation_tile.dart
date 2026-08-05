import 'package:flutter/material.dart';

import '../theme/colors/royal_colors.dart';
import '../theme/colors/royal_shadows.dart';
import '../theme/decorations/royal_radius.dart';
import '../theme/typography/royal_text_styles.dart';

class ConversationTile extends StatelessWidget {
  final String name;
  final String lastMessage;
  final String time;
  final String? avatarUrl;
  final bool online;
  final bool unread;
  final int unreadCount;
  final VoidCallback? onTap;

  const ConversationTile({
    super.key,
    required this.name,
    required this.lastMessage,
    required this.time,
    this.avatarUrl,
    this.online = false,
    this.unread = false,
    this.unreadCount = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: RoyalRadius.lg,
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: RoyalColors.card,
            borderRadius: RoyalRadius.lg,
            border: Border.all(
              color: RoyalColors.border,
            ),
            boxShadow: RoyalShadows.small,
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: RoyalColors.secondary,
                    backgroundImage: avatarUrl != null
                        ? NetworkImage(avatarUrl!)
                        : null,
                    child: avatarUrl == null
                        ? Text(
                            name.isNotEmpty
                                ? name[0].toUpperCase()
                                : "?",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          )
                        : null,
                  ),

                  if (online)
                    Positioned(
                      right: 2,
                      bottom: 2,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: RoyalColors.success,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: RoyalColors.background,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: RoyalTextStyles.bodyBold,
                    ),

                    const SizedBox(height: 6),

                    Text(
                      lastMessage,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: RoyalTextStyles.caption,
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    time,
                    style: RoyalTextStyles.caption.copyWith(
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 10),

                  if (unreadCount > 0)
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: RoyalColors.secondary,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        unreadCount > 99
                            ? "99+"
                            : unreadCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  else if (unread)
                    const Icon(
                      Icons.mark_chat_unread_rounded,
                      color: RoyalColors.primary,
                      size: 18,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}