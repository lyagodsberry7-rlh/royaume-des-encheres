import 'package:flutter/material.dart';

class RoyalShadows {
  RoyalShadows._();

  static final List<BoxShadow> small = [
    BoxShadow(
      color: Colors.black.withValues(alpha: .15),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];

  static final List<BoxShadow> medium = [
    BoxShadow(
      color: Colors.black.withValues(alpha: .22),
      blurRadius: 16,
      offset: const Offset(0, 8),
    ),
  ];

  static final List<BoxShadow> large = [
    BoxShadow(
      color: Colors.black.withValues(alpha: .30),
      blurRadius: 26,
      offset: const Offset(0, 14),
    ),
  ];

  static final List<BoxShadow> glow = [
    BoxShadow(
      color: const Color(0xFFFFC107).withValues(alpha: .25),
      blurRadius: 20,
      spreadRadius: 1,
    ),
  ];
}