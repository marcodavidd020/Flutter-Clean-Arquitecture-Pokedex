import 'package:flutter/material.dart';
import 'package:pokedex_application/core/utils/pokemon_type_utils.dart';
import 'package:pokedex_application/core/widgets/box_decoration.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/home/points_card.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/home/pokemon_card_image.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/home/pokemon_card_information.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/home/pokemon_card_pokeball.dart';

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

    final cardBoxDecorationValue = cardBoxDecoration(bgColor);

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
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: cardBoxDecorationValue,

              child: Stack(
                children: [
                  // Patrón de puntos
                  const PointsCard(),

                  // Pokeball de fondo
                  const PokemonCardPokeball(),

                  // Información del Pokémon
                  PokemonCardInformation(
                    id: widget.id,
                    name: widget.name,
                    types: widget.types ?? [],
                  ),
                ],
              ),
            ),

            // Imagen del Pokémon
            PokemonCardImage(imageUrl: widget.imageUrl, id: widget.id),
          ],
        ),
      ),
    );
  }
}
