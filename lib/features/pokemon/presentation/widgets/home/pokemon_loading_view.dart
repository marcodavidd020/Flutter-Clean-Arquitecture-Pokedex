import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';

/// Constantes utilizadas en los componentes de carga
class _LoadingConstants {
  static const double spacing = 16.0;
}

/// Widget de carga centralizado con animación o indicador circular
class PokemonLoadingView extends StatelessWidget {
  final bool useLottie;

  const PokemonLoadingView({super.key, this.useLottie = true});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (useLottie)
            const _PokemonLoadingAnimation()
          else
            const CircularProgressIndicator(),
          const SizedBox(height: _LoadingConstants.spacing),
          const _ShimmerText(
            text: AppTexts.loadingText,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

/// Animación de carga con imagen de Pokeball
class _PokemonLoadingAnimation extends StatelessWidget {
  const _PokemonLoadingAnimation();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        // color: Colors.white.withOpacity(0.1),
        color: Colors.white.withAlpha(128),
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Image(
          image: AssetImage(PokemonImages.pokeballImage),
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}

/// Texto con efecto Shimmer para pantallas de carga
class _ShimmerText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const _ShimmerText({required this.text, required this.style});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Text(text, style: style),
    );
  }
}
