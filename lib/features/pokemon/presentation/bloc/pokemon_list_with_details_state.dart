import 'package:equatable/equatable.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon.dart';

abstract class PokemonListWithDetailsState extends Equatable {
  const PokemonListWithDetailsState();

  @override
  List<Object?> get props => [];
}

class PokemonListWithDetailsInitial extends PokemonListWithDetailsState {}

class PokemonListWithDetailsLoading extends PokemonListWithDetailsState {
  final bool hasInitialData;
  final List<Pokemon> initialPokemons;

  const PokemonListWithDetailsLoading({
    this.hasInitialData = false,
    this.initialPokemons = const [],
  });

  @override
  List<Object?> get props => [hasInitialData, initialPokemons];
}

class PokemonListWithDetailsLoaded extends PokemonListWithDetailsState {
  final List<Pokemon> pokemons;
  final bool hasReachedMax;
  final int offset;

  const PokemonListWithDetailsLoaded({
    required this.pokemons,
    required this.hasReachedMax,
    required this.offset,
  });

  @override
  List<Object?> get props => [pokemons, hasReachedMax, offset];
}

class PokemonListWithDetailsLoadingMore extends PokemonListWithDetailsState {
  final List<Pokemon> pokemons;
  final int offset;

  const PokemonListWithDetailsLoadingMore({
    required this.pokemons,
    required this.offset,
  });

  @override
  List<Object?> get props => [pokemons, offset];
}

class PokemonListWithDetailsError extends PokemonListWithDetailsState {
  final String message;

  const PokemonListWithDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
