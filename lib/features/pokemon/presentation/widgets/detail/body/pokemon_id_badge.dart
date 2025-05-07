import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Badge para mostrar el número del Pokémon como en la imagen de referencia
class PokemonIdBadge extends StatelessWidget {
  final int id;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;

  const PokemonIdBadge({
    super.key,
    required this.id,
    this.backgroundColor = Colors.white30,
    this.textColor = Colors.white,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _formatId(id),
        style: GoogleFonts.poppins(
          color: textColor,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _formatId(int id) {
    return '#${id.toString().padLeft(3, '0')}';
  }
}
