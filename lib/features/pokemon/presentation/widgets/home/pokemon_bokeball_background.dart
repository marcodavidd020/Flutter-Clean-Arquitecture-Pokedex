import 'package:flutter/material.dart';

import '../../constants/presentation_constants.dart';

class PokemonPokeballBackground extends StatelessWidget {
  const PokemonPokeballBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: PresentationConstants.pokeballHomePositionTop,
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              PresentationConstants.pokeballHomeColor.withOpacity(
                PresentationConstants.pokeballHomeGradientOpacityButton,
              ),
              PresentationConstants.pokeballHomeColor.withOpacity(
                PresentationConstants.pokeballHomeGradientOpacity,
              ),
            ],
          ).createShader(bounds);
        },
        child: Opacity(
          opacity: PresentationConstants.pokeballHomeOpacity,
          // Gradiant
          child: Image.asset(
            PokemonImages.pokeballImage,
            width: PresentationConstants.pokeballHomeSize,
            height: PresentationConstants.pokeballHomeSize,
          ),
        ),
      ),
    );
  }
}
