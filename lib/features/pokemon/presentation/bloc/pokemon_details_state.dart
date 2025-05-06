part of 'pokemon_details_bloc.dart';

abstract class PokemonDetailsState extends Equatable {
  const PokemonDetailsState();

  @override
  List<Object> get props => [];
}

class PokemonDetailsInitial extends PokemonDetailsState {}

class PokemonDetailsLoading extends PokemonDetailsState {}

class PokemonDetailsLoaded extends PokemonDetailsState {
  final Pokemon pokemon;

  const PokemonDetailsLoaded(this.pokemon);

  @override
  List<Object> get props => [pokemon];
}

class PokemonDetailsError extends PokemonDetailsState {
  final String message;

  const PokemonDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
