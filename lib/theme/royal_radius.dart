import 'package:flutter/material.dart';

/// Rayons arrondis utilisés partout.
class RoyalRadius {
  RoyalRadius._();

  static BorderRadius small(BuildContext context) =>
      BorderRadius.circular(8.0 * (MediaQuery.of(context).size.width / 390.0));

  static BorderRadius medium(BuildContext context) =>
      BorderRadius.circular(14.0 * (MediaQuery.of(context).size.width / 390.0));

  static BorderRadius large(BuildContext context) =>
      BorderRadius.circular(24.0 * (MediaQuery.of(context).size.width / 390.0));

  static BorderRadius pill(BuildContext context) =>
      BorderRadius.circular(999.0);
}
