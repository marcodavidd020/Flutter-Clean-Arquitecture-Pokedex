part of 'pokemon_evolution_bloc.dart';

abstract class PokemonEvolutionState extends Equatable {
  const PokemonEvolutionState();

  @override
  List<Object?> get props => [];
}

class PokemonEvolutionInitial extends PokemonEvolutionState {}

class PokemonEvolutionLoading extends PokemonEvolutionState {}

class PokemonEvolutionLoaded extends PokemonEvolutionState {
  final EvolutionChain evolutionChain;

  const PokemonEvolutionLoaded(this.evolutionChain);

  @override
  List<Object?> get props => [evolutionChain];
}

class PokemonEvolutionError extends PokemonEvolutionState {
  final String message;

  const PokemonEvolutionError(this.message);

  @override
  List<Object?> get props => [message];
}
