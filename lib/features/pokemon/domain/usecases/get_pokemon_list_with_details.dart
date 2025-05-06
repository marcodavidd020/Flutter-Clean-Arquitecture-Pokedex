import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex_application/core/error/failures.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex_application/features/pokemon/domain/repositories/pokemon_repository.dart';

class GetPokemonListWithDetails {
  final PokemonRepository repository;

  GetPokemonListWithDetails({required this.repository});

  Future<Either<Failure, List<Pokemon>>> call(Params params) async {
    return await repository.getPokemonListWithDetails(
      offset: params.offset,
      limit: params.limit,
    );
  }
}

class Params extends Equatable {
  final int offset;
  final int limit;

  const Params({this.offset = 0, this.limit = 20});

  @override
  List<Object> get props => [offset, limit];
}
