import 'package:flutter/material.dart';

/// Utilidades para manejar los tipos de Pokémon y sus propiedades visuales
class PokemonTypeUtils {
  /// Devuelve el color correspondiente al tipo de Pokémon
  static Color getColorForType(String type) {
    // Colores oficiales del diseño de Figma
    switch (type.toLowerCase()) {
      case 'normal':
        return const Color(0xFF9DA0AA); // Normal
      case 'fire':
        return const Color(0xFFFD7D24); // Fire
      case 'water':
        return const Color(0xFF4A90DA); // Water
      case 'grass':
        return const Color(0xFF62B957); // Grass
      case 'electric':
        return const Color(0xFFEED535); // Electric
      case 'ice':
        return const Color(0xFF61CEC0); // Ice
      case 'fighting':
        return const Color(0xFFD04164); // Fighting
      case 'poison':
        return const Color(0xFFA552CC); // Poison
      case 'ground':
        return const Color(0xFFDD7748); // Ground
      case 'flying':
        return const Color(0xFF748FC9); // Flying
      case 'psychic':
        return const Color(0xFFEA5D60); // Psychic
      case 'bug':
        return const Color(0xFF8CB330); // Bug
      case 'rock':
        return const Color(0xFFBAAB82); // Rock
      case 'ghost':
        return const Color(0xFF556AAE); // Ghost
      case 'dragon':
        return const Color(0xFF0F6AC0); // Dragon
      case 'dark':
        return const Color(0xFF58575F); // Dark
      case 'steel':
        return const Color(0xFF417D9A); // Steel
      case 'fairy':
        return const Color(0xFFED6EC7); // Fairy
      default:
        return const Color(0xFF9DA0AA); // Default a normal
    }
  }

  /// Devuelve el color de fondo correspondiente al tipo de Pokémon
  static Color getBackgroundColorForType(String type) {
    // Colores de fondo oficiales del diseño de Figma
    switch (type.toLowerCase()) {
      case 'normal':
        return const Color(0xFFB5B9C4); // Normal
      case 'fire':
        return const Color(0xFFFFA756); // Fire
      case 'water':
        return const Color(0xFF58ABF6); // Water
      case 'grass':
        return const Color(0xFF8BBE8A); // Grass
      case 'electric':
        return const Color(0xFFF2CB55); // Electric
      case 'ice':
        return const Color(0xFF91D8DF); // Ice
      case 'fighting':
        return const Color(0xFFEB4971); // Fighting
      case 'poison':
        return const Color(0xFF9F6E97); // Poison
      case 'ground':
        return const Color(0xFFF78551); // Ground
      case 'flying':
        return const Color(0xFF83A2E3); // Flying
      case 'psychic':
        return const Color(0xFFFF6568); // Psychic
      case 'bug':
        return const Color(0xFF8BD674); // Bug
      case 'rock':
        return const Color(0xFFD4C294); // Rock
      case 'ghost':
        return const Color(0xFF8571BE); // Ghost
      case 'dragon':
        return const Color(0xFF7383B9); // Dragon
      case 'dark':
        return const Color(0xFF6F6E78); // Dark
      case 'steel':
        return const Color(0xFF4C91B3); // Steel
      case 'fairy':
        return const Color(0xFFEBA8C3); // Fairy
      default:
        return const Color(0xFFB5B9C4); // Default a normal
    }
  }

  /// Devuelve el ícono correspondiente al tipo de Pokémon
  static IconData getIconForType(String type) {
    switch (type.toLowerCase()) {
      case 'normal':
        return Icons.circle;
      case 'fire':
        return Icons.local_fire_department;
      case 'water':
        return Icons.water_drop;
      case 'grass':
        return Icons.grass;
      case 'electric':
        return Icons.bolt;
      case 'ice':
        return Icons.ac_unit;
      case 'poison':
        return Icons.science;
      case 'flying':
        return Icons.air;
      case 'psychic':
        return Icons.psychology;
      case 'bug':
        return Icons.bug_report;
      case 'rock':
        return Icons.landscape;
      case 'ground':
        return Icons.terrain;
      case 'fighting':
        return Icons.sports_martial_arts;
      case 'ghost':
        return Icons.visibility_off;
      case 'dragon':
        return Icons.whatshot;
      case 'dark':
        return Icons.nights_stay;
      case 'steel':
        return Icons.shield;
      case 'fairy':
        return Icons.auto_awesome;
      default:
        return Icons.circle;
    }
  }

  // getPokemonType(int id) {
  static String getPokemonType(int id) {
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

  //Type Icon Svg
  static String getSvgTypeIcon(String type) {
    return 'assets/icons/${type.toLowerCase()}.svg';
  }

  /// Devuelve el color de texto adecuado (blanco o negro) según el color de fondo
  static Color getTextColorForBackground(Color backgroundColor) {
    // Cálculo de luminosidad para determinar si el texto debe ser blanco o negro
    final luminance =
        (0.299 * backgroundColor.red +
            0.587 * backgroundColor.green +
            0.114 * backgroundColor.blue) /
        255;

    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
