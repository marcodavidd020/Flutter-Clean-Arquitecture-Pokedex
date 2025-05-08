import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex_application/core/utils/pokemon_type_utils.dart';
import 'package:pokedex_application/core/utils/string_utils.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';
import 'package:google_fonts/google_fonts.dart';

class PokemonCardInformation extends StatelessWidget {
  const PokemonCardInformation({
    super.key,
    required this.id,
    required this.name,
    required this.types,
  });

  final int id;
  final String name;
  final List<String> types;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: PokemonCardConstants.informationPaddingLeft,
        top: PokemonCardConstants.informationPaddingTop,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Usar espacio mínimo necesario
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Número del Pokémon
          Text(
            '#${id.toString().padLeft(3, '0')}',
            style: GoogleFonts.poppins(
              fontSize: PokemonCardConstants.numberFontSize,
              fontWeight: FontWeight.bold,
              color: PokemonCardConstants.numberColor,
            ),
          ),

          // Nombre del Pokémon
          Text(
            name.capitalize(),
            style: GoogleFonts.poppins(
              fontSize: PokemonCardConstants.nameFontSize,
              fontWeight: FontWeight.bold,
              color: PokemonCardConstants.nameColor,
            ),
            overflow: TextOverflow.ellipsis, // Evitar desbordamiento
          ),

          const SizedBox(height: 3), // Reducir espacio
          // Badge de tipo - usar Flexible para que se ajuste al espacio
          if (types.isNotEmpty)
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Iterar sobre todos los tipos disponibles
                  ...types
                      .map(
                        (type) => Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 3, // Reducir padding vertical
                            ),
                            decoration: BoxDecoration(
                              color: PokemonTypeUtils.getColorForType(type),
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
                                    fontSize: 9, // Reducir tamaño de fuente
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
}
