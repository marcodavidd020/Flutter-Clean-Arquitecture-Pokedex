import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';
import 'package:shimmer/shimmer.dart';

class _LoadingConstants {
  static const double borderRadius = 20.0;
  static const int gridItemCount = 6;
  static const double cardInfoTextHeight = 12.0;
  static const double cardInfoSmallTextHeight = 8.0;
}

/// Vista de carga para la cuadrícula de Pokémon
class PokemonGridLoadingView extends StatelessWidget {
  const PokemonGridLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: PresentationConstants.paddingXLarge,
      ),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(height: PresentationConstants.paddingXXLarge),
          ),
          const _LoadingAppBar(),
          const _LoadingSearchBar(),
          const SliverToBoxAdapter(
            child: SizedBox(height: PresentationConstants.paddingXLarge),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: PokemonCardConstants.cardCrossAxisCount,
              childAspectRatio: PokemonCardConstants.cardAspectRatio,
              crossAxisSpacing: PokemonCardConstants.cardCrossAxisSpacing,
              mainAxisSpacing: PokemonCardConstants.cardMainAxisSpacing,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => const _PokemonCardPlaceholder(),
              childCount: _LoadingConstants.gridItemCount,
            ),
          ),
        ],
      ),
    );
  }
}

/// Barra de aplicación para la vista de carga
class _LoadingAppBar extends StatelessWidget {
  const _LoadingAppBar();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Text(
            AppTexts.appTitle,
            style: GoogleFonts.poppins(
              fontSize: InitialContentConstants.titleFontSize,
              fontWeight: InitialContentConstants.titleFontWeight,
              color: InitialContentConstants.titleColor,
            ),
          ),
        ],
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTexts.searchDescription,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 12),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 65,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(_LoadingConstants.borderRadius),
              ),
            ),
          ),
        ],
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
                    PokemonImages.pokeballImage,
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
