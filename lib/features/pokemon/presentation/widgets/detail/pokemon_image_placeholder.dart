import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';

/// Placeholder animado para mostrar durante la carga de imágenes de Pokémon
class PokemonImagePlaceholder extends StatelessWidget {
  const PokemonImagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Pokeball de fondo con animación de rotación
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: 1),
          duration: PokemonDetailConstants.loadingAnimationDuration,
          builder: (context, value, child) {
            return Transform.rotate(angle: value * 2 * pi, child: child);
          },
          child: Opacity(
            opacity: ImagePlaceholderConstants.pokeballOpacity,
            child: Image.asset(
              AppTexts.pokeballImage,
              width: ImagePlaceholderConstants.pokeballSize,
              height: ImagePlaceholderConstants.pokeballSize,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        ),

        // Efecto de brillo/pulso
        TweenAnimationBuilder<double>(
          tween: Tween<double>(
            begin: ImagePlaceholderConstants.glowInitialOpacity,
            end: ImagePlaceholderConstants.glowFinalOpacity,
          ),
          duration: PokemonDetailConstants.pulseAnimationDuration,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Container(
                width: ImagePlaceholderConstants.glowSize,
                height: ImagePlaceholderConstants.glowSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.white.withOpacity(0.7),
                      Colors.white.withOpacity(0),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
