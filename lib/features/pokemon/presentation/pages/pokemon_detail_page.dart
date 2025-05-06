import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon_evolution_chain.dart';
import 'package:pokedex_application/features/pokemon/presentation/bloc/pokemon_details_bloc.dart';
import 'package:pokedex_application/features/pokemon/presentation/bloc/pokemon_evolution_bloc.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/pokemon_error_view.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/pokemon_evolution_chain.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/pokemon_stat_row.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/pokemon_type_chip.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';
import 'package:shimmer/shimmer.dart';

class PokemonDetailPage extends StatefulWidget {
  final String pokemonId;
  final Pokemon? initialPokemon;

  const PokemonDetailPage({
    super.key,
    required this.pokemonId,
    this.initialPokemon,
  });

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  Color _dominantColor = Colors.blue.shade200; // Color predeterminado
  Pokemon? _pokemon;

  @override
  void initState() {
    super.initState();
    // Configurar controlador de animación
    _rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );
    _rotationController.repeat();

    // Si ya tenemos el Pokemon desde la lista, lo usamos directamente
    if (widget.initialPokemon != null) {
      _pokemon = widget.initialPokemon;
      _dominantColor = _getColorByPokemonId(_pokemon!.id);

      // Solo cargar evoluciones, evitando la petición de detalles
      context.read<PokemonEvolutionBloc>().add(
        FetchPokemonEvolution(_pokemon!.id),
      );
    } else {
      // Comportamiento original si no tenemos datos iniciales
      context.read<PokemonDetailsBloc>().add(
        FetchPokemonDetails(widget.pokemonId),
      );

      // Cargar evoluciones cuando tengamos los detalles del Pokemon
      final pokemonId = int.tryParse(widget.pokemonId);
      if (pokemonId != null) {
        context.read<PokemonEvolutionBloc>().add(
          FetchPokemonEvolution(pokemonId),
        );
      }
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  Color _getColorByPokemonId(int id) {
    // Si tenemos el Pokémon con sus tipos, usar el primer tipo para el color
    if (_pokemon != null && _pokemon!.types.isNotEmpty) {
      final mainType = _pokemon!.types.first;
      return _getTypeColor(mainType);
    }

    // Los colores están basados en los tipos más comunes por rangos de ID de Pokémon
    if (id <= 50) return Colors.green.shade300; // Grass/Bug types
    if (id <= 100) return Colors.red.shade300; // Fire types
    if (id <= 150) return Colors.blue.shade300; // Water types
    if (id <= 200) return Colors.yellow.shade700; // Electric types
    if (id <= 250) return Colors.purple.shade300; // Poison/Psychic types
    if (id <= 300) return Colors.brown.shade300; // Ground/Rock types
    if (id <= 350) return Colors.indigo.shade300; // Flying/Dragon types
    return Colors.teal.shade300; // Fallback color
  }

  // Método para obtener el color según el tipo de Pokémon
  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'normal':
        return Colors.grey.shade500;
      case 'fire':
        return Colors.red;
      case 'water':
        return Colors.blue;
      case 'grass':
        return Colors.green;
      case 'electric':
        return Colors.amber;
      case 'ice':
        return Colors.cyan;
      case 'fighting':
        return Colors.brown;
      case 'poison':
        return Colors.purple;
      case 'ground':
        return Colors.brown.shade300;
      case 'flying':
        return Colors.indigo.shade200;
      case 'psychic':
        return Colors.pink;
      case 'bug':
        return Colors.lightGreen;
      case 'rock':
        return Colors.grey.shade700;
      case 'ghost':
        return Colors.indigo;
      case 'dragon':
        return Colors.indigo.shade800;
      case 'dark':
        return Colors.grey.shade800;
      case 'steel':
        return Colors.blueGrey;
      case 'fairy':
        return Colors.pinkAccent;
      default:
        return Colors.grey;
    }
  }

  void _navigateToPokemon(int pokemonId) {
    // Intentar obtener el pokémon de la evolución actual si existe en el estado
    Pokemon? pokemonFromEvolution;

    final evolutionState = context.read<PokemonEvolutionBloc>().state;
    if (evolutionState is PokemonEvolutionLoaded) {
      // Buscar en toda la cadena evolutiva
      pokemonFromEvolution = _findPokemonInEvolutionChain(
        evolutionState.evolutionChain.chain,
        pokemonId,
      );
    }

    context.goNamed(
      'pokemon_detail',
      pathParameters: {'id': pokemonId.toString()},
      extra: pokemonFromEvolution, // Pasar el objeto Pokemon si lo encontramos
    );
  }

  // Método auxiliar para buscar un Pokémon en la cadena evolutiva
  Pokemon? _findPokemonInEvolutionChain(ChainLink chain, int targetId) {
    // Comprobar si el Pokémon actual coincide
    if (chain.species.id == targetId) {
      // Crear un objeto Pokemon simplificado con los datos básicos
      return Pokemon(
        id: chain.species.id,
        name: chain.species.name,
        imageUrl: chain.species.imageUrl,
        types: const [], // No tenemos tipos disponibles en la especie
        height: 0, // No tenemos altura disponible
        weight: 0, // No tenemos peso disponible
        stats: const [], // No tenemos stats disponibles
      );
    }

    // Buscar recursivamente en las evoluciones
    for (final evolution in chain.evolvesTo) {
      final result = _findPokemonInEvolutionChain(evolution, targetId);
      if (result != null) {
        return result;
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonDetailsBloc, PokemonDetailsState>(
      builder: (context, state) {
        // Siempre mostramos el diseño básico para permitir la animación Hero
        final pokemonId = int.tryParse(widget.pokemonId) ?? 0;

        // Si tenemos Pokemon inicial o del estado, lo usamos
        final pokemon =
            _pokemon ?? (state is PokemonDetailsLoaded ? state.pokemon : null);

        final isLoading =
            _pokemon == null &&
            (state is PokemonDetailsInitial || state is PokemonDetailsLoading);

        PokemonDetailsError? errorState;
        if (state is PokemonDetailsError) {
          errorState = state;
        }
        final hasError = errorState != null;

        // Actualizar el color en caso de tener datos
        if (pokemon != null) {
          _dominantColor = _getColorByPokemonId(pokemon.id);
        }

        return Scaffold(
          backgroundColor: Colors.grey.shade50,
          body: SafeArea(
            child: Stack(
              children: [
                // Fondo decorativo con el color del tipo del Pokémon
                Positioned.fill(
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              _dominantColor,
                              _dominantColor.withOpacity(0.7),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildHeader(pokemonId, pokemon, isLoading),

                      if (hasError)
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: PokemonErrorView(
                            message: errorState.message,
                            onRetry: () {
                              context.read<PokemonDetailsBloc>().add(
                                FetchPokemonDetails(widget.pokemonId),
                              );
                            },
                          ),
                        )
                      else
                        _buildPokemonDetails(pokemon, isLoading, pokemonId),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(int pokemonId, Pokemon? pokemon, bool isLoading) {
    final imageUrl =
        pokemon?.imageUrl ??
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokemonId.png";

    return SizedBox(
      height: 340,
      child: Stack(
        children: [
          // Pokeball decorativa de fondo con animación de rotación
          Positioned.fill(
            child: Center(
              child: RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(_rotationController),
                child: Opacity(
                  opacity: 0.2,
                  child: Transform.scale(
                    scale: 2.8,
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                      child: Image.asset(
                        AppTexts.pokeballImage,
                        width: 250,
                        height: 250,
                        errorBuilder: (_, __, ___) => const SizedBox(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Efecto de partículas/destellos para dar dinamismo (simulado con contenedores)
          ..._buildParticleEffects(),

          Column(
            children: [
              // Barra superior con botón de regresar
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          // Limpiamos el estado al volver atrás
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const Spacer(),
                    // Botón de favorito
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // Implementar funcionalidad de favorito
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Imagen del Pokémon
              Container(
                height: 220,
                alignment: Alignment.center,
                child: Hero(
                  tag: 'pokemon-detail-$pokemonId',
                  flightShuttleBuilder: (
                    BuildContext flightContext,
                    Animation<double> animation,
                    HeroFlightDirection flightDirection,
                    BuildContext fromHeroContext,
                    BuildContext toHeroContext,
                  ) {
                    // Usar la imagen actual siempre para evitar parpadeos
                    return Material(
                      color: Colors.transparent,
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    height: 220,
                    width: 220,
                    fit: BoxFit.contain,
                    placeholder:
                        (context, url) => const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                    errorWidget:
                        (context, url, error) => const Icon(
                          Icons.broken_image,
                          size: 80,
                          color: Colors.white70,
                        ),
                  ),
                ),
              ),

              // Información del ID y tipos
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Text(
                        "#${pokemonId.toString().padLeft(3, '0')}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Método para crear efectos de partículas/destellos
  List<Widget> _buildParticleEffects() {
    final random = DateTime.now().millisecondsSinceEpoch;
    return List.generate(8, (index) {
      final size = (index % 3 + 1) * 4.0;
      final offsetX = (random % 300 + index * 40) % 300;
      final offsetY = (random % 250 + index * 30) % 250;

      return Positioned(
        left: offsetX.toDouble(),
        top: offsetY.toDouble(),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.3),
                blurRadius: 3,
                spreadRadius: 2,
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildPokemonDetails(Pokemon? pokemon, bool isLoading, int pokemonId) {
    if (isLoading) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: _buildLoadingShimmer(),
      );
    }

    // Texto de descripción específico para Bulbasaur si es el ID 1
    String description =
        // "Este Pokémon puede ser visto durmiendo bajo la luz brillante del sol. Hay una semilla en su lomo. Al absorber los rayos del sol, la semilla crece progresivamente más grande.";
        AppTexts.bulbasaurDescription;

    if (pokemon?.id != 1) {
      description =
          // "Este Pokémon tiene características únicas que lo hacen especial en su tipo. Los entrenadores lo valoran por sus habilidades en combate y su lealtad.";
          AppTexts.defaultDescription;
    }

    final name = pokemon?.name ?? AppTexts.loadingText;

    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Nombre y tipos
            _buildPokemonHeader(name, pokemon),

            const SizedBox(height: 24),

            // Descripción del Pokémon
            _buildInfoCard(
              title: null,
              child: Text(
                description,
                style: GoogleFonts.notoSans(
                  textStyle: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Información básica - altura, peso, etc.
            _buildInfoCard(
              // title: "Información básica",
              title: AppTexts.infoBasicTitle,
              child: Row(
                children: [
                  Expanded(
                    child: _buildInfoItem(
                      icon: Icons.height,
                      // label: "Altura",
                      label: AppTexts.heightLabel,
                      value: "${(pokemon?.height ?? 0) / 10} m",
                    ),
                  ),
                  Expanded(
                    child: _buildInfoItem(
                      icon: Icons.fitness_center,
                      // label: "Peso",
                      label: AppTexts.weightLabel,
                      value: "${(pokemon?.weight ?? 0) / 10} kg",
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Estadísticas
            if (pokemon != null && pokemon.stats.isNotEmpty)
              _buildInfoCard(
                // title: "Estadísticas",
                title: AppTexts.statsTitle,
                child: Column(
                  children:
                      pokemon.stats
                          .map((stat) => PokemonStatRow(stat: stat))
                          .toList(),
                ),
              ),

            const SizedBox(height: 20),

            // Debilidades
            _buildInfoCard(
              // title: "Debilidades",
              title: AppTexts.weaknessesTitle,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    _getWeaknesses(
                      pokemon?.types ?? [],
                    ).map((type) => PokemonTypeChip(type: type)).toList(),
              ),
            ),

            const SizedBox(height: 20),

            // Evoluciones
            BlocBuilder<PokemonEvolutionBloc, PokemonEvolutionState>(
              builder: (context, state) {
                if (state is PokemonEvolutionLoaded) {
                  return _buildInfoCard(
                    // title: "Evoluciones",
                    title: AppTexts.evolutionsTitle,
                    child: PokemonEvolutionChain(
                      evolutionChain: state.evolutionChain,
                      onPokemonTap: _navigateToPokemon,
                    ),
                  );
                } else if (state is PokemonEvolutionLoading) {
                  return Center(
                    child: CircularProgressIndicator(color: _dominantColor),
                  );
                }
                return const SizedBox.shrink();
              },
            ),

            // Espacio al final para mejor UX
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Nuevo método para construir el encabezado con nombre y tipos
  Widget _buildPokemonHeader(String name, Pokemon? pokemon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          name.capitalize(),
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: _dominantColor.withOpacity(0.8),
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Tipos
        if (pokemon?.types.isNotEmpty ?? false)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                pokemon!.types
                    .map(
                      (type) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: PokemonTypeChip(type: type),
                      ),
                    )
                    .toList(),
          ),
      ],
    );
  }

  Widget _buildInfoCard({required String? title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
          BoxShadow(
            color: _dominantColor.withOpacity(0.08),
            blurRadius: 12,
            spreadRadius: -2,
          ),
        ],
        border: Border.all(color: Colors.grey.shade100, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Row(
              children: [
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _dominantColor,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          _dominantColor.withOpacity(0.5),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
          child,
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: _dominantColor, size: 30),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.notoSans(
            textStyle: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.barlowCondensed(
            textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _dominantColor.withOpacity(0.8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
    );
  }

  List<String> _getWeaknesses(List<String> types) {
    // Simulamos debilidades basadas en los tipos
    if (types.contains('grass')) {
      if (types.contains('poison')) {
        return ['fire', 'ice', 'flying', 'psychic'];
      }
      return ['fire', 'ice', 'poison', 'flying', 'bug'];
    } else if (types.contains('fire')) {
      return ['water', 'ground', 'rock'];
    } else if (types.contains('water')) {
      return ['electric', 'grass'];
    } else if (types.contains('electric')) {
      return ['ground'];
    }

    return ['normal']; // Tipo por defecto
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
