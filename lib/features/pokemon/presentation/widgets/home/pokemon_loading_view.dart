import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';

/// Constantes utilizadas en los componentes de carga
class _LoadingConstants {
  static const double borderRadius = 20.0;
  static const double spacing = 16.0;
  static const double paddingDefault = 16.0;
  static const int gridItemCount = 6;
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
              crossAxisCount: 1,
              childAspectRatio: 2.5, // Ajustado para tarjetas horizontales
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
              const Color(
                0xFFFD7D24,
              ), // Color principal de tipo Fire según Figma
              const Color(
                0xFFFFA756,
              ), // Color de fondo de tipo Fire según Figma
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
                "Pokédex",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2.0,
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
        padding: const EdgeInsets.all(_LoadingConstants.paddingDefault),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                _LoadingConstants.borderRadius,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Placeholder para cada tarjeta de Pokémon en la cuadrícula
class _PokemonCardPlaceholder extends StatefulWidget {
  const _PokemonCardPlaceholder();

  @override
  State<_PokemonCardPlaceholder> createState() =>
      _PokemonCardPlaceholderState();
}

class _PokemonCardPlaceholderState extends State<_PokemonCardPlaceholder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Generar un color aleatorio para simular tipos diferentes
    final List<Color> typeColors = [
      const Color(0xFF8BBE8A), // Grass
      const Color(0xFFFFA756), // Fire
      const Color(0xFF58ABF6), // Water
      const Color(0xFFF2CB55), // Electric
      const Color(0xFF9F6E97), // Poison
    ];

    final typeColor =
        typeColors[DateTime.now().millisecond % typeColors.length];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_LoadingConstants.borderRadius),
        boxShadow: [
          BoxShadow(
            color: typeColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Fondo con color de tipo
          Container(
            height: 130, // Ajustada para coincidir con las tarjetas reales
            decoration: BoxDecoration(
              color: typeColor.withOpacity(0.8),
              borderRadius: BorderRadius.circular(
                _LoadingConstants.borderRadius,
              ),
            ),
            child: Shimmer.fromColors(
              baseColor: typeColor,
              highlightColor: Colors.white.withOpacity(0.5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    _LoadingConstants.borderRadius,
                  ),
                ),
              ),
            ),
          ),

          // Contenido de la tarjeta con shimmer
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Número y tipo
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Número de Pokémon
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 30,
                        height: _LoadingConstants.cardInfoSmallTextHeight,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                // Nombre del Pokémon
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 100,
                    height: _LoadingConstants.cardInfoTextHeight + 4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Tipos de Pokémon
                Row(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 60,
                        height: 25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
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
              ],
            ),
          ),

          // Imagen animada de Pokémon
          Positioned(
            right: 10,
            top: -25, // Ajustada para que sobresalga como en la tarjeta real
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, 5 * _controller.value),
                  child: child,
                );
              },
              child: Container(
                width: 127, // Mismas dimensiones que en PokemonCard
                height: 127,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    AppTexts.pokeballImage,
                    width: 90,
                    height: 90,
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
