import 'package:flutter/material.dart';
import 'package:pokedex_application/core/utils/string_utils.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';
import 'package:pokedex_application/core/widgets/pokemon_type_chip.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/detail/body/pokemon_section_title.dart';

class PokemonHeaderInfo extends StatelessWidget {
  const PokemonHeaderInfo({
    super.key,
    required this.pokemon,
    required this.textColor,
  });

  final Pokemon pokemon;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 215,
      bottom: 135,
      // right: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Número de Pokémon
          PokemonSectionTitle(
            title: '#${pokemon.id.toString().padLeft(3, '0')}',
            color: textColor.withOpacity(
              PokemonDetailConstants.pokemonNumberOpacity,
            ),
            fontSize: PokemonDetailConstants.pokemonNumberFontSize,
          ),

          // Nombre del Pokémon
          PokemonSectionTitle(
            title: pokemon.name.capitalize(),
            color: Colors.white,
            fontSize: PokemonDetailConstants.pokemonNameFontSize,
          ),

          SizedBox(height: PokemonDetailConstants.itemSpacing),

          // Tipos de Pokémon
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                pokemon.types
                    .map((type) => PokemonTypeChip(type: type, fontSize: 9))
                    .toList(),
          ),
        ],
      ),
    );
  }
}
