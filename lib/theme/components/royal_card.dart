import 'package:flutter/material.dart';

import '../colors/royal_colors.dart';
import '../colors/royal_shadows.dart';
import '../decorations/royal_radius.dart';

class RoyalCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final double margin;

  const RoyalCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.margin = 0,
  });

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      margin: EdgeInsets.all(margin),
      padding: padding ?? const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: RoyalColors.card,
        borderRadius: RoyalRadius.lg,
        boxShadow: RoyalShadows.medium,
        border: Border.all(
          color: RoyalColors.border,
        ),
      ),
      child: child,
    );

    if (onTap == null) return card;

    return InkWell(
      borderRadius: RoyalRadius.lg,
      onTap: onTap,
      child: card,
    );
  }
}