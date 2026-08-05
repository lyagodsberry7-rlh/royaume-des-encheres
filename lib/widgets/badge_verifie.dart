import 'package:flutter/material.dart';

class BadgeVerifie extends StatelessWidget {
  final bool verifie;

  const BadgeVerifie({
    super.key,
    required this.verifie,
  });

  @override
  Widget build(BuildContext context) {

    if (!verifie) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),

      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.green.withValues(alpha: 0.4),
        ),
      ),

      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          Icon(
            Icons.verified,
            color: Colors.green,
            size: 15,
          ),

          SizedBox(width: 4),

          Text(
            "Vérifié",
            style: TextStyle(
              color: Colors.green,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}