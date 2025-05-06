import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex_application/core/error/failures.dart';
import 'package:pokedex_application/features/pokemon/domain/usecases/get_pokemon_evolution_chain.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon_evolution_chain.dart';

part 'pokemon_evolution_event.dart';
part 'pokemon_evolution_state.dart';

class PokemonEvolutionBloc
    extends Bloc<PokemonEvolutionEvent, PokemonEvolutionState> {
  final GetPokemonEvolutionChain getPokemonEvolutionChain;

  PokemonEvolutionBloc({required this.getPokemonEvolutionChain})
    : super(PokemonEvolutionInitial()) {
    on<FetchPokemonEvolution>(_onFetchPokemonEvolution);
  }

  Future<void> _onFetchPokemonEvolution(
    FetchPokemonEvolution event,
    Emitter<PokemonEvolutionState> emit,
  ) async {
    emit(PokemonEvolutionLoading());

    final result = await getPokemonEvolutionChain(Params(pokemonId: event.pokemonId));

    result.fold(
      (failure) => emit(PokemonEvolutionError(_mapFailureToMessage(failure))),
      (evolutionChainModel) {
        try {
          final evolutionChain = evolutionChainModel.toEntity();
          emit(PokemonEvolutionLoaded(evolutionChain));
        } catch (e) {
          emit(PokemonEvolutionError('Error al procesar la cadena evolutiva: $e'));
        }
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return failure.message;
      case NetworkFailure:
        return failure.message;
      default:
        return 'Error inesperado';
    }
  }
}
