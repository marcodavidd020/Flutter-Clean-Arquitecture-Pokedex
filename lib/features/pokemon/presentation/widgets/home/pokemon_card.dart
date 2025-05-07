import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex_application/core/utils/pokemon_type_utils.dart';
import 'package:pokedex_application/core/utils/string_utils.dart';
import 'package:pokedex_application/core/widgets/circular_matrix.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';

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
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _getPokemonType(int id) {
    // Si tenemos tipos reales, usar el primero
    if (widget.types != null && widget.types!.isNotEmpty) {
      return widget.types!.first;
    }

    // De lo contrario, asignar tipo basado en el id (esto es para retrocompatibilidad)
    if (id <= 10) return 'grass'; // Bulbasaur line
    if (id <= 20) return 'fire'; // Charmander line
    if (id <= 30) return 'water'; // Squirtle line
    if (id <= 40) return 'bug'; // Early bug types
    if (id <= 50) return 'normal'; // Early normal types
    if (id <= 60) return 'poison'; // Early poison types
    if (id <= 70) return 'electric'; // Electric types
    if (id <= 80) return 'ground'; // Ground types
    if (id <= 90) return 'fairy'; // Fairy types
    if (id <= 100) return 'fighting'; // Fighting types
    if (id <= 110) return 'psychic'; // Psychic types
    if (id <= 120) return 'rock'; // Rock types
    if (id <= 130) return 'ice'; // Ice types
    if (id % 5 == 0) return 'dragon'; // Some dragon types
    if (id % 7 == 0) return 'ghost'; // Some ghost types
    if (id % 11 == 0) return 'dark'; // Some dark types
    if (id % 13 == 0) return 'steel'; // Some steel types

    // Ciclo de tipos basado en el módulo para el resto
    int typeIndex = id % 7;
    switch (typeIndex) {
      case 0:
        return 'fire';
      case 1:
        return 'water';
      case 2:
        return 'grass';
      case 3:
        return 'electric';
      case 4:
        return 'psychic';
      case 5:
        return 'rock';
      case 6:
        return 'normal';
      default:
        return 'normal';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Obtener el tipo principal basado en el id o en los tipos proporcionados
    final String mainType = _getPokemonType(widget.id);
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
        child: Container(
          height: 130,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Sombra de fondo
              Positioned(
                top: 20,
                left: 20,
                right: 20,
                child: Container(
                  height: 95,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: bgColor.withOpacity(0.4),
                        spreadRadius: 0,
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                ),
              ),

              // Fondo de color principal
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 115,
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      children: [
                        // Patrón de puntos
                        Positioned(
                          left: 110,
                          top: 5,
                          child: Opacity(
                            opacity: 0.3,
                            child: CircularMatrix(
                              rows: 3,
                              columns: 6,
                              size: 5,
                              spaceBetween: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        // Pokeball de fondo
                        Positioned(
                          right: -10,
                          bottom: -15,
                          child: SizedBox(
                            width: 145,
                            height: 145,
                            child: ShaderMask(
                              shaderCallback:
                                  (bounds) => LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.white.withOpacity(0.3),
                                      Colors.white.withOpacity(0.0),
                                    ],
                                  ).createShader(bounds),
                              blendMode: BlendMode.dstIn,
                              child: Image.asset(
                                AppTexts.pokeballImage,
                                width: 145,
                                height: 145,
                                fit: BoxFit.cover,
                                color: Colors.white,
                                colorBlendMode: BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),

                        // Información del Pokémon
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 16),
                          child: SizedBox(
                            // Limitar altura máxima disponible para el contenido
                            height: 90,
                            child: Column(
                              mainAxisSize:
                                  MainAxisSize
                                      .min, // Usar espacio mínimo necesario
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Número del Pokémon
                                Text(
                                  '#${widget.id.toString().padLeft(3, '0')}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                ),

                                // Nombre del Pokémon
                                Text(
                                  widget.name.capitalize(),
                                  style: GoogleFonts.poppins(
                                    fontSize: 17, // Reducir tamaño de fuente
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  overflow:
                                      TextOverflow
                                          .ellipsis, // Evitar desbordamiento
                                ),

                                const SizedBox(height: 3), // Reducir espacio
                                // Badge de tipo - usar Flexible para que se ajuste al espacio
                                if (widget.types != null &&
                                    widget.types!.isNotEmpty)
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
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 5,
                                                        vertical:
                                                            3, // Reducir padding vertical
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        PokemonTypeUtils.getColorForType(
                                                          type,
                                                        ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          3,
                                                        ),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Imagen del Pokémon
              Positioned(
                right: 10,
                top: -25,
                child: Hero(
                  tag: 'pokemon-detail-${widget.id}',
                  child: CachedNetworkImage(
                    imageUrl: widget.imageUrl,
                    width: 127,
                    height: 127,
                    placeholder: (context, url) => _buildImagePlaceholder(),
                    errorWidget:
                        (context, url, error) => const Icon(
                          Icons.error,
                          size: 60,
                          color: Colors.red,
                        ),
                  ),
                ),
              ),
            ],
          ),
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
