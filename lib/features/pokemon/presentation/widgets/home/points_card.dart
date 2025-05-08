import 'package:flutter/material.dart';
import 'package:pokedex_application/core/widgets/circular_matrix.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';

class PointsCard extends StatelessWidget {
  const PointsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: PokemonCardConstants.positionPointsLeft,
      top: PokemonCardConstants.positionPointsTop,
      child: Opacity(
        opacity: PokemonCardConstants.opacityPoints,
        child: CircularMatrix(
          rows: PokemonCardConstants.rowsPoints,
          columns: PokemonCardConstants.columnsPoints,
          size: PokemonCardConstants.sizePoints,
          spaceBetween: PokemonCardConstants.spaceBetweenPoints,
          color: PokemonCardConstants.colorPoints,
        ),
      ),
    );
  }
}