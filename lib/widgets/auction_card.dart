import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../theme/colors/royal_colors.dart';
import '../theme/colors/royal_gradients.dart';
import '../theme/colors/royal_shadows.dart';
import '../theme/decorations/royal_radius.dart';
import '../theme/typography/royal_text_styles.dart';

class AuctionCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String seller;
  final String city;

  final double currentPrice;
  final double startPrice;

  final int bids;
  final int favorites;
  final int views;

  final String remainingTime;

  final bool verified;
  final bool favorite;

  final VoidCallback? onTap;
  final VoidCallback? onFavorite;

  const AuctionCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.seller,
    required this.city,
    required this.currentPrice,
    required this.startPrice,
    required this.bids,
    required this.favorites,
    required this.views,
    required this.remainingTime,
    this.verified = false,
    this.favorite = false,
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
              //---------------- IMAGE ----------------

              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    child: AspectRatio(
                      aspectRatio: 1.18,
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
                            Icons.image,
                            color: RoyalColors.hint,
                            size: 60,
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
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: RoyalColors.live,
                        borderRadius: RoyalRadius.pill,
                      ),
                      child: const Text(
                        "LIVE",
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
                      color: Colors.black.withValues(alpha: .30),
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

                  Positioned(
                    bottom: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: .55),
                        borderRadius: RoyalRadius.pill,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.timer_outlined,
                            color: RoyalColors.primary,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            remainingTime,
                            style: RoyalTextStyles.timer,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              //---------------- CONTENU ----------------

              Padding(
                padding: const EdgeInsets.all(18),
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

                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            seller,
                            style: RoyalTextStyles.caption,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        if (verified)
                          const Icon(
                            Icons.verified,
                            color: RoyalColors.primary,
                            size: 18,
                          ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    Text(
                      "Prix actuel",
                      style: RoyalTextStyles.caption,
                    ),

                    Text(
                      "${currentPrice.toStringAsFixed(0)} FCFA",
                      style: RoyalTextStyles.price,
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "Départ : ${startPrice.toStringAsFixed(0)} FCFA",
                      style: RoyalTextStyles.caption,
                    ),

                    const SizedBox(height: 16),

                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 16,
                          color: RoyalColors.primary,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            city,
                            overflow: TextOverflow.ellipsis,
                            style: RoyalTextStyles.caption,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        _InfoItem(
                          icon: Icons.gavel,
                          value: bids.toString(),
                        ),
                        _InfoItem(
                          icon: Icons.favorite,
                          value: favorites.toString(),
                        ),
                        _InfoItem(
                          icon: Icons.visibility,
                          value: views.toString(),
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

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String value;

  const _InfoItem({
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 17,
          color: RoyalColors.primary,
        ),
        const SizedBox(width: 5),
        Text(
          value,
          style: RoyalTextStyles.caption,
        ),
      ],
    );
  }
}