import 'package:equatable/equatable.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon.dart';

class PokemonEvolutionChain extends Equatable {
  final List<Pokemon> chain;
  final Map<int, List<int>> evolutionMap;

  const PokemonEvolutionChain({
    required this.chain,
    required this.evolutionMap,
  });

  @override
  List<Object> get props => [chain, evolutionMap];

  factory PokemonEvolutionChain.empty() {
    return const PokemonEvolutionChain(
      chain: [],
      evolutionMap: {},
    );
  }
}

class EvolutionChain extends Equatable {
  final ChainLink chain;

  const EvolutionChain({required this.chain});

  @override
  List<Object?> get props => [chain];
}

class ChainLink extends Equatable {
  final List<ChainLink> evolvesTo;
  final List<EvolutionDetail> evolutionDetails;
  final PokemonSpecies species;

  const ChainLink({
    required this.evolvesTo,
    required this.evolutionDetails,
    required this.species,
  });

  @override
  List<Object?> get props => [evolvesTo, evolutionDetails, species];
}

class PokemonSpecies extends Equatable {
  final int id;
  final String name;
  final String url;
  final String imageUrl;

  const PokemonSpecies({
    required this.id,
    required this.name,
    required this.url,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, name, url, imageUrl];
}

class EvolutionDetail extends Equatable {
  final Item? item;
  final String? gender;
  final Item? heldItem;
  final String? knownMove;
  final String? knownMoveType;
  final String? location;
  final int? minLevel;
  final int? minHappiness;
  final int? minBeauty;
  final int? minAffection;
  final bool? needsOverworldRain;
  final String? partySpecies;
  final String? partyType;
  final String? relativePhysicalStats;
  final String? timeOfDay;
  final String? tradeSpecies;
  final Trigger? trigger;
  final bool? turnUpsideDown;

  const EvolutionDetail({
    this.item,
    this.gender,
    this.heldItem,
    this.knownMove,
    this.knownMoveType,
    this.location,
    this.minLevel,
    this.minHappiness,
    this.minBeauty,
    this.minAffection,
    this.needsOverworldRain,
    this.partySpecies,
    this.partyType,
    this.relativePhysicalStats,
    this.timeOfDay,
    this.tradeSpecies,
    this.trigger,
    this.turnUpsideDown,
  });

  @override
  List<Object?> get props => [
    item,
    gender,
    heldItem,
    knownMove,
    knownMoveType,
    location,
    minLevel,
    minHappiness,
    minBeauty,
    minAffection,
    needsOverworldRain,
    partySpecies,
    partyType,
    relativePhysicalStats,
    timeOfDay,
    tradeSpecies,
    trigger,
    turnUpsideDown,
  ];
}

class Item extends Equatable {
  final String name;
  final String url;

  const Item({required this.name, required this.url});

  @override
  List<Object?> get props => [name, url];
}

class Trigger extends Equatable {
  final String name;
  final String url;

  const Trigger({required this.name, required this.url});

  @override
  List<Object?> get props => [name, url];
}
