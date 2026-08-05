import 'package:flutter/material.dart';
import '../theme/royal_colors.dart';
import '../theme/royal_text_styles.dart';

class RoyalLoading extends StatelessWidget {
  final double? size;

  const RoyalLoading({Key? key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double s = size ?? 36.0;
    return Center(
      child: SizedBox(
        width: s,
        height: s,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(RoyalColors.primary),
          strokeWidth: 3.0,
        ),
      ),
    );
  }
}
