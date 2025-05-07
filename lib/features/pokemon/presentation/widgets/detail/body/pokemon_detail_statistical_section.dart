import 'package:flutter/material.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/detail/body/pokemon_detail_section_card.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/detail/body/pokemon_stats_section.dart';

class PokemonDetailStatisticalSection extends StatelessWidget {
  const PokemonDetailStatisticalSection({
    super.key,
    required this.pokemon,
    required this.mainType,
  });

  final Pokemon pokemon;
  final Color mainType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: PokemonDetailSectionCard(
        mainType: mainType,
        backgroundColor: Colors.white.withOpacity(0.95),
        child: PokemonStatsSection(pokemon: pokemon, typeColor: mainType),
      ),
    );
  }
}
