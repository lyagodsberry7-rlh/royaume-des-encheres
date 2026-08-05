import 'package:flutter/material.dart';

class KycTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool readOnly;
  final VoidCallback? onTap;
  final int maxLines;
  final String? Function(String?)? validator;

  const KycTextField({
    super.key,
    required this.label,
    required this.icon,
    required this.controller,
    this.hint,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.onTap,
    this.maxLines = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 8),

          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            readOnly: readOnly,
            onTap: onTap,
            maxLines: maxLines,
            validator: validator,

            decoration: InputDecoration(
              hintText: hint,

              prefixIcon: Icon(
                icon,
                color: const Color(0xFFD4AF37),
              ),

              filled: true,
              fillColor: theme.cardColor,

              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 16,
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                ),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                ),
              ),

              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(14),
                ),
                borderSide: BorderSide(
                  color: Color(0xFFD4AF37),
                  width: 2,
                ),
              ),

              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}