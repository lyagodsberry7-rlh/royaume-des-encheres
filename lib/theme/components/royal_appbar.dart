import 'package:flutter/material.dart';

import '../colors/royal_colors.dart';
import '../typography/royal_text_styles.dart';

class RoyalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  final List<Widget>? actions;

  final bool centerTitle;

  final Widget? leading;

  const RoyalAppBar({
    super.key,
    required this.title,
    this.actions,
    this.centerTitle = true,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: centerTitle,
      backgroundColor: RoyalColors.background,
      leading: leading,
      iconTheme: const IconThemeData(
        color: RoyalColors.text,
      ),
      title: Text(
        title,
        style: RoyalTextStyles.title,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}