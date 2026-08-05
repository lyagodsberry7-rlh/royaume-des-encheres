import 'package:flutter/material.dart';

import '../theme/colors/royal_colors.dart';
import '../theme/colors/royal_gradients.dart';
import '../theme/colors/royal_shadows.dart';
import '../theme/decorations/royal_radius.dart';
import '../theme/typography/royal_text_styles.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final bool verified;
  final VoidCallback? onEdit;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.verified,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: RoyalGradients.card,
        borderRadius: RoyalRadius.lg,
        boxShadow: RoyalShadows.medium,
        border: Border.all(
          color: RoyalColors.border,
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 92,
                height: 92,
                decoration: const BoxDecoration(
                  gradient: RoyalGradients.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 46,
                ),
              ),
              if (verified)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: RoyalColors.success,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: RoyalColors.background,
                        width: 3,
                      ),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 18),

          Text(
            name,
            style: RoyalTextStyles.title,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 6),

          Text(
            email,
            style: RoyalTextStyles.caption,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 18),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: verified
                  ? RoyalColors.success.withValues(alpha: .15)
                  : RoyalColors.primary.withValues(alpha: .15),
              borderRadius: RoyalRadius.pill,
            ),
            child: Text(
              verified
                  ? "✔ Compte vérifié"
                  : "👑 Membre Royalis",
              style: TextStyle(
                color: verified
                    ? RoyalColors.success
                    : RoyalColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onEdit,
              icon: const Icon(Icons.edit),
              label: const Text("Modifier le profil"),
              style: FilledButton.styleFrom(
                backgroundColor: RoyalColors.secondary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: RoyalRadius.pill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}