import 'package:flutter/material.dart';

class KycStepper extends StatelessWidget {
  final int currentStep;

  const KycStepper({
    super.key,
    required this.currentStep,
  });

  Widget _buildStep(
    BuildContext context,
    int step,
    String title,
  ) {
    final bool active = currentStep >= step;

    return Expanded(
      child: Column(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: active
                ? const Color(0xFFD4AF37)
                : Colors.grey.shade300,
            child: active
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 18,
                  )
                : Text(
                    "$step",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),

          const SizedBox(height: 8),

          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: active
                  ? const Color(0xFFD4AF37)
                  : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _line(bool active) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(bottom: 28),
        height: 2,
        color: active
            ? const Color(0xFFD4AF37)
            : Colors.grey.shade300,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 20,
      ),
      child: Row(
        children: [
          _buildStep(
            context,
            1,
            "Informations",
          ),

          _line(currentStep >= 2),

          _buildStep(
            context,
            2,
            "Documents",
          ),

          _line(currentStep >= 3),

          _buildStep(
            context,
            3,
            "Validation",
          ),
        ],
      ),
    );
  }
}