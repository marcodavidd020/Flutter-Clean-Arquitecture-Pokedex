import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex_application/core/utils/pokemon_type_utils.dart';
import 'package:pokedex_application/core/utils/string_utils.dart';
import 'package:pokedex_application/core/widgets/type_icon.dart';

/// Widget que muestra un chip con el tipo de Pokémon y su ícono
class PokemonTypeChip extends StatelessWidget {
  final String type;
  final double? fontSize;
  final bool showIcon;

  const PokemonTypeChip({
    super.key,
    required this.type,
    this.fontSize,
    this.showIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color typeColor = PokemonTypeUtils.getColorForType(type);
    final Color textColor = Colors.white;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
      decoration: BoxDecoration(
        color: typeColor,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icono del tipo
          if (showIcon) ...[
            TypeIcon(type: type, color: textColor),
            const SizedBox(width: 3),
          ],

          // Nombre del tipo
          Text(
            type.capitalize(),
            style: TextStyle(
              color: textColor,
              fontSize: fontSize ?? 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
