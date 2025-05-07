import 'package:equatable/equatable.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon_evolution_chain.dart';

class EvolutionChainModel extends Equatable {
  final List<PokemonEvolutionModel> evolutions;

  const EvolutionChainModel({required this.evolutions});

  factory EvolutionChainModel.fromJson(Map<String, dynamic> json) {
    List<PokemonEvolutionModel> evolutions = [];

    // Comenzamos con la especie base de la cadena (el primer Pokémon)
    final baseSpecies = json['chain']['species']['name'];
    final baseUrl = json['chain']['species']['url'];

    // Extraemos el ID a partir de la URL
    final baseId = int.parse(baseUrl.split('/')[6]);

    // Agregamos el Pokémon base
    evolutions.add(
      PokemonEvolutionModel(
        id: baseId,
        name: baseSpecies,
        imageUrl: _getPokemonImageUrl(baseId),
        isBaby: json['chain']['is_baby'] ?? false,
      ),
    );

    // Procesamos la primera evolución
    _processEvolutionChain(json['chain']['evolves_to'], evolutions);

    return EvolutionChainModel(evolutions: evolutions);
  }

  // Método recursivo para procesar todas las evoluciones en la cadena
  static void _processEvolutionChain(
    List<dynamic> evolvesTo,
    List<PokemonEvolutionModel> evolutions,
  ) {
    for (var evolution in evolvesTo) {
      final species = evolution['species']['name'];
      final url = evolution['species']['url'];
      final id = int.parse(url.split('/')[6]);

      // Obtenemos los detalles de la evolución
      final evolutionDetails =
          evolution['evolution_details'].isNotEmpty
              ? evolution['evolution_details'][0]
              : null;

      // Agregamos esta evolución
      evolutions.add(
        PokemonEvolutionModel(
          id: id,
          name: species,
          imageUrl: _getPokemonImageUrl(id),
          isBaby: evolution['is_baby'] ?? false,
          minLevel:
              evolutionDetails != null ? evolutionDetails['min_level'] : null,
          trigger:
              evolutionDetails != null && evolutionDetails['trigger'] != null
                  ? evolutionDetails['trigger']['name']
                  : null,
          item:
              evolutionDetails != null && evolutionDetails['item'] != null
                  ? evolutionDetails['item']['name']
                  : null,
        ),
      );

      // Si hay más evoluciones, las procesamos recursivamente
      if (evolution['evolves_to'].isNotEmpty) {
        _processEvolutionChain(evolution['evolves_to'], evolutions);
      }
    }
  }

  static String _getPokemonImageUrl(int id) {
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
  }

  @override
  List<Object?> get props => [evolutions];

  // Método simplificado para convertir a entidad
  EvolutionChain toEntity() {
    // Para el caso más simple, creamos una cadena con el primer Pokémon
    final firstPokemon = evolutions.first;

    // Construir especies
    final firstSpecies = PokemonSpecies(
      id: firstPokemon.id,
      name: firstPokemon.name,
      url: firstPokemon.imageUrl,
      imageUrl: firstPokemon.imageUrl,
    );

    // Construir evoluciones
    final List<ChainLink> evolvesTo = [];
    if (evolutions.length > 1) {
      // Si hay más de un Pokémon, añadimos el resto como evoluciones
      for (int i = 1; i < evolutions.length; i++) {
        final evolution = evolutions[i];
        evolvesTo.add(
          ChainLink(
            species: PokemonSpecies(
              id: evolution.id,
              name: evolution.name,
              url: evolution.imageUrl,
              imageUrl: evolution.imageUrl,
            ),
            evolutionDetails: [
              EvolutionDetail(
                minLevel: evolution.minLevel,
                item:
                    evolution.item != null
                        ? Item(name: evolution.item!, url: '')
                        : null,
                trigger:
                    evolution.trigger != null
                        ? Trigger(name: evolution.trigger!, url: '')
                        : null,
              ),
            ],
            evolvesTo: [],
          ),
        );
      }
    }

    // Construir cadena completa
    return EvolutionChain(
      chain: ChainLink(
        species: firstSpecies,
        evolutionDetails: [],
        evolvesTo: evolvesTo,
      ),
    );
  }
}

class PokemonEvolutionModel extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final bool isBaby;
  final int? minLevel;
  final String? trigger;
  final String? item;

  const PokemonEvolutionModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.isBaby = false,
    this.minLevel,
    this.trigger,
    this.item,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    imageUrl,
    isBaby,
    minLevel,
    trigger,
    item,
  ];
}
