import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex_application/core/error/failures.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon_list_response.dart';
import 'package:pokedex_application/features/pokemon/domain/usecases/get_pokemon_list.dart';

part 'pokemon_list_event.dart';
part 'pokemon_list_state.dart';

class PokemonListBloc extends Bloc<PokemonListEvent, PokemonListState> {
  final GetPokemonList getPokemonList;

  PokemonListBloc({required this.getPokemonList})
    : super(PokemonListInitial()) {
    on<FetchPokemonList>(_onFetchPokemonList);
    on<LoadMorePokemon>(_onLoadMorePokemon);
  }

  Future<void> _onFetchPokemonList(
    FetchPokemonList event,
    Emitter<PokemonListState> emit,
  ) async {
    emit(PokemonListLoading());

    final result = await getPokemonList(Params(offset: 0, limit: event.limit));

    result.fold(
      (failure) => emit(PokemonListError(_mapFailureToMessage(failure))),
      (data) => emit(
        PokemonListLoaded(
          pokemons: data.results,
          hasReachedMax: false,
          next: data.next,
          offset: 0,
        ),
      ),
    );

    if (state is PokemonListLoaded) {
      emit(PokemonListLoading(
        hasInitialData: true,
        initialPokemons: (state as PokemonListLoaded).pokemons,
      ));
    }
  }

  Future<void> _onLoadMorePokemon(
    LoadMorePokemon event,
    Emitter<PokemonListState> emit,
  ) async {
    if (state is PokemonListLoaded) {
      final currentState = state as PokemonListLoaded;

      if (currentState.hasReachedMax) return;

      final newOffset = currentState.offset + event.limit;

      emit(
        PokemonListLoadingMore(
          pokemons: currentState.pokemons,
          offset: currentState.offset,
          next: currentState.next,
        ),
      );

      final result = await getPokemonList(Params(offset: newOffset, limit: event.limit));

      result.fold(
        (failure) => emit(PokemonListError(_mapFailureToMessage(failure))),
        (data) {
          final allPokemons = [...currentState.pokemons, ...data.results];

          emit(
            PokemonListLoaded(
              pokemons: allPokemons,
              hasReachedMax: data.next == null,
              next: data.next,
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
