import 'package:flutter/material.dart';

class RoyalColors {
  RoyalColors._();

  // ==========================
  // COULEURS PRINCIPALES
  // ==========================

  static const Color background = Color(0xFF0B0817);
  static const Color surface = Color(0xFF151126);
  static const Color card = Color(0xFF1B1630);

  // ==========================
  // COULEURS PRIMAIRES
  // ==========================

  static const Color primary = Color(0xFF8A2EFF);
  static const Color primaryLight = Color(0xFFB56BFF);
  static const Color primaryDark = Color(0xFF6517D2);

  // ==========================
  // OR
  // ==========================

  static const Color gold = Color(0xFFFFC107);
  static const Color goldLight = Color(0xFFFFD54F);

  // ==========================
  // TEXTE
  // ==========================

  static const Color text = Colors.white;
  static const Color textSecondary = Color(0xFFB9B8C5);
  static const Color textHint = Color(0xFF7B7890);

  // ==========================
  // BORDURES
  // ==========================

  static const Color border = Color(0xFF2A2145);

  // ==========================
  // ETATS
  // ==========================

  static const Color success = Color(0xFF2ECC71);
  static const Color warning = Color(0xFFFFB300);
  static const Color error = Color(0xFFE53935);
  static const Color info = Color(0xFF42A5F5);

  // ==========================
  // BADGES
  // ==========================

  static const Color badge = Color(0xFFFF5252);
  static const Color online = Color(0xFF00E676);

  // ==========================
  // OMBRES
  // ==========================

  static const Color shadow = Color(0x55000000);

  // ==========================
  // DEGRADES
  // ==========================

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      primary,
      primaryLight,
    ],
  );

  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      gold,
      goldLight,
    ],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF0B0817),
      Color(0xFF120C22),
    ],
  );
}