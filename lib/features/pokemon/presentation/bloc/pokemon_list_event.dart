part of 'pokemon_list_bloc.dart';

abstract class PokemonListEvent extends Equatable {
  const PokemonListEvent();

  @override
  List<Object> get props => [];
}

class FetchPokemonList extends PokemonListEvent {
  final int limit;

  const FetchPokemonList({this.limit = 20});

  @override
  List<Object> get props => [limit];
}

class LoadMorePokemon extends PokemonListEvent {
  final int limit;

  const LoadMorePokemon({this.limit = 20});

  @override
  List<Object> get props => [limit];
}
