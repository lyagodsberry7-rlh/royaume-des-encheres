import 'package:flutter/material.dart';
import '../theme/royal_colors.dart';
import '../theme/royal_radius.dart';
import '../theme/royal_text_styles.dart';

class RoyalChip extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool selected;

  const RoyalChip({Key? key, required this.label, this.onTap, this.selected = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 240),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: selected ? RoyalColors.primary : RoyalColors.surface,
          borderRadius: RoyalRadius.pill(context),
          border: Border.all(color: selected ? RoyalColors.primary : Colors.transparent),
        ),
        child: Text(label, style: RoyalTextStyles.caption(context).copyWith(color: selected ? RoyalColors.text : RoyalColors.hint)),
      ),
    );
  }
}
