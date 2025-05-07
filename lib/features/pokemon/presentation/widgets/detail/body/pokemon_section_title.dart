import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';

/// Widget para mostrar títulos de sección en la página de detalle del Pokémon
class PokemonSectionTitle extends StatelessWidget {
  final String title;
  final Color color;
  final double fontSize;

  const PokemonSectionTitle({
    super.key,
    required this.title,
    this.color = Colors.black87,
    this.fontSize = PokemonDetailConstants.sectionTitleFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}
