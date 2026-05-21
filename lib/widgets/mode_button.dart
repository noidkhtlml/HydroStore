import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModeButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool active;
  final Color color;
  final VoidCallback onTap;

  const ModeButton({
    super.key,
    required this.text,
    required this.icon,
    required this.active,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: active
                ? color.withOpacity(0.15)
                : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: active ? color : Colors.grey.shade300,
            ),
          ),
          child: Column(
            children: [
              Icon(icon,
                  color: active ? color : Colors.grey.shade600),
              const SizedBox(height: 4),
              Text(
                text,
                textAlign: TextAlign.center,
                style: GoogleFonts.dmSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: active ? color : Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}