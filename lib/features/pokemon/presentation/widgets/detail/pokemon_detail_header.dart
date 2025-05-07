import 'package:flutter/material.dart';
import 'package:pokedex_application/core/utils/pokemon_type_utils.dart';
import 'package:pokedex_application/core/utils/string_utils.dart';
import 'package:pokedex_application/core/widgets/background_title.dart';
import 'package:pokedex_application/core/widgets/particle_effect_background.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/detail/header/pokemon_header_decoration_pattern.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/detail/header/pokemon_header_pokeball_background.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/detail/header/pokemon_header_pokemon_image.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/detail/header/pokemon_header_info.dart';

class PokemonDetailHeader extends StatelessWidget {
  final BuildContext context;
  final Pokemon pokemon;
  final VoidCallback onBackPressed;
  final VoidCallback? onFavoritePressed;

  const PokemonDetailHeader({
    super.key,
    required this.pokemon,
    required this.onBackPressed,
    required this.context,
    this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    final dominantColor = PokemonTypeUtils.getBackgroundColorForType(
      pokemon.types.first,
    );
    final textColor =
        PokemonTypeUtils.getTextColorForBackground(dominantColor) ==
                Colors.black
            ? Colors.black87
            : Colors.white;

    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [dominantColor, dominantColor.withOpacity(0.8)],
            ),
          ),
        ),
        // ..._buildParticleEffects(),
        ParticleEffectBackground(
          particleCount: ParticleEffectConstants.particleCount,
          particleColor: ParticleEffectConstants.particleColor,
          maxParticleSize: ParticleEffectConstants.particleSize,
          particleOpacity: ParticleEffectConstants.particleOpacity,
          seed: ParticleEffectConstants.particleSeed,
        ),
        // PokemonHeaderBackButton(onBackPressed: onBackPressed, context: context),
        BackgroundTitle(text: pokemon.name.capitalize()),
        PokemonHeaderDecorationPattern(dominantColor: dominantColor),
        const PokemonHeaderPokeballBackground(),
        PokemonHeaderInfo(pokemon: pokemon, textColor: textColor),
        PokemonHeaderPokemonImage(pokemon: pokemon),
      ],
    );
  }

  // // Método para crear efectos de partículas/destellos
  // List<Widget> _buildParticleEffects() {
  //   final random = DateTime.now().millisecondsSinceEpoch;
  //   return List.generate(8, (index) {
  //     final size = (index % 3 + 1) * 4.0;
  //     final offsetX = (random % 300 + index * 40) % 300;
  //     final offsetY = (random % 250 + index * 30) % 250;

  //     return Positioned(
  //       left: offsetX.toDouble(),
  //       top: offsetY.toDouble(),
  //       child: Container(
  //         width: size,
  //         height: size,
  //         decoration: BoxDecoration(
  //           color: Colors.white.withOpacity(0.6),
  //           shape: BoxShape.circle,
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.white.withOpacity(0.3),
  //               blurRadius: 3,
  //               spreadRadius: 2,
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   });
  // }
}
