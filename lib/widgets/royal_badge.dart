import 'package:flutter/material.dart';
import '../theme/royal_colors.dart';

class RoyalBadge extends StatelessWidget {
  final Widget child;
  final String value;
  final Color? color;

  const RoyalBadge({Key? key, required this.child, required this.value, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          right: -6,
          top: -6,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color ?? RoyalColors.secondary,
              borderRadius: BorderRadius.circular(999),
              boxShadow: [BoxShadow(color: RoyalColors.black.withOpacity(0.35), blurRadius: 6)],
            ),
            child: Text(value, style: TextStyle(color: RoyalColors.black, fontSize: 12)),
          ),
        ),
      ],
    );
  }
}
