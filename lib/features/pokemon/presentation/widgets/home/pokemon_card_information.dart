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
    final iconPath = PokemonTypeUtils.getSvgTypeIcon(type);

    return SvgPicture.asset(
      iconPath,
      width: 15,
      height: 15,
      color: Colors.white,
      // Usar un builder para mostrar un icono de respaldo solo si el SVG falla
      placeholderBuilder: (context) {
        // Seleccionar el icono de respaldo apropiado
        final iconData = PokemonTypeUtils.getIconForType(type);

        return Icon(iconData, size: 15, color: Colors.white);
      },
    );
  }
}
