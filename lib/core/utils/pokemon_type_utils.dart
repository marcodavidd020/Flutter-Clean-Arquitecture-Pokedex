import 'package:flutter/material.dart';

/// Utilidades para manejar los tipos de Pokémon y sus propiedades visuales
class PokemonTypeUtils {
  /// Devuelve el color correspondiente al tipo de Pokémon
  static Color getColorForType(String type) {
    // Colores modernos y oscuros para los tipos
    switch (type.toLowerCase()) {
      case 'normal':
        return const Color(0xFF919AA2); // Gris moderno
      case 'fire':
        return const Color(0xFFFF4C29); // Rojo fuego vibrante
      case 'water':
        return const Color(0xFF3A86FF); // Azul oceánico
      case 'grass':
        return const Color(0xFF38B000); // Verde vibrante
      case 'electric':
        return const Color(0xFFFFB800); // Amarillo eléctrico
      case 'ice':
        return const Color(0xFF48CAE4); // Azul hielo
      case 'fighting':
        return const Color(0xFFD62828); // Rojo agresivo
      case 'poison':
        return const Color(0xFF8338EC); // Púrpura intenso
      case 'ground':
        return const Color(0xFFAC7C5F); // Marrón tierra
      case 'flying':
        return const Color(0xFF6096BA); // Azul cielo
      case 'psychic':
        return const Color(0xFFEF476F); // Rosa vibrante
      case 'bug':
        return const Color(0xFF7CB518); // Verde insecto
      case 'rock':
        return const Color(0xFF6B705C); // Gris rocoso
      case 'ghost':
        return const Color(0xFF5E548E); // Púrpura fantasma
      case 'dragon':
        return const Color(0xFF2D00F7); // Azul dragón intenso
      case 'dark':
        return const Color(0xFF353535); // Negro moderno
      case 'steel':
        return const Color(0xFF6C757D); // Gris acero
      case 'fairy':
        return const Color(0xFFE0218A); // Rosa fairy intenso
      default:
        return const Color(0xFF919AA2); // Default a normal
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

  /// Devuelve el color de texto adecuado (blanco o negro) según el color de fondo
  static Color getTextColorForBackground(Color backgroundColor) {
    // Cálculo de luminosidad para determinar si el texto debe ser blanco o negro
    final luminance =
        (0.299 * backgroundColor.r +
            0.587 * backgroundColor.g +
            0.114 * backgroundColor.b) /
        255;

    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
