import 'dart:math' show pi, sin;
import 'package:flutter/material.dart';
import 'package:pokedex_application/core/widgets/circular_matrix.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';
import 'package:shimmer/shimmer.dart';

class PokemonBuildLoadingCard extends StatelessWidget {
  const PokemonBuildLoadingCard({
    super.key,
    required AnimationController animationController,
  }) : _animationController = animationController;

  final AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    // Colores aleatorios para las tarjetas
    final List<Color> typeColors = [
      const Color(0xFF8BBE8A), // Grass
      const Color(0xFFFFA756), // Fire
      const Color(0xFF58ABF6), // Water
      const Color(0xFFF2CB55), // Electric
      const Color(0xFF9F6E97), // Poison
    ];

    final colorIndex = DateTime.now().millisecond % typeColors.length;
    final typeColor = typeColors[colorIndex];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          PresentationConstants.borderRadiusLarge,
        ),
        color: typeColor.withOpacity(0.8),
        boxShadow: [
          BoxShadow(
            color: typeColor.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Pokeball de fondo
          Positioned(
            right: -25,
            bottom: -25,
            child: Opacity(
              opacity: 0.2,
              child: Image.asset(
                AppTexts.pokeballImage,
                width: 120,
                height: 120,
                errorBuilder: (_, __, ___) => const SizedBox(),
              ),
            ),
          ),

          // Patrón de puntos
          Positioned(
            left: 110,
            top: 10,
            child: Opacity(
              opacity: 0.3,
              child: CircularMatrix(
                rows: 3,
                columns: 5,
                size: 5,
                spaceBetween: 10,
                color: Colors.white,
              ),
            ),
          ),

          // Shimmer para la información
          Positioned(
            left: 20,
            top: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Número
                Shimmer.fromColors(
                  baseColor: Colors.white.withOpacity(0.5),
                  highlightColor: Colors.white,
                  child: Container(
                    width: 30,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Nombre
                Shimmer.fromColors(
                  baseColor: Colors.white.withOpacity(0.5),
                  highlightColor: Colors.white,
                  child: Container(
                    width: 80,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Tipo
                Shimmer.fromColors(
                  baseColor: Colors.white.withOpacity(0.5),
                  highlightColor: Colors.white,
                  child: Container(
                    width: 60,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Imagen animada
          Positioned(
            right: 10,
            top: -15,
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 5),
              duration: const Duration(seconds: 2),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(
                    0,
                    value * sin(_animationController.value * pi * 2),
                  ),
                  child: child,
                );
              },
              child: Opacity(
                opacity: 0.9,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    AppTexts.pokeballImage,
                    width: 80,
                    height: 80,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
