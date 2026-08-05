import 'package:flutter/material.dart';

/// RoyalSpacing fournit des tailles réactives pour toute l'application.
/// Ne pas utiliser de constantes de taille "brutes" ailleurs — utilisez RoyalSpacing.
class RoyalSpacing {
  RoyalSpacing._();

  // Base scale is derived from screen width to remain responsive.
  static double _scale(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // design base ~ 390 -> scale factor
    return width / 390.0;
  }

  static double xs(BuildContext context) => 6.0 * _scale(context);
  static double sm(BuildContext context) => 8.0 * _scale(context);
  static double md(BuildContext context) => 12.0 * _scale(context);
  static double lg(BuildContext context) => 16.0 * _scale(context);
  static double xl(BuildContext context) => 20.0 * _scale(context);
  static double xxl(BuildContext context) => 28.0 * _scale(context);

  static EdgeInsets paddingAll(BuildContext context, double value) =>
      EdgeInsets.all(value * _scale(context));

  static EdgeInsets horizontal(BuildContext context, double value) =>
      EdgeInsets.symmetric(horizontal: value * _scale(context));

  static EdgeInsets vertical(BuildContext context, double value) =>
      EdgeInsets.symmetric(vertical: value * _scale(context));
}
