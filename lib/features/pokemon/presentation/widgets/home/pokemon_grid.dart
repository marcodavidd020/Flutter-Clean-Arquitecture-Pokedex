
import 'package:flutter/material.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/home/pokemon_build_loading_card.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/home/pokemon_card.dart';

class PokemonGrid extends StatelessWidget {
  final List<Pokemon> pokemons;
  final bool isLoadingMore;
  final AnimationController animationController;
  final Function(Pokemon) onPokemonTap;

  const PokemonGrid({
    super.key,
    required this.pokemons,
    required this.isLoadingMore,
    required this.animationController,
    required this.onPokemonTap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index) {
        if (index >= pokemons.length) {
          return PokemonBuildLoadingCard(
            animationController: animationController,
          );
        }

        final pokemon = pokemons[index];

        return PokemonCard(
          id: pokemon.id,
          name: pokemon.name,
          imageUrl: pokemon.imageUrl,
          types: pokemon.types,
          onTap: () => onPokemonTap(pokemon),
        );
      }, childCount: isLoadingMore ? pokemons.length + 2 : pokemons.length),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: PokemonCardConstants.cardCrossAxisCount,
        childAspectRatio: PokemonCardConstants.cardAspectRatio,
        crossAxisSpacing: PokemonCardConstants.cardCrossAxisSpacing,
        mainAxisSpacing: PokemonCardConstants.cardMainAxisSpacing,
      ),
    );
  }
}
