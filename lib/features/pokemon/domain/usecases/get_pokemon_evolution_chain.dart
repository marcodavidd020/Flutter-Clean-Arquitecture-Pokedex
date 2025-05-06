import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex_application/core/error/failures.dart';
import 'package:pokedex_application/features/pokemon/data/models/evolution_chain_model.dart';
import 'package:pokedex_application/features/pokemon/domain/repositories/pokemon_repository.dart';

class GetPokemonEvolutionChain {
  final PokemonRepository repository;

  GetPokemonEvolutionChain({required this.repository});

  Future<Either<Failure, EvolutionChainModel>> call(Params params) async {
    return await repository.getPokemonEvolutionChain(params.pokemonId);
  }
}

class Params extends Equatable {
  final int pokemonId;

  const Params({required this.pokemonId});

  @override
  List<Object> get props => [pokemonId];
}
