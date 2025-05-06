import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_application/core/error/failures.dart';
import 'package:pokedex_application/features/pokemon/domain/usecases/get_pokemon_list_with_details.dart';
import 'package:pokedex_application/features/pokemon/presentation/bloc/pokemon_list_with_details_event.dart';
import 'package:pokedex_application/features/pokemon/presentation/bloc/pokemon_list_with_details_state.dart';

class PokemonListWithDetailsBloc
    extends Bloc<PokemonListWithDetailsEvent, PokemonListWithDetailsState> {
  final GetPokemonListWithDetails getPokemonListWithDetails;

  PokemonListWithDetailsBloc({required this.getPokemonListWithDetails})
    : super(PokemonListWithDetailsInitial()) {
    on<FetchPokemonListWithDetails>(_onFetchPokemonListWithDetails);
    on<LoadMorePokemonWithDetails>(_onLoadMorePokemonWithDetails);
  }

  Future<void> _onFetchPokemonListWithDetails(
    FetchPokemonListWithDetails event,
    Emitter<PokemonListWithDetailsState> emit,
  ) async {
    emit(const PokemonListWithDetailsLoading());

    final result = await getPokemonListWithDetails(
      Params(offset: 0, limit: event.limit),
    );

    result.fold(
      (failure) =>
          emit(PokemonListWithDetailsError(_mapFailureToMessage(failure))),
      (pokemons) => emit(
        PokemonListWithDetailsLoaded(
          pokemons: pokemons,
          hasReachedMax:
              pokemons
                  .isEmpty, // Si no hay pokémon, entonces ya alcanzamos el máximo
          offset: 0,
        ),
      ),
    );
  }

  Future<void> _onLoadMorePokemonWithDetails(
    LoadMorePokemonWithDetails event,
    Emitter<PokemonListWithDetailsState> emit,
  ) async {
    if (state is PokemonListWithDetailsLoaded) {
      final currentState = state as PokemonListWithDetailsLoaded;

      if (currentState.hasReachedMax) return;

      final newOffset = currentState.offset + event.limit;

      emit(
        PokemonListWithDetailsLoadingMore(
          pokemons: currentState.pokemons,
          offset: currentState.offset,
        ),
      );

      final result = await getPokemonListWithDetails(
        Params(offset: newOffset, limit: event.limit),
      );

      result.fold(
        (failure) =>
            emit(PokemonListWithDetailsError(_mapFailureToMessage(failure))),
        (newPokemons) {
          // Si no hay nuevos Pokémon, hemos alcanzado el final
          final hasReachedMax = newPokemons.isEmpty;

          final allPokemons = [...currentState.pokemons, ...newPokemons];

          emit(
            PokemonListWithDetailsLoaded(
              pokemons: allPokemons,
              hasReachedMax: hasReachedMax,
              offset: newOffset,
            ),
          );
        },
      );
    }
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
