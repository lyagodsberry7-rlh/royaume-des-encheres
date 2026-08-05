import 'dart:io';

import 'package:flutter/material.dart';

class KycImagePicker extends StatelessWidget {
  final String titre;
  final String description;
  final File? image;
  final VoidCallback onTap;

  const KycImagePicker({
    super.key,
    required this.titre,
    required this.description,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: image == null
                ? Colors.grey.shade300
                : const Color(0xFFD4AF37),
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Text(
              titre,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 18),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: image == null
                  ? Container(
                      key: const ValueKey("placeholder"),
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add_a_photo_outlined,
                          size: 60,
                          color: Color(0xFFD4AF37),
                        ),
                      ),
                    )
                  : ClipRRect(
                      key: const ValueKey("image"),
                      borderRadius: BorderRadius.circular(14),
                      child: Image.file(
                        image!,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onTap,
                icon: Icon(
                  image == null
                      ? Icons.photo_camera_outlined
                      : Icons.edit_outlined,
                ),
                label: Text(
                  image == null
                      ? "Choisir une photo"
                      : "Modifier la photo",
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4AF37),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 46),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}