import 'package:flutter/material.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';
import 'package:pokedex_application/core/widgets/circular_matrix.dart';
class PokemonHeaderDecorationPattern extends StatelessWidget {
  const PokemonHeaderDecorationPattern({
    super.key,
    required this.dominantColor,
  });

  final Color dominantColor;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: -30,
      // top: 90,
      bottom: 50,
      child: CircularMatrix(
        rows: 4,
        columns: 6,
        size: 6,
        spaceBetween: 12,
        color: Colors.white.withOpacity(
          PokemonDetailConstants.backgroundPatternOpacity,
        ),
      ),
    );
  }
}

