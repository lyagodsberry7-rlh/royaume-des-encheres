import 'package:flutter/material.dart';
import '../theme/royal_text_styles.dart';
import '../theme/royal_spacing.dart';

class RoyalSectionTitle extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const RoyalSectionTitle({Key? key, required this.title, this.trailing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: RoyalSpacing.sm(context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: RoyalTextStyles.h3(context)),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
