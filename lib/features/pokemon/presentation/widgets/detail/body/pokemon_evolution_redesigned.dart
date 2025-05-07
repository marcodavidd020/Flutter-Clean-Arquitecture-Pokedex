import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex_application/core/utils/pokemon_type_utils.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon_evolution_chain.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/detail/body/pokemon_id_badge.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/detail/pokemon_image_placeholder.dart';

/// Widget rediseñado para mostrar la cadena evolutiva de un Pokémon
class PokemonEvolutionRedesigned extends StatelessWidget {
  final EvolutionChain evolutionChain;
  final Function(int) onPokemonTap;
  final String mainType;

  const PokemonEvolutionRedesigned({
    super.key,
    required this.evolutionChain,
    required this.onPokemonTap,
    required this.mainType,
  });

  @override
  Widget build(BuildContext context) {
    final typeColor = PokemonTypeUtils.getBackgroundColorForType(mainType);

    if (evolutionChain.chain.evolvesTo.isEmpty) {
      return _buildNoEvolutionsMessage(typeColor);
    }

    return _buildEvolutionChainWidget(evolutionChain.chain, typeColor);
  }

  Widget _buildNoEvolutionsMessage(Color typeColor) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: typeColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.trending_flat, color: typeColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              AppTexts.noEvolutionsMessage,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEvolutionChainWidget(ChainLink chain, Color typeColor) {
    if (chain.evolvesTo.isEmpty) {
      return _buildSinglePokemonCard(chain.species, typeColor);
    }

    // Si las evoluciones son lineales, usamos un diseño horizontal
    if (chain.evolvesTo.length == 1 &&
        chain.evolvesTo[0].evolvesTo.length <= 1) {
      return _buildLinearEvolution(chain, typeColor);
    }

    // Para evoluciones ramificadas, usamos un diseño en árbol
    return _buildBranchedEvolution(chain, typeColor);
  }

  Widget _buildLinearEvolution(ChainLink chain, Color typeColor) {
    final evolutionSteps = <Widget>[];
    var currentChain = chain;

    // Añadir el Pokémon inicial
    evolutionSteps.add(_buildEvolutionStep(currentChain.species, typeColor));

    // Iterar por la cadena lineal
    while (currentChain.evolvesTo.isNotEmpty) {
      evolutionSteps.add(
        _buildEvolutionArrow(
          currentChain.evolvesTo[0].evolutionDetails,
          typeColor,
        ),
      );

      currentChain = currentChain.evolvesTo[0];
      evolutionSteps.add(_buildEvolutionStep(currentChain.species, typeColor));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: evolutionSteps,
        ),
      ),
    );
  }

  Widget _buildBranchedEvolution(ChainLink chain, Color typeColor) {
    final basePokemon = _buildEvolutionStep(chain.species, typeColor);
    final branches = <Widget>[];

    for (final evolution in chain.evolvesTo) {
      branches.add(
        Column(
          children: [
            _buildEvolutionArrow(evolution.evolutionDetails, typeColor),
            _buildEvolutionChainWidget(evolution, typeColor),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [basePokemon, const SizedBox(height: 16), ...branches],
        ),
      ),
    );
  }

  Widget _buildEvolutionStep(PokemonSpecies species, Color typeColor) {
    return GestureDetector(
      onTap: () => onPokemonTap(species.id),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: typeColor.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Círculo de fondo
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: typeColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                ),

                // Imagen del Pokémon
                CachedNetworkImage(
                  imageUrl: species.imageUrl,
                  width: 80,
                  height: 80,
                  placeholder:
                      (context, url) => const PokemonImagePlaceholder(),
                  errorWidget:
                      (context, url, error) => const Icon(
                        Icons.broken_image,
                        size: 40,
                        color: Colors.grey,
                      ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Número de Pokémon
            PokemonIdBadge(
              id: species.id,
              backgroundColor: typeColor.withOpacity(0.1),
              textColor: typeColor,
              fontSize: 14,
            ),

            const SizedBox(height: 8),

            // Nombre del Pokémon
            Text(
              _capitalizeFirstLetter(species.name),
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEvolutionArrow(List<EvolutionDetail> details, Color typeColor) {
    final evolutionTrigger = _getEvolutionTrigger(details);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Column(
        children: [
          Icon(evolutionTrigger.icon, color: evolutionTrigger.color, size: 24),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: evolutionTrigger.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: evolutionTrigger.color.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Text(
              evolutionTrigger.text,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: evolutionTrigger.color.withAlpha(220),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSinglePokemonCard(PokemonSpecies species, Color typeColor) {
    return GestureDetector(
      onTap: () => onPokemonTap(species.id),
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: typeColor.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Círculo de fondo
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: typeColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                ),

                // Imagen del Pokémon
                CachedNetworkImage(
                  imageUrl: species.imageUrl,
                  width: 70,
                  height: 70,
                  placeholder:
                      (context, url) => const PokemonImagePlaceholder(),
                  errorWidget:
                      (context, url, error) => const Icon(
                        Icons.broken_image,
                        size: 40,
                        color: Colors.grey,
                      ),
                ),
              ],
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Número de Pokémon
                  PokemonIdBadge(
                    id: species.id,
                    backgroundColor: typeColor.withOpacity(0.1),
                    textColor: typeColor,
                    fontSize: 14,
                  ),

                  const SizedBox(height: 8),

                  // Nombre del Pokémon
                  Text(
                    _capitalizeFirstLetter(species.name),
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey.shade400,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  EvolutionTrigger _getEvolutionTrigger(
    List<EvolutionDetail> evolutionDetails,
  ) {
    String triggerText = AppTexts.evolutionTriggerText;
    IconData iconData = Icons.arrow_downward_rounded;
    Color iconColor = Colors.grey;

    if (evolutionDetails.isNotEmpty) {
      final detail = evolutionDetails.first;

      if (detail.minLevel != null) {
        triggerText = 'Nivel ${detail.minLevel}';
        iconData = Icons.arrow_circle_up;
        iconColor = Colors.amber;
      } else if (detail.item != null) {
        triggerText = 'Usar ${detail.item!.name}';
        iconData = Icons.celebration;
        iconColor = Colors.purple;
      } else if (detail.trigger != null && detail.trigger!.name == 'trade') {
        triggerText = AppTexts.tradeTriggerText;
        iconData = Icons.swap_horiz;
        iconColor = Colors.blue;
      } else if (detail.minHappiness != null) {
        triggerText = AppTexts.highHappinessTriggerText;
        iconData = Icons.favorite;
        iconColor = Colors.pink;
      } else if (detail.timeOfDay != null) {
        if (detail.timeOfDay == 'day') {
          triggerText = AppTexts.dayTriggerText;
          iconData = Icons.wb_sunny;
          iconColor = Colors.orange;
        } else {
          triggerText = AppTexts.nightTriggerText;
          iconData = Icons.nightlight_round;
          iconColor = Colors.indigo;
        }
      }
    }

    return EvolutionTrigger(
      text: triggerText,
      icon: iconData,
      color: iconColor,
    );
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}

/// Clase auxiliar para encapsular la información de un disparador de evolución
class EvolutionTrigger {
  final String text;
  final IconData icon;
  final Color color;

  const EvolutionTrigger({
    required this.text,
    required this.icon,
    required this.color,
  });
}
