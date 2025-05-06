import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pokedex_application/core/utils/pokemon_type_utils.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon_evolution_chain.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';

/// Widget para mostrar la cadena evolutiva de un Pokémon
class PokemonEvolutionChain extends StatelessWidget {
  final EvolutionChain evolutionChain;
  final Function(int) onPokemonTap;

  const PokemonEvolutionChain({
    super.key,
    required this.evolutionChain,
    required this.onPokemonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (evolutionChain.chain.evolvesTo.isEmpty)
          const _NoEvolutionsMessage()
        else
          _buildEvolutionChain(evolutionChain.chain),
      ],
    );
  }

  Widget _buildEvolutionChain(ChainLink chain) {
    return _buildEvolutionStep(chain, 0);
  }

  Widget _buildEvolutionStep(ChainLink chain, int depth) {
    final evolutions = chain.evolvesTo;

    if (evolutions.isEmpty) {
      return _PokemonEvolutionCard(
        chain: chain,
        onTap: onPokemonTap,
      );
    }

    return Column(
      children: [
        _PokemonEvolutionCard(
          chain: chain,
          onTap: onPokemonTap,
        ),
        const SizedBox(height: EvolutionChainConstants.smallSpacing),
        ...evolutions.map((evolution) {
          return Column(
            children: [
              _EvolutionArrow(evolutionDetails: evolution.evolutionDetails),
              const SizedBox(height: EvolutionChainConstants.smallSpacing),
              _buildEvolutionStep(evolution, depth + 1),
            ],
          );
        }).toList(),
      ],
    );
  }
}

/// Mensaje mostrado cuando un Pokémon no tiene evoluciones
class _NoEvolutionsMessage extends StatelessWidget {
  const _NoEvolutionsMessage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: EvolutionChainConstants.spacing),
      child: Center(
        child: Text(
          AppTexts.noEvolutionsMessage,
          style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}

/// Widget contenedor que maneja los toques de forma más robusta
class _TouchableContainer extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;

  const _TouchableContainer({
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.grey.withAlpha(40),
      highlightColor: Colors.grey.withAlpha(20),
      borderRadius: BorderRadius.circular(EvolutionChainConstants.cardBorderRadius),
      child: child,
    );
  }
}

/// Tarjeta que muestra la información de un Pokémon en la cadena evolutiva
class _PokemonEvolutionCard extends StatelessWidget {
  final ChainLink chain;
  final Function(int) onTap;

  const _PokemonEvolutionCard({
    required this.chain,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _TouchableContainer(
      onTap: () => onTap(chain.species.id),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(EvolutionChainConstants.cardBorderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha((PresentationConstants.opacityLight * 255).round()),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              _PokemonImage(
                imageUrl: chain.species.imageUrl,
                pokemonId: chain.species.id,
              ),
              const SizedBox(width: EvolutionChainConstants.spacing),
              _PokemonInfo(species: chain.species),
              _NavigationIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

/// Imagen del Pokémon con fondo circular
class _PokemonImage extends StatelessWidget {
  final String imageUrl;
  final int pokemonId;

  const _PokemonImage({
    required this.imageUrl,
    required this.pokemonId,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Círculo decorativo de fondo
        Container(
          width: EvolutionChainConstants.pokemonImageBackground,
          height: EvolutionChainConstants.pokemonImageBackground,
          decoration: BoxDecoration(
            color: _getColorForPokemon(pokemonId)
                .withAlpha((EvolutionChainConstants.backgroundOpacity * 255).round()),
            shape: BoxShape.circle,
          ),
        ),
        // Imagen del Pokémon
        CachedNetworkImage(
          imageUrl: imageUrl,
          width: EvolutionChainConstants.pokemonImageSize,
          height: EvolutionChainConstants.pokemonImageSize,
          placeholder: (context, url) => const _ImageLoadingIndicator(),
          errorWidget: (context, url, error) => const _ImageErrorWidget(),
        ),
      ],
    );
  }

  Color _getColorForPokemon(int id) {
    // Para determinar el color, usamos el ID para asignar un tipo hipotético
    // Esto podría mejorarse si tuviéramos los tipos reales del Pokémon
    if (id <= 50) return PokemonTypeUtils.getColorForType('grass');
    if (id <= 100) return PokemonTypeUtils.getColorForType('fire');
    if (id <= 150) return PokemonTypeUtils.getColorForType('water');
    if (id <= 200) return PokemonTypeUtils.getColorForType('electric');
    if (id <= 250) return PokemonTypeUtils.getColorForType('psychic');
    if (id <= 300) return PokemonTypeUtils.getColorForType('rock');
    if (id <= 350) return PokemonTypeUtils.getColorForType('dragon');
    return PokemonTypeUtils.getColorForType('normal');
  }
}

/// Indicador de carga para la imagen
class _ImageLoadingIndicator extends StatelessWidget {
  const _ImageLoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(strokeWidth: 2),
    );
  }
}

/// Widget mostrado cuando hay error al cargar la imagen
class _ImageErrorWidget extends StatelessWidget {
  const _ImageErrorWidget();

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.broken_image,
      size: 40,
      color: Colors.grey,
    );
  }
}

/// Información del Pokémon (ID y nombre)
class _PokemonInfo extends StatelessWidget {
  final PokemonSpecies species;

  const _PokemonInfo({required this.species});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '#${species.id.toString().padLeft(3, '0')}',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Text(
            _capitalizeFirstLetter(species.name),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}

/// Flecha de navegación para la tarjeta de Pokémon
class _NavigationIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.arrow_forward_ios,
      color: Colors.grey.shade400,
      size: 16,
    );
  }
}

/// Flecha que indica el método de evolución
class _EvolutionArrow extends StatelessWidget {
  final List<EvolutionDetail> evolutionDetails;

  const _EvolutionArrow({required this.evolutionDetails});

  @override
  Widget build(BuildContext context) {
    final EvolutionTrigger trigger = _getEvolutionTrigger();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: EvolutionChainConstants.smallSpacing),
      child: Column(
        children: [
          Icon(
            trigger.icon,
            color: trigger.color,
            size: EvolutionChainConstants.arrowSize,
          ),
          const SizedBox(height: EvolutionChainConstants.tinySpacing),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: trigger.color.withAlpha((EvolutionChainConstants.backgroundOpacity * 255).round()),
              borderRadius: BorderRadius.circular(EvolutionChainConstants.pillBorderRadius),
              border: Border.all(
                color: trigger.color.withAlpha((EvolutionChainConstants.borderOpacity * 255).round()),
                width: 1,
              ),
            ),
            child: Text(
              trigger.text,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  EvolutionTrigger _getEvolutionTrigger() {
    String triggerText = 'Evoluciona';
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
        triggerText = 'Intercambio';
        iconData = Icons.swap_horiz;
        iconColor = Colors.blue;
      } else if (detail.minHappiness != null) {
        triggerText = 'Felicidad alta';
        iconData = Icons.favorite;
        iconColor = Colors.pink;
      } else if (detail.timeOfDay != null) {
        if (detail.timeOfDay == 'day') {
          triggerText = 'Durante el día';
          iconData = Icons.wb_sunny;
          iconColor = Colors.orange;
        } else {
          triggerText = 'Durante la noche';
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
