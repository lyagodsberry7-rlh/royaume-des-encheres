import 'package:flutter/animation.dart';

class RoyalAnimations {
  RoyalAnimations._();

  static const Duration fast = Duration(milliseconds: 180);
  static const Duration normal = Duration(milliseconds: 360);
  static const Duration slow = Duration(milliseconds: 520);

  static const Curve standardCurve = Curves.easeOutCubic;
  static const Curve subtleCurve = Curves.easeInOut;
}
