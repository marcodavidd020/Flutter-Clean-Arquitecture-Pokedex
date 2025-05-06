import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:pokedex_application/core/constants/app_constants.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';
/// Constantes utilizadas en los componentes de carga
class _LoadingConstants {
  static const double borderRadius = 20.0;
  static const double spacing = 16.0;
  static const double smallSpacing = 8.0;
  static const double paddingDefault = 16.0;
  static const int gridItemCount = 6;
  static const double shimmerTextHeight = 10.0;
  static const double cardInfoTextHeight = 12.0;
  static const double cardInfoSmallTextHeight = 8.0;
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
          image: AssetImage(AppTexts.pokeballImage),
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

/// Vista de carga para la cuadrícula de Pokémon
class PokemonGridLoadingView extends StatelessWidget {
  const PokemonGridLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const _LoadingAppBar(),
        const _LoadingSearchBar(),
        SliverPadding(
          padding: const EdgeInsets.all(_LoadingConstants.paddingDefault),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: _LoadingConstants.spacing,
              mainAxisSpacing: _LoadingConstants.spacing,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => const _PokemonCardPlaceholder(),
              childCount: _LoadingConstants.gridItemCount,
            ),
          ),
        ),
      ],
    );
  }
}

/// Barra de aplicación para la vista de carga
class _LoadingAppBar extends StatelessWidget {
  const _LoadingAppBar();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primaryContainer,
            ],
          ),
        ),
        child: Stack(
          children: [
            const Positioned(
              right: -20,
              top: -20,
              child: Opacity(
                opacity: 0.2,
                child: Image(
                  image: AssetImage(AppTexts.pokeballImage),
                  width: 150,
                  height: 150,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 48, 24, 8),
              child: Text(
                AppConstants.appName,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Barra de búsqueda para la vista de carga
class _LoadingSearchBar extends StatelessWidget {
  const _LoadingSearchBar();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: _LoadingConstants.shimmerTextHeight,
                width: 200,
                color: Colors.white,
              ),
              const SizedBox(height: 12),
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    _LoadingConstants.borderRadius - 4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Placeholder para cada tarjeta de Pokémon en la cuadrícula
class _PokemonCardPlaceholder extends StatelessWidget {
  const _PokemonCardPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(_LoadingConstants.borderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            _PokemonImagePlaceholder(),
            _PokemonInfoPlaceholder(),
          ],
        ),
      ),
    );
  }
}

/// Placeholder para la imagen del Pokémon
class _PokemonImagePlaceholder extends StatelessWidget {
  const _PokemonImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(_LoadingConstants.borderRadius),
            topRight: Radius.circular(_LoadingConstants.borderRadius),
          ),
        ),
        child: Stack(
          children: const [
            Positioned(right: -25, bottom: -25, child: _PokeballBackground()),
          ],
        ),
      ),
    );
  }
}

/// Fondo de Pokeball para el placeholder de imagen
class _PokeballBackground extends StatelessWidget {
  const _PokeballBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: const BoxDecoration(
        color: Colors.white24,
        shape: BoxShape.circle,
      ),
    );
  }
}

/// Placeholder para la información del Pokémon
class _PokemonInfoPlaceholder extends StatelessWidget {
  const _PokemonInfoPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(_LoadingConstants.borderRadius),
            bottomRight: Radius.circular(_LoadingConstants.borderRadius),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: _LoadingConstants.cardInfoTextHeight,
              width: 100,
              color: Colors.grey[300],
            ),
            const SizedBox(height: _LoadingConstants.smallSpacing),
            Container(
              height: _LoadingConstants.cardInfoSmallTextHeight,
              width: 80,
              color: Colors.grey[300],
            ),
          ],
        ),
      ),
    );
  }
}
