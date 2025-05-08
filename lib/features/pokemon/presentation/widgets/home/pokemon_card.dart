import 'dart:math' show pi;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex_application/core/utils/pokemon_type_utils.dart';
import 'package:pokedex_application/core/utils/string_utils.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/home/points_card.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/home/pokemon_card_pokeball.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/home/pokemon_shape_background.dart';

class PokemonCard extends StatefulWidget {
  final int id;
  final String name;
  final String imageUrl;
  final List<String>? types;
  final VoidCallback onTap;

  const PokemonCard({
    super.key,
    required this.id,
    required this.name,
    required this.imageUrl,
    this.types,
    required this.onTap,
  });

  @override
  State<PokemonCard> createState() => _PokemonCardState();
}

class _PokemonCardState extends State<PokemonCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: PresentationConstants.animationShort,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: PokemonCardConstants.animationScaleStart,
      end: PokemonCardConstants.animationScaleEnd,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Obtener el tipo principal basado en el id o en los tipos proporcionados
    final String mainType =
        widget.types != null && widget.types!.isNotEmpty
            ? widget.types!.first
            : PokemonTypeUtils.getPokemonType(widget.id);
    final bgColor = PokemonTypeUtils.getBackgroundColorForType(mainType);

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(scale: _scaleAnimation.value, child: child);
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Sombra de fondo
            ShapeBackground(bgColor: bgColor),

            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(
                  PokemonCardConstants.borderRadius,
                ),
              ),
              child: Stack(
                children: [
                  // Patrón de puntos
                  const PointsCard(),

                  // Pokeball de fondo
                  const PokemonCardPokeball(),

                  // Información del Pokémon
                  Padding(
                    padding: const EdgeInsets.only(
                      left: PokemonCardConstants.informationPaddingLeft,
                      top: PokemonCardConstants.informationPaddingTop,
                    ),
                    child: Column(
                      mainAxisSize:
                          MainAxisSize.min, // Usar espacio mínimo necesario
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Número del Pokémon
                        Text(
                          '#${widget.id.toString().padLeft(3, '0')}',
                          style: GoogleFonts.poppins(
                            fontSize: PokemonCardConstants.numberFontSize,
                            fontWeight: FontWeight.bold,
                            color: PokemonCardConstants.numberColor,
                          ),
                        ),

                        // Nombre del Pokémon
                        Text(
                          widget.name.capitalize(),
                          style: GoogleFonts.poppins(
                            fontSize: PokemonCardConstants.nameFontSize,
                            fontWeight: FontWeight.bold,
                            color: PokemonCardConstants.nameColor,
                          ),
                          overflow:
                              TextOverflow.ellipsis, // Evitar desbordamiento
                        ),

                        const SizedBox(height: 3), // Reducir espacio
                        // Badge de tipo - usar Flexible para que se ajuste al espacio
                        if (widget.types != null && widget.types!.isNotEmpty)
                          Flexible(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Iterar sobre todos los tipos disponibles
                                ...widget.types!
                                    .map(
                                      (type) => Padding(
                                        padding: const EdgeInsets.only(
                                          right: 5,
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                            vertical:
                                                3, // Reducir padding vertical
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                PokemonTypeUtils.getColorForType(
                                                  type,
                                                ),
                                            borderRadius: BorderRadius.circular(
                                              PokemonCardConstants.borderRadiusType,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              _buildTypeIcon(type),
                                              const SizedBox(width: 5),
                                              Text(
                                                type.capitalize(),
                                                style: GoogleFonts.poppins(
                                                  fontSize:
                                                      9, // Reducir tamaño de fuente
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Imagen del Pokémon
            _pokemonImage(widget.imageUrl),
          ],
        ),
      ),
    );
  }

  Widget _pokemonImage(String imageUrl) {
    return Positioned(
      right: 10,
      top: -25,
      child: Hero(
        tag: 'pokemon-detail-${widget.id}',
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

  Widget _buildTypeIcon(String type) {
    // No usar bloque try/catch para que se muestre el SVG
    final iconPath = 'assets/icons/${type.toLowerCase()}.svg';

    return SvgPicture.asset(
      iconPath,
      width: 15,
      height: 15,
      color: Colors.white,
      // Usar un builder para mostrar un icono de respaldo solo si el SVG falla
      placeholderBuilder: (context) {
        // Seleccionar el icono de respaldo apropiado
        IconData iconData = Icons.category;
        switch (type.toLowerCase()) {
          case 'normal':
            iconData = Icons.circle_outlined;
            break;
          case 'fire':
            iconData = Icons.local_fire_department;
            break;
          case 'water':
            iconData = Icons.water_drop;
            break;
          case 'grass':
            iconData = Icons.grass;
            break;
          case 'electric':
            iconData = Icons.bolt;
            break;
          case 'ice':
            iconData = Icons.ac_unit;
            break;
          case 'fighting':
            iconData = Icons.sports_martial_arts;
            break;
          case 'poison':
            iconData = Icons.science;
            break;
          case 'ground':
            iconData = Icons.landscape;
            break;
          case 'flying':
            iconData = Icons.air;
            break;
          case 'psychic':
            iconData = Icons.psychology;
            break;
          case 'bug':
            iconData = Icons.bug_report;
            break;
          case 'rock':
            iconData = Icons.blur_circular;
            break;
          case 'ghost':
            iconData = Icons.visibility_off;
            break;
          case 'dragon':
            iconData = Icons.whatshot;
            break;
          case 'dark':
            iconData = Icons.nights_stay;
            break;
          case 'steel':
            iconData = Icons.shield;
            break;
          case 'fairy':
            iconData = Icons.auto_awesome;
            break;
        }

        return Icon(iconData, size: 15, color: Colors.white);
      },
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
