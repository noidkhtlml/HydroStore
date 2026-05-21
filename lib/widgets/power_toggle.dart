import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PowerToggle extends StatelessWidget {
  final bool active;
  final ValueChanged<bool> onChanged;

  const PowerToggle({
    super.key,
    required this.active,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          active ? "Activ" : "Oprit",
          style: GoogleFonts.dmSans(
            color: active
                ? const Color(0xFF0F6E56)
                : Colors.grey.shade600,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () => onChanged(!active),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: 56,
            height: 30,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: active
                  ? const Color(0xFF1D9E75)
                  : Colors.grey.shade400,
            ),
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              alignment:
              active ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 22,
                height: 22,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}