import 'package:flutter/material.dart';

import '../theme/colors/royal_colors.dart';
import '../widgets/royal_bottom_navigation.dart';

import 'add_article_page.dart';
import 'favoris_page.dart';
import 'home_page.dart';
import 'notifications_page.dart';
import 'profil_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = const [
      HomePage(),
      FavorisPage(),
      AddArticlePage(),
      NotificationsPage(),
      ProfilPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RoyalColors.background,

      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),

      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            12,
            0,
            12,
            12,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: RoyalBottomNavigation(
              currentIndex: _currentIndex,
              onTap: (index) {
                if (index == _currentIndex) return;

                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}