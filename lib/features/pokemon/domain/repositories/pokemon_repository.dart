import 'package:dartz/dartz.dart';
import 'package:pokedex_application/core/error/failures.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon_list_response.dart';
import 'package:pokedex_application/features/pokemon/data/models/evolution_chain_model.dart';

abstract class PokemonRepository {
  Future<Either<Failure, PokemonListResponse>> getPokemonList({
    int offset = 0,
    int limit = 20,
  });
  Future<Either<Failure, Pokemon>> getPokemonDetails(String nameOrId);
  Future<Either<Failure, EvolutionChainModel>> getPokemonEvolutionChain(int pokemonId);
  Future<Either<Failure, List<Pokemon>>> getPokemonListWithDetails({
    int offset = 0,
    int limit = 20,
  });
}
