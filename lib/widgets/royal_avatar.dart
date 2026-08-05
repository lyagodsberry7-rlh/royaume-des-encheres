import 'package:flutter/material.dart';
import '../theme/royal_colors.dart';
import '../theme/royal_radius.dart';
import '../theme/royal_shadows.dart';

class RoyalAvatar extends StatelessWidget {
  final String? imageUrl;
  final double? size;
  final String? initials;

  const RoyalAvatar({Key? key, this.imageUrl, this.size, this.initials}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double s = size ?? (MediaQuery.of(context).size.width * 0.12);
    return Container(
      width: s,
      height: s,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: RoyalShadows.light,
      ),
      child: CircleAvatar(
        radius: s / 2,
        backgroundColor: RoyalColors.surface,
        backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
        child: imageUrl == null ? Text(initials ?? '', style: TextStyle(color: RoyalColors.text)) : null,
      ),
    );
  }
}
