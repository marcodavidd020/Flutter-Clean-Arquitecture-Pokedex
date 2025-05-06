import 'package:dartz/dartz.dart';
import 'package:pokedex_application/core/error/exceptions.dart';
import 'package:pokedex_application/core/error/failures.dart';
import 'package:pokedex_application/core/network/network_info.dart';
import 'package:pokedex_application/features/pokemon/data/datasources/pokemon_remote_data_source.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon_list_response.dart';
import 'package:pokedex_application/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:pokedex_application/features/pokemon/data/models/evolution_chain_model.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PokemonRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, PokemonListResponse>> getPokemonList({
    int offset = 0,
    int limit = 20,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteList = await remoteDataSource.getPokemonList(
          offset: offset,
          limit: limit,
        );
        return Right(remoteList);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(message: e.message, statusCode: e.statusCode),
        );
      } on NetworkException catch (e) {
        return Left(NetworkFailure(message: e.message));
      } catch (e) {
        return Left(UnknownFailure(message: e.toString()));
      }
    } else {
      return const Left(NetworkFailure(message: 'No hay conexión a internet'));
    }
  }

  @override
  Future<Either<Failure, Pokemon>> getPokemonDetails(String nameOrId) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePokemon = await remoteDataSource.getPokemonDetails(
          nameOrId,
        );
        return Right(remotePokemon);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(message: e.message, statusCode: e.statusCode),
        );
      } on NetworkException catch (e) {
        return Left(NetworkFailure(message: e.message));
      } catch (e) {
        return Left(UnknownFailure(message: e.toString()));
      }
    } else {
      return const Left(NetworkFailure(message: 'No hay conexión a internet'));
    }
  }

  @override
  Future<Either<Failure, EvolutionChainModel>> getPokemonEvolutionChain(int pokemonId) async {
    if (await networkInfo.isConnected) {
      try {
        final evolutionChain = await remoteDataSource.getPokemonEvolutionChain(pokemonId);
        return Right(evolutionChain);
      } on ServerException catch (e) {
        return Left(ServerFailure(
          message: e.message,
          statusCode: e.statusCode,
        ));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(message: e.message));
      } catch (e) {
        return Left(UnknownFailure(message: e.toString()));
      }
    } else {
      return const Left(NetworkFailure(
        message: 'No hay conexión a internet',
      ));
    }
  }

  @override
  Future<Either<Failure, List<Pokemon>>> getPokemonListWithDetails({
    int offset = 0,
    int limit = 20,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final pokemonList = await remoteDataSource.getPokemonListWithDetails(
          offset: offset,
          limit: limit,
        );
        return Right(pokemonList);
      } on ServerException catch (e) {
        return Left(ServerFailure(
          message: e.message,
          statusCode: e.statusCode,
        ));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(message: e.message));
      } catch (e) {
        return Left(UnknownFailure(message: e.toString()));
      }
    } else {
      return const Left(NetworkFailure(
        message: 'No hay conexión a internet',
      ));
    }
  }
}
