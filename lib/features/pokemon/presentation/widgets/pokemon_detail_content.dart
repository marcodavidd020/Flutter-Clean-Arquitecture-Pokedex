import 'package:flutter/material.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/detail/body/pokemon_detail_basic_information.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/detail/body/pokemon_detail_statistical_section.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/detail/body/pokemon_evolution_section.dart';

class PokemonDetailContent extends StatelessWidget {
  final Pokemon pokemon;
  final Color mainType;
  final Function(Pokemon) onPokemonTap;

  const PokemonDetailContent({
    super.key,
    required this.pokemon,
    required this.mainType,
    required this.onPokemonTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PokemonDetailBasicInformation(pokemon: pokemon, mainType: mainType),

          const SizedBox(height: 10),

          PokemonDetailStatisticalSection(pokemon: pokemon, mainType: mainType),

          const SizedBox(height: 25),

          PokemonEvolutionSection(
            pokemon: pokemon,
            mainType: mainType,
            onPokemonTap: onPokemonTap,
          ),

          // Espacio al final para scroll cómodo
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
