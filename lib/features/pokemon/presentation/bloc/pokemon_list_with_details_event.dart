import 'package:equatable/equatable.dart';

abstract class PokemonListWithDetailsEvent extends Equatable {
  const PokemonListWithDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchPokemonListWithDetails extends PokemonListWithDetailsEvent {
  final int limit;

  const FetchPokemonListWithDetails({this.limit = 20});

  @override
  List<Object> get props => [limit];
}

class LoadMorePokemonWithDetails extends PokemonListWithDetailsEvent {
  final int limit;

  const LoadMorePokemonWithDetails({this.limit = 20});

  @override
  List<Object> get props => [limit];
}
