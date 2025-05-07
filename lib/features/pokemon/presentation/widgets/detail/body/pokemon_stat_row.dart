import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:pokedex_application/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/stat.dart';

class PokemonStatRow extends StatelessWidget {
  final Stat stat;

  const PokemonStatRow({super.key, required this.stat});

  @override
  Widget build(BuildContext context) {
    final double percentage = stat.value / 255;
    final Color statColor = _getStatColor(stat.value);
    final IconData statIcon = _getStatIcon(stat.name);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: statColor.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(statIcon, size: 16, color: statColor),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _formatStatName(stat.name),
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: statColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: statColor.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  '${stat.value}',
                  style: GoogleFonts.poppins(
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
          const SizedBox(height: 8),
          LayoutBuilder(
            builder: (context, constraints) {
              return TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeOutQuart,
                tween: Tween<double>(begin: 0, end: percentage),
                builder: (context, value, child) {
                  return Stack(
                    children: [
                      // Fondo de la barra
                      Container(
                        height: 10,
                        width: constraints.maxWidth,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),

                      // Barra de progreso con gradiente
                      Container(
                        height: 10,
                        width: constraints.maxWidth * value,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [statColor.withOpacity(0.7), statColor],
                          ),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: statColor.withOpacity(0.3),
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                      ),

                      // Efecto de brillo en la barra (opcional)
                      if (stat.value > 80)
                        Positioned(
                          top: 0,
                          right: constraints.maxWidth * (1 - value) + 10,
                          child: Container(
                            height: 10,
                            width: 20,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white.withOpacity(0),
                                  Colors.white.withOpacity(0.5),
                                  Colors.white.withOpacity(0),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
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
      return Colors.redAccent;
    } else if (value < 80) {
      return Colors.orangeAccent;
    } else if (value < 100) {
      return Colors.amberAccent[700]!;
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
