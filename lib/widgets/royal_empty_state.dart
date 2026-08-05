import 'package:flutter/material.dart';
import '../theme/royal_text_styles.dart';
import '../theme/royal_colors.dart';

class RoyalEmptyState extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? illustration;

  const RoyalEmptyState({Key? key, required this.title, this.subtitle, this.illustration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (illustration != null) illustration!,
        SizedBox(height: 12),
        Text(title, style: RoyalTextStyles.h2(context), textAlign: TextAlign.center),
        if (subtitle != null) ...[
          SizedBox(height: 8),
          Text(subtitle!, style: RoyalTextStyles.body(context).copyWith(color: RoyalColors.hint), textAlign: TextAlign.center),
        ]
      ],
    );
  }
}
