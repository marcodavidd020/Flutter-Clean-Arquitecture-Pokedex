import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex_application/core/utils/pokemon_type_utils.dart';

class TypeIcon extends StatelessWidget {
  const TypeIcon({
    super.key,
    required this.type,
    required this.color,
  });

  final String type;
  final Color color;

  @override
  Widget build(BuildContext context) {
    // No usar try/catch para permitir que se muestre el SVG
    final iconPath = 'assets/icons/${type.toLowerCase()}.svg';

    return SvgPicture.asset(
      iconPath,
      width: 15,
      height: 15,
      color: color,
      // Un builder de respaldo en caso de que el SVG falle
      placeholderBuilder: (context) {
        // Obtener el ícono correspondiente de PokemonTypeUtils
        final iconData = PokemonTypeUtils.getIconForType(type.toLowerCase());
        return Icon(iconData, size: 15, color: color);
      },
    );
  }
}
