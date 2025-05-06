import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon.dart';

class PokemonStatRow extends StatelessWidget {
  final Stat stat;

  const PokemonStatRow({super.key, required this.stat});

  @override
  Widget build(BuildContext context) {
    final double percentage = stat.baseStat / 255;
    final Color statColor = _getStatColor(stat.baseStat);
    final IconData statIcon = _getStatIcon(stat.name);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(statIcon, size: 18, color: statColor),
                  const SizedBox(width: 8),
                  Text(
                    _formatStatName(stat.name),
                    style: GoogleFonts.notoSans(
                      textStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  // color: statColor.withOpacity(0.2),
                  color: statColor.withAlpha(128),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${stat.baseStat}',
                  style: GoogleFonts.barlowCondensed(
                    textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: statColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            tween: Tween<double>(begin: 0, end: percentage),
            builder: (context, value, child) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: value,
                  backgroundColor: Colors.grey[300],
                  color: statColor,
                  minHeight: 8,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String _formatStatName(String name) {
    switch (name) {
      case 'hp':
        return 'HP';
      case 'attack':
        return 'Ataque';
      case 'defense':
        return 'Defensa';
      case 'special-attack':
        return 'Ataque Especial';
      case 'special-defense':
        return 'Defensa Especial';
      case 'speed':
        return 'Velocidad';
      default:
        return name[0].toUpperCase() + name.substring(1);
    }
  }

  Color _getStatColor(int value) {
    if (value < 50) {
      return Colors.red;
    } else if (value < 80) {
      return Colors.orange;
    } else if (value < 100) {
      return Colors.amber;
    } else if (value < 150) {
      return Colors.lightGreen;
    } else {
      return Colors.green;
    }
  }

  IconData _getStatIcon(String statName) {
    switch (statName) {
      case 'hp':
        return Icons.favorite;
      case 'attack':
        return Icons.flash_on;
      case 'defense':
        return Icons.shield;
      case 'special-attack':
        return Icons.auto_fix_high;
      case 'special-defense':
        return Icons.security;
      case 'speed':
        return Icons.speed;
      default:
        return Icons.star;
    }
  }
}
