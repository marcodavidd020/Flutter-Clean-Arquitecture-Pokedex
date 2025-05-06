part of 'pokemon_evolution_bloc.dart';

abstract class PokemonEvolutionEvent extends Equatable {
  const PokemonEvolutionEvent();

  @override
  List<Object> get props => [];
}

class FetchPokemonEvolution extends PokemonEvolutionEvent {
  final int pokemonId;

  const FetchPokemonEvolution(this.pokemonId);

  @override
  List<Object> get props => [pokemonId];
}
