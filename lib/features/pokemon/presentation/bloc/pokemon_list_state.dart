part of 'pokemon_list_bloc.dart';

abstract class PokemonListState extends Equatable {
  const PokemonListState();

  @override
  List<Object?> get props => [];
}

class PokemonListInitial extends PokemonListState {}

class PokemonListLoading extends PokemonListState {
  final bool hasInitialData;
  final List<PokemonListItem> initialPokemons;

  const PokemonListLoading({
    this.hasInitialData = false,
    this.initialPokemons = const [],
  });

  @override
  List<Object?> get props => [hasInitialData, initialPokemons];
}

class PokemonListLoaded extends PokemonListState {
  final List<PokemonListItem> pokemons;
  final bool hasReachedMax;
  final String? next;
  final int offset;

  const PokemonListLoaded({
    required this.pokemons,
    required this.hasReachedMax,
    this.next,
    required this.offset,
  });

  @override
  List<Object?> get props => [pokemons, hasReachedMax, next, offset];
}

class PokemonListLoadingMore extends PokemonListState {
  final List<PokemonListItem> pokemons;
  final String? next;
  final int offset;

  const PokemonListLoadingMore({
    required this.pokemons,
    this.next,
    required this.offset,
  });

  @override
  List<Object?> get props => [pokemons, next, offset];
}

class PokemonListError extends PokemonListState {
  final String message;

  const PokemonListError(this.message);

  @override
  List<Object> get props => [message];
}
