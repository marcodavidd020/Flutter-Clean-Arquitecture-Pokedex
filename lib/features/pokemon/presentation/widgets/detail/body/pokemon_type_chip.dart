import 'package:flutter/material.dart';
import 'package:pokedex_application/core/utils/pokemon_type_utils.dart';
import 'package:pokedex_application/core/widgets/type_icon.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/detail/body/pokemon_section_title.dart';
class PokemonTypeChip extends StatelessWidget {
  final String type;

  const PokemonTypeChip({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final color = PokemonTypeUtils.getColorForType(type);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TypeIcon(type: type, color: color),
          const SizedBox(width: 6),
          PokemonSectionTitle(
            title: type.toUpperCase(),
            color: color,
            fontSize: 12,
          ),
        ],
      ),
    );
  }
}
