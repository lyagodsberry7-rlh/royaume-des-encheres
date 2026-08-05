import 'package:flutter/material.dart';
import '../theme/royal_colors.dart';
import '../theme/royal_spacing.dart';
import '../theme/royal_radius.dart';
import '../theme/royal_shadows.dart';

class RoyalCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final VoidCallback? onTap;

  const RoyalCard({Key? key, required this.child, this.padding, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: RoyalColors.cardBackground,
          borderRadius: RoyalRadius.large(context),
          boxShadow: RoyalShadows.subtle,
          border: Border.all(color: RoyalColors.primary.withOpacity(0.06)),
        ),
        padding: padding ?? EdgeInsets.all(RoyalSpacing.md(context)),
        child: child,
      ),
    );
  }
}
