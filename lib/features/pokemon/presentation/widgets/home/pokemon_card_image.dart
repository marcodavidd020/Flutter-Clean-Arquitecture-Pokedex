
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';

class PokemonCardImage extends StatelessWidget {
  final String imageUrl;
  final int id;

  const PokemonCardImage({super.key, required this.imageUrl, required this.id});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 10,
      top: -25,
      child: Hero(
        tag: 'pokemon-detail-${id}',
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: 127,
          height: 127,
          placeholder: (context, url) => _buildImagePlaceholder(),
          errorWidget:
              (context, url, error) =>
                  const Icon(Icons.error, size: 60, color: Colors.red),
        ),
      ),
    );
  }

  // Método para construir el placeholder de imagen con animación
  Widget _buildImagePlaceholder() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Pokeball de fondo con animación
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(milliseconds: 1500),
          builder: (context, value, child) {
            return Transform.rotate(angle: value * 2 * pi, child: child);
          },
          child: Opacity(
            opacity: 0.7,
            child: Image.asset(
              AppTexts.pokeballImage,
              width: 80,
              height: 80,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        ),

        // Efecto de brillo/pulso
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.5, end: 1.0),
          duration: const Duration(milliseconds: 800),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Container(
                width: 50,
                height: 50,
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
