import 'package:flutter/material.dart';
import 'dart:math' show pi;
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';

class PokemonHeaderPokeballBackground extends StatefulWidget {
  const PokemonHeaderPokeballBackground({super.key});

  @override
  State<PokemonHeaderPokeballBackground> createState() => _PokemonHeaderPokeballBackgroundState();
}

class _PokemonHeaderPokeballBackgroundState extends State<PokemonHeaderPokeballBackground> 
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 3), // Duración de una rotación completa
      vsync: this,
    )..repeat(); // Repite la animación indefinidamente
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 190,
      bottom: -25,
      child: Opacity(
        opacity: PokemonDetailConstants.pokeballBackgroundOpacity,
        child: SizedBox(
          width: 100,
          height: 100,
          child: RotationTransition(
            turns: _rotationController,
            child: ColorFiltered(
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    transform: GradientRotation((100.84 + 180) * pi / 180),
                    colors: [
                      Colors.white.withOpacity(0.3),
                      Colors.white.withOpacity(0),
                    ],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstIn,
                child: Image.asset(
                  AppTexts.pokeballImage,
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}