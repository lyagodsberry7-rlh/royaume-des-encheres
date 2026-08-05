import 'package:flutter/material.dart';
import '../theme/royal_colors.dart';
import '../theme/royal_radius.dart';
import '../theme/royal_spacing.dart';
import '../theme/royal_text_styles.dart';

class RoyalSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final VoidCallback? onClear;

  const RoyalSearchBar({Key? key, this.controller, this.hint = 'Rechercher...', this.onClear}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: RoyalColors.surface,
        borderRadius: RoyalRadius.large(context),
      ),
      padding: EdgeInsets.symmetric(horizontal: RoyalSpacing.md(context), vertical: RoyalSpacing.sm(context)),
      child: Row(
        children: [
          Icon(Icons.search, color: RoyalColors.hint),
          SizedBox(width: RoyalSpacing.sm(context)),
          Expanded(
            child: TextField(
              controller: controller,
              style: RoyalTextStyles.body(context),
              decoration: InputDecoration(border: InputBorder.none, hintText: hint, hintStyle: TextStyle(color: RoyalColors.hint)),
            ),
          ),
          if (onClear != null)
            GestureDetector(onTap: onClear, child: Icon(Icons.close, color: RoyalColors.hint)),
        ],
      ),
    );
  }
}
