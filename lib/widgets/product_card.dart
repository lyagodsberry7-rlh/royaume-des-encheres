import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../theme/colors/royal_colors.dart';
import '../theme/colors/royal_gradients.dart';
import '../theme/colors/royal_shadows.dart';
import '../theme/decorations/royal_radius.dart';
import '../theme/typography/royal_text_styles.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double price;
  final String city;
  final String remainingTime;
  final bool favorite;
  final int bids;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;

  const ProductCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.city,
    required this.remainingTime,
    this.favorite = false,
    this.bids = 0,
    this.onTap,
    this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: RoyalRadius.lg,
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            gradient: RoyalGradients.card,
            borderRadius: RoyalRadius.lg,
            border: Border.all(
              color: RoyalColors.border,
            ),
            boxShadow: RoyalShadows.medium,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    child: AspectRatio(
                      aspectRatio: 1.15,
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Container(
                          color: RoyalColors.surface,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (_, __, ___) => Container(
                          color: RoyalColors.surface,
                          child: const Icon(
                            Icons.image_not_supported,
                            size: 50,
                            color: RoyalColors.hint,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: RoyalColors.live,
                        borderRadius: RoyalRadius.pill,
                      ),
                      child: const Text(
                        "ENCHÈRE",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 12,
                    right: 12,
                    child: Material(
                      color: Colors.black.withValues(alpha: .35),
                      shape: const CircleBorder(),
                      child: IconButton(
                        onPressed: onFavorite,
                        icon: Icon(
                          favorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: favorite
                              ? RoyalColors.favorite
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: RoyalTextStyles.bodyBold,
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "${price.toStringAsFixed(0)} FCFA",
                      style: RoyalTextStyles.price,
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 16,
                          color: RoyalColors.primary,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            city,
                            overflow: TextOverflow.ellipsis,
                            style: RoyalTextStyles.caption,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        const Icon(
                          Icons.gavel,
                          size: 16,
                          color: RoyalColors.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "$bids offres",
                          style: RoyalTextStyles.caption,
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.timer_outlined,
                          size: 16,
                          color: RoyalColors.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          remainingTime,
                          style: RoyalTextStyles.timer,
                        ),
                      ],
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