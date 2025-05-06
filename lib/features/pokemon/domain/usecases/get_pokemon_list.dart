import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex_application/core/error/failures.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon_list_response.dart';
import 'package:pokedex_application/features/pokemon/domain/repositories/pokemon_repository.dart';

class GetPokemonList {
  final PokemonRepository repository;

  GetPokemonList({required this.repository});

  Future<Either<Failure, PokemonListResponse>> call(Params params) async {
    return await repository.getPokemonList(
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
