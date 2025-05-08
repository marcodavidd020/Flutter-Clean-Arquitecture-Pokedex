
import 'package:flutter/material.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';

class PokemonCardPokeball extends StatelessWidget {
  const PokemonCardPokeball({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: PokemonCardConstants.positionPokeballRight,
      bottom: PokemonCardConstants.positionPokeballBottom,
      child: ShaderMask(
        shaderCallback:
            (bounds) => LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                PokemonCardConstants.pokeballColor.withOpacity(
                  PokemonCardConstants.positionPokeballOpacity,
                ),
                PokemonCardConstants.pokeballColor.withOpacity(
                  PokemonCardConstants
                      .positionPokeballGradientOpacity,
                ),
              ],
            ).createShader(bounds),
        blendMode: BlendMode.dstIn,
        child: Image.asset(
          AppTexts.pokeballImage,
          width: PokemonCardConstants.pokeballSize,
          height: PokemonCardConstants.pokeballSize,
          fit: BoxFit.cover,
          color: PokemonCardConstants.pokeballColor,
          colorBlendMode: BlendMode.srcIn,
        ),
      ),
    );
  }
}
