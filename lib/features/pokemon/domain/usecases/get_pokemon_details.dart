import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex_application/core/error/failures.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex_application/features/pokemon/domain/repositories/pokemon_repository.dart';

class GetPokemonDetails {
  final PokemonRepository repository;

  GetPokemonDetails({required this.repository});

  Future<Either<Failure, Pokemon>> call(Params params) async {
    return await repository.getPokemonDetails(params.nameOrId);
  }
}

class Params extends Equatable {
  final String nameOrId;

  const Params({required this.nameOrId});

  @override
  List<Object> get props => [nameOrId];
}
