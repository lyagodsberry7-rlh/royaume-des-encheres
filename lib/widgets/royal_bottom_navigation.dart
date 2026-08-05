import 'package:flutter/material.dart';
import '../theme/royal_colors.dart';
import '../theme/royal_text_styles.dart';
import '../theme/royal_radius.dart';

class RoyalBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const RoyalBottomNavigation({Key? key, required this.currentIndex, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: RoyalColors.surface, boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)]),
      child: SafeArea(
        top: false,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          backgroundColor: RoyalColors.surface,
          selectedItemColor: RoyalColors.primary,
          unselectedItemColor: RoyalColors.hint,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
            BottomNavigationBarItem(icon: Icon(Icons.gavel), label: 'Enchères'),
            BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: 'Vendre'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favoris'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profil'),
          ],
        ),
      ),
    );
  }
}
