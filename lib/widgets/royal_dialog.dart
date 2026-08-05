import 'package:flutter/material.dart';
import '../theme/royal_colors.dart';
import '../theme/royal_radius.dart';
import '../theme/royal_text_styles.dart';

Future<T?> showRoyalDialog<T>(BuildContext context, {required Widget child, bool barrierDismissible = true}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (ctx) => Dialog(
      backgroundColor: RoyalColors.surface,
      shape: RoundedRectangleBorder(borderRadius: RoyalRadius.large(ctx)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    ),
  );
}
