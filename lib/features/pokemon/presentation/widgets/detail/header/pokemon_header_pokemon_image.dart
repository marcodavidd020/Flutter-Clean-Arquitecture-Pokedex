import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';
import 'package:pokedex_application/core/widgets/gradient_circle.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/detail/pokemon_image_placeholder.dart';

class PokemonHeaderPokemonImage extends StatelessWidget {
  const PokemonHeaderPokemonImage({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 280,
      bottom: 115,
      child: Hero(
        tag: 'pokemon-detail-${pokemon.id}',
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Círculo gradiente de fondo
            SizedBox(
              width: PokemonDetailConstants.pokemonImageSize,
              height: PokemonDetailConstants.pokemonImageSize,
              child: CustomPaint(painter: GradientCircle()),
            ),

            // Imagen del Pokémon
            CachedNetworkImage(
              imageUrl: pokemon.imageUrl,
              height: PokemonDetailConstants.pokemonImageSize,
              width: PokemonDetailConstants.pokemonImageSize,
              fit: BoxFit.contain,
              placeholder: (context, url) => const PokemonImagePlaceholder(),
              errorWidget:
                  (context, url, error) => const Icon(
                    Icons.broken_image,
                    size: 80,
                    color: Colors.white70,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

