import 'package:flutter/material.dart';
import 'package:pokedex_application/core/utils/pokemon_type_utils.dart';
import 'package:pokedex_application/core/utils/string_utils.dart';
import 'package:pokedex_application/core/widgets/background_title.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/detail/header/favorite_button.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/detail/header/pokemon_header_back_button.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/detail/header/pokemon_header_decoration_pattern.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/detail/header/pokemon_header_pokeball_background.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/detail/header/pokemon_header_pokemon_image.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/detail/header/pokemon_header_info.dart';

class PokemonDetailHeader extends StatelessWidget {
  final Pokemon pokemon;
  final VoidCallback onBackPressed;
  final VoidCallback? onFavoritePressed;

  const PokemonDetailHeader({
    super.key,
    required this.pokemon,
    required this.onBackPressed,
    this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    final dominantColor = PokemonTypeUtils.getBackgroundColorForType(
      pokemon.types.first,
    );
    final contrastColor = PokemonTypeUtils.getTextColorForBackground(
      dominantColor,
    );
    final textColor =
        contrastColor == Colors.black ? Colors.black87 : Colors.white;

    return SliverAppBar(
      expandedHeight: PokemonDetailConstants.appBarHeight,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: dominantColor,
      leading: PokemonHeaderBackButton(
        onBackPressed: onBackPressed,
        context: context,
        // dominantColor: dominantColor,
      ),
      actions: [
        if (onFavoritePressed != null)
          FavoriteButton(
            onPressed: onFavoritePressed!,
            backgroundColor: Colors.white,
            iconColor: Colors.red,
          ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Fondo con gradiente según el tipo de Pokémon
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [dominantColor, dominantColor.withOpacity(0.8)],
                ),
              ),
            ),

            BackgroundTitle(text: pokemon.name.capitalize()),

            // Patrón decorativo
            PokemonHeaderDecorationPattern(dominantColor: dominantColor),

            // Imagen de Pokeball de fondo
            const PokemonHeaderPokeballBackground(),

            // Información del Pokémon
            PokemonHeaderInfo(pokemon: pokemon, textColor: textColor),

            // Imagen del Pokémon
            PokemonHeaderPokemonImage(pokemon: pokemon),
          ],
        ),
      ),
    );
  }
}
