import 'package:flutter/material.dart';
import '../theme/royal_colors.dart';
import '../theme/royal_text_styles.dart';
import '../theme/royal_radius.dart';
import '../theme/royal_shadows.dart';

/// RoyalAppBar
/// A Material 3 compatible AppBar styled for the Royal design system.
/// - Uses RoyalColors for palette
/// - Uses RoyalTextStyles for typography
/// - Respects rounded corners and subtle shadows
class RoyalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;
  final double height;

  const RoyalAppBar({
    Key? key,
    required this.title,
    this.leading,
    this.actions,
    this.centerTitle = false,
    this.height = kToolbarHeight + 4,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 0,
      child: Container(
        height: preferredSize.height,
        decoration: BoxDecoration(
          color: RoyalColors.surface,
          boxShadow: RoyalShadows.subtle,
          borderRadius: BorderRadius.vertical(bottom: RoyalRadius.smallRadius),
          border: Border(bottom: BorderSide(color: RoyalColors.primary.withOpacity(0.04))),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SafeArea(
          bottom: false,
          child: Row(
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(
                  title,
                  textAlign: centerTitle ? TextAlign.center : TextAlign.start,
                  style: RoyalTextStyles.h3(context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (actions != null && actions!.isNotEmpty) ...[
                Row(children: actions!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
