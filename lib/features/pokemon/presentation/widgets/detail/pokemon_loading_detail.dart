import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';

/// Widget para mostrar una vista de carga para la página de detalle del Pokémon
class PokemonLoadingDetail extends StatelessWidget {
  final String pokemonId;

  const PokemonLoadingDetail({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokemonId.png';

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildLoadingAppBar(imageUrl),
          _buildLoadingInfoSection(),
          _buildLoadingStatsSection(),
          _buildLoadingEvolutionSection(),
        ],
      ),
    );
  }

  Widget _buildLoadingAppBar(String imageUrl) {
    return SliverAppBar(
      expandedHeight: PokemonDetailConstants.appBarHeight,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.grey.shade200,
      leading: _buildBackButton(),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Fondo con degradado
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.grey.shade300, Colors.grey.shade200],
                ),
              ),
            ),

            // Patrón decorativo
            Positioned(right: 10, top: 90, child: _buildCirclePattern()),

            // Pokeball de fondo
            Positioned(
              right: -50,
              bottom: -20,
              child: Opacity(
                opacity: 0.1,
                child: Image.asset(
                  AppTexts.pokeballImage,
                  width: 200,
                  height: 200,
                  errorBuilder: (_, __, ___) => const SizedBox(),
                ),
              ),
            ),

            // Información shimmer
            Positioned(
              left: 24,
              top: 100,
              right: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Número de Pokémon
                  _buildShimmerBox(width: 40, height: 16),

                  const SizedBox(height: 8),

                  // Nombre del Pokémon
                  _buildShimmerBox(width: 150, height: 40),

                  const SizedBox(height: 16),

                  // Tipos de Pokémon
                  Row(
                    children: [
                      _buildShimmerBox(width: 80, height: 30, borderRadius: 15),
                      const SizedBox(width: 8),
                      _buildShimmerBox(width: 80, height: 30, borderRadius: 15),
                    ],
                  ),
                ],
              ),
            ),

            // Imagen del Pokémon
            Positioned(
              right: 10,
              bottom: 20,
              child: Hero(
                tag: 'pokemon-detail-$pokemonId',
                child: Image.network(
                  imageUrl,
                  height: PokemonDetailConstants.pokemonImageSize,
                  width: PokemonDetailConstants.pokemonImageSize,
                  fit: BoxFit.contain,
                  errorBuilder:
                      (_, __, ___) => Container(
                        height: PokemonDetailConstants.pokemonImageSize,
                        width: PokemonDetailConstants.pokemonImageSize,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.catching_pokemon,
                          size: 80,
                          color: Colors.grey.shade400,
                        ),
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.white.withOpacity(0.9),
        elevation: 4,
        shadowColor: Colors.black26,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: () => Navigator.of(navigatorKey.currentContext!).pop(),
          customBorder: const CircleBorder(),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.arrow_back, color: Colors.black87, size: 20),
          ),
        ),
      ),
    );
  }

  Widget _buildCirclePattern() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: List.generate(
        24,
        (index) => Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingInfoSection() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(PokemonDetailConstants.sectionSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título de sección
            _buildShimmerBox(width: 180, height: 24),

            const SizedBox(height: 16),

            // Tarjetas de información
            Row(
              children: [
                Expanded(child: _buildInfoCardShimmer()),
                const SizedBox(width: 10),
                Expanded(child: _buildInfoCardShimmer()),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(child: _buildInfoCardShimmer()),
                const SizedBox(width: 10),
                Expanded(child: _buildInfoCardShimmer()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCardShimmer() {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildShimmerCircle(size: 18),
              const SizedBox(width: 8),
              _buildShimmerBox(width: 60, height: 14),
            ],
          ),
          const Spacer(),
          _buildShimmerBox(width: 80, height: 16),
        ],
      ),
    );
  }

  Widget _buildLoadingStatsSection() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título de sección
            _buildShimmerBox(width: 120, height: 24),

            const SizedBox(height: 16),

            // Barras de estadísticas
            ...List.generate(
              6,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            _buildShimmerCircle(size: 24),
                            const SizedBox(width: 8),
                            _buildShimmerBox(
                              width: 80 + (index * 10),
                              height: 14,
                            ),
                          ],
                        ),
                        _buildShimmerBox(
                          width: 40,
                          height: 24,
                          borderRadius: 10,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _buildShimmerBox(
                      width: double.infinity,
                      height: 10,
                      borderRadius: 5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingEvolutionSection() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título de sección
            _buildShimmerBox(width: 160, height: 24),

            const SizedBox(height: 16),

            // Placeholder para cadena evolutiva
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: const CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerBox({
    required double width,
    required double height,
    double borderRadius = 8.0,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }

  Widget _buildShimmerCircle({required double size}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

// Llave global para el navegador
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
