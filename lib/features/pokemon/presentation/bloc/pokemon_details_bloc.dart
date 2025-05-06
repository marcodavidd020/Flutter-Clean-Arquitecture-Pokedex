import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex_application/core/error/failures.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex_application/features/pokemon/domain/usecases/get_pokemon_details.dart';

part 'pokemon_details_event.dart';
part 'pokemon_details_state.dart';

class PokemonDetailsBloc
    extends Bloc<PokemonDetailsEvent, PokemonDetailsState> {
  final GetPokemonDetails getPokemonDetails;

  PokemonDetailsBloc({required this.getPokemonDetails})
    : super(PokemonDetailsInitial()) {
    on<FetchPokemonDetails>(_onFetchPokemonDetails);
  }

  Future<void> _onFetchPokemonDetails(
    FetchPokemonDetails event,
    Emitter<PokemonDetailsState> emit,
  ) async {
    emit(PokemonDetailsLoading());

    final result = await getPokemonDetails(Params(nameOrId: event.nameOrId));

    result.fold(
      (failure) => emit(PokemonDetailsError(_mapFailureToMessage(failure))),
      (pokemon) => emit(PokemonDetailsLoaded(pokemon)),
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
