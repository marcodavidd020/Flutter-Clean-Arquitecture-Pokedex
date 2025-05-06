part of 'pokemon_details_bloc.dart';

abstract class PokemonDetailsEvent extends Equatable {
  const PokemonDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchPokemonDetails extends PokemonDetailsEvent {
  final String nameOrId;

  const FetchPokemonDetails(this.nameOrId);

  @override
  List<Object> get props => [nameOrId];
}
