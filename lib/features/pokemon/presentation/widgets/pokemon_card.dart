import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex_application/core/utils/pokemon_type_utils.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/pokemon_type_chip.dart';

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
    final bgColor = PokemonTypeUtils.getColorForType(mainType);

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
        child: Padding(
          padding: EdgeInsets.only(top: PokemonCardConstants.imageOverflow / 2),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  bgColor,
                  bgColor.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(PokemonCardConstants.borderRadius),
              boxShadow: [
                // Sombra externa principal
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
                // Sombra del color del tipo para efecto de brillo
                BoxShadow(
                  color: bgColor.withOpacity(0.6),
                  spreadRadius: -2,
                  blurRadius: 12,
                  offset: const Offset(0, 2),
                ),
                // Sombra interna simulada (resplandor)
                BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  spreadRadius: -3,
                  blurRadius: 5,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 200,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: PokemonCardConstants.padding,
                      left: PokemonCardConstants.padding,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _PokemonIdBadge(id: widget.id),
                        _PokemonInfoSection(
                          name: widget.name,
                          types: widget.types,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: Column(
                    children: [
                      _PokemonImageSection(
                        id: widget.id,
                        imageUrl: widget.imageUrl,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Widget para mostrar el ID del Pokémon en la esquina superior izquierda
class _PokemonIdBadge extends StatelessWidget {
  final int id;

  const _PokemonIdBadge({required this.id});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: PresentationConstants.paddingMedium, 
          vertical: PresentationConstants.paddingSmall
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(PresentationConstants.opacityMedium),
          borderRadius: BorderRadius.circular(PresentationConstants.borderRadiusSmall),
        ),
        child: Text(
          '#${id.toString().padLeft(3, '0')}',
          style: GoogleFonts.barlowCondensed(
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: PokemonCardConstants.idFontSize,
            ),
          ),
        ),
      ),
    );
  }
}

/// Sección que muestra la imagen del Pokémon con efecto Hero y fondo de Pokeball
class _PokemonImageSection extends StatelessWidget {
  final int id;
  final String imageUrl;

  const _PokemonImageSection({required this.id, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Stack(
        clipBehavior: Clip.none, // Permitir que el contenido sobresalga
        fit: StackFit.expand,
        children: [
          _PokeballBackground(),
          Positioned(
            top: -PokemonCardConstants.imageOverflow,
            left: 0,
            right: 0,
            bottom: 0,
            child: _PokemonHeroImage(id: id, imageUrl: imageUrl),
          ),
        ],
      ),
    );
  }
}

/// Fondo de Pokeball para la sección de imagen
class _PokeballBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight, // Mover la Pokeball hacia la derecha
      child: Opacity(
        opacity: PokemonCardConstants.pokeballOpacity,
        child: Transform.scale(
          scale: 1.22,
          child: ColorFiltered(
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
            child: Image.asset(
              AppTexts.pokeballImage,
              errorBuilder: (_, __, ___) => const SizedBox(),
            ),
          ),
        ),
      ),
    );
  }
}

/// Imagen principal del Pokémon con efecto Hero
class _PokemonHeroImage extends StatelessWidget {
  final int id;
  final String imageUrl;

  const _PokemonHeroImage({required this.id, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'pokemon-detail-$id',
      flightShuttleBuilder: (
        BuildContext flightContext,
        Animation<double> animation,
        HeroFlightDirection flightDirection,
        BuildContext fromHeroContext,
        BuildContext toHeroContext,
      ) {
        return Material(
          color: Colors.transparent,
          child: CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.contain),
        );
      },
      child: Material(
        type: MaterialType.transparency,
        child: Transform.scale(
          scale: PokemonCardConstants.imageScale,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.contain,
            placeholder: (context, url) => _ImageLoadingIndicator(),
            errorWidget: (context, url, error) => _ImageErrorWidget(),
          ),
        ),
      ),
    );
  }
}

/// Indicador de carga para la imagen
class _ImageLoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: const Center(
        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black26),
      ),
    );
  }
}

/// Widget mostrado cuando hay error al cargar la imagen
class _ImageErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(Icons.broken_image, size: 50, color: Colors.black26),
    );
  }
}

/// Sección inferior con información del Pokémon
class _PokemonInfoSection extends StatelessWidget {
  final String name;
  final List<String>? types;

  const _PokemonInfoSection({required this.name, this.types});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PokemonName(name: name),
        const SizedBox(height: PokemonCardConstants.smallSpacing),
        if (types != null && types!.isNotEmpty)
          _PokemonTypesList(types: types!),
      ],
    );
  }
}

/// Widget para mostrar el nombre del Pokémon
class _PokemonName extends StatelessWidget {
  final String name;

  const _PokemonName({required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name.toUpperCase(),
      style: GoogleFonts.barlowCondensed(
        textStyle: const TextStyle(
          color: Color.fromARGB(221, 255, 255, 255),
          fontWeight: FontWeight.w600,
          fontSize: PokemonCardConstants.nameFontSize,
        ),
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

/// Widget para mostrar la lista de tipos del Pokémon
class _PokemonTypesList extends StatelessWidget {
  final List<String> types;

  const _PokemonTypesList({required this.types});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            types
                .map(
                  (type) => Padding(
                    padding: const EdgeInsets.only(
                      right: PokemonCardConstants.smallSpacing,
                    ),
                    child: PokemonTypeChip(type: type, small: true),
                  ),
                )
                .toList(),
      ),
    );
  }
}
