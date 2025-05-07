import 'package:flutter/material.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/detail/body/pokemon_section_title.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/detail/body/pokemon_stat_row.dart';

/// Widget para mostrar la sección de estadísticas del Pokémon
class PokemonStatsSection extends StatelessWidget {
  final Pokemon pokemon;
  final Color typeColor;

  const PokemonStatsSection({super.key, required this.pokemon, required this.typeColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        PokemonDetailConstants.sectionSpacing,
        0,
        PokemonDetailConstants.sectionSpacing,
        PokemonDetailConstants.sectionSpacing,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PokemonSectionTitle(title: AppTexts.statsTitle, color: typeColor),

          ...pokemon.stats.map((stat) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: PokemonStatRow(stat: stat),
            );
          }),
        ],
      ),
    );
  }
}
