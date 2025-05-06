import 'package:flutter/material.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';

class PokemonTypeChip extends StatelessWidget {
  final String type;
  final bool small;

  const PokemonTypeChip({super.key, required this.type, this.small = false});

  @override
  Widget build(BuildContext context) {
    final Color typeColor = _getTypeColor(type);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal:
            small
                ? PokemonTypeConstants.chipPaddingHorizontalSmall
                : PokemonTypeConstants.chipPaddingHorizontalLarge,
        vertical:
            small
                ? PokemonTypeConstants.chipPaddingVerticalSmall
                : PokemonTypeConstants.chipPaddingVerticalLarge,
      ),
      margin: const EdgeInsets.only(
        right: PresentationConstants.paddingMedium,
        bottom: PresentationConstants.paddingMedium,
      ),
      decoration: BoxDecoration(
        color: typeColor,
        borderRadius: BorderRadius.circular(
          small
              ? PokemonTypeConstants.chipBorderRadiusSmall
              : PokemonTypeConstants.chipBorderRadiusLarge,
        ),
        boxShadow: [
          BoxShadow(
            color: typeColor.withOpacity(0.4),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _getTypeIcon(type, small),
          SizedBox(
            width:
                small
                    ? PresentationConstants.paddingSmall
                    : PresentationConstants.paddingMedium,
          ),
          Text(
            small ? _capitalize(type) : _capitalize(type),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize:
                  small
                      ? PokemonTypeConstants.textSizeSmall
                      : PokemonTypeConstants.textSizeLarge,
            ),
          ),
        ],
      ),
    );
  }

  String _capitalize(String text) {
    return "${text[0].toUpperCase()}${text.substring(1)}";
  }

  Widget _getTypeIcon(String type, bool small) {
    IconData iconData;

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
        iconData = Icons.electric_bolt;
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
        iconData = Icons.auto_fix_high;
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
      default:
        iconData = Icons.help_outline;
    }

    return Icon(
      iconData,
      color: Colors.white,
      size:
          small
              ? PokemonTypeConstants.iconSizeSmall
              : PokemonTypeConstants.iconSizeLarge,
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'normal':
        return const Color(0xFFA8A878);
      case 'fire':
        return const Color(0xFFF08030);
      case 'water':
        return const Color(0xFF6890F0);
      case 'grass':
        return const Color(0xFF78C850);
      case 'electric':
        return const Color(0xFFF8D030);
      case 'ice':
        return const Color(0xFF98D8D8);
      case 'fighting':
        return const Color(0xFFC03028);
      case 'poison':
        return const Color(0xFFA040A0);
      case 'ground':
        return const Color(0xFFE0C068);
      case 'flying':
        return const Color(0xFFA890F0);
      case 'psychic':
        return const Color(0xFFF85888);
      case 'bug':
        return const Color(0xFFA8B820);
      case 'rock':
        return const Color(0xFFB8A038);
      case 'ghost':
        return const Color(0xFF705898);
      case 'dragon':
        return const Color(0xFF7038F8);
      case 'dark':
        return const Color(0xFF705848);
      case 'steel':
        return const Color(0xFF6C757D);
      case 'fairy':
        return const Color(0xFFEE99AC);
      default:
        return const Color(0xFFA8A878); // Default a normal
    }
  }
}
