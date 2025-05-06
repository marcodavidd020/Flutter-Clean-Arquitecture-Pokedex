import 'package:dio/dio.dart';
import 'package:pokedex_application/core/constants/api_constants.dart';
import 'package:pokedex_application/core/error/exceptions.dart';
import 'package:pokedex_application/core/network/dio_client.dart';
import 'package:pokedex_application/features/pokemon/data/models/pokemon_list_response_model.dart';
import 'package:pokedex_application/features/pokemon/data/models/pokemon_model.dart';
import 'package:pokedex_application/features/pokemon/data/models/evolution_chain_model.dart';

abstract class PokemonRemoteDataSource {
  Future<PokemonListResponseModel> getPokemonList({
    int offset = 0,
    int limit = 20,
  });
  Future<PokemonModel> getPokemonDetails(String nameOrId);
  Future<EvolutionChainModel> getPokemonEvolutionChain(int pokemonId);
  Future<List<PokemonModel>> getPokemonListWithDetails({
    int offset = 0,
    int limit = 20,
  });
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final DioClient dioClient;

  PokemonRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<PokemonListResponseModel> getPokemonList({
    int offset = 0,
    int limit = 20,
  }) async {
    try {
      final response = await dioClient.get(
        ApiConstants.pokemonEndpoint,
        queryParameters: {'offset': offset, 'limit': limit},
      );

      return PokemonListResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error al obtener la lista de Pokémon',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }

  @override
  Future<PokemonModel> getPokemonDetails(String nameOrId) async {
    try {
      final response = await dioClient.get(
        '${ApiConstants.pokemonEndpoint}/$nameOrId',
      );

      return PokemonModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error al obtener los detalles del Pokémon',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }

  @override
  Future<EvolutionChainModel> getPokemonEvolutionChain(int pokemonId) async {
    try {
      // Primero obtenemos la especie del Pokémon que contiene la URL de la cadena evolutiva
      final speciesResponse = await dioClient.get(
        '${ApiConstants.speciesEndpoint}/$pokemonId',
      );
      final String evolutionChainUrl =
          speciesResponse.data['evolution_chain']['url'];

      // Extraemos el ID de la cadena evolutiva de la URL
      final evolutionChainId = int.parse(evolutionChainUrl.split('/')[6]);

      // Obtenemos los datos de la cadena evolutiva
      final evolutionResponse = await dioClient.get(
        '${ApiConstants.evolutionChainEndpoint}/$evolutionChainId',
      );

      return EvolutionChainModel.fromJson(evolutionResponse.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error al obtener la cadena evolutiva',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }

  @override
  Future<List<PokemonModel>> getPokemonListWithDetails({
    int offset = 0,
    int limit = 20,
  }) async {
    try {
      // Primero obtenemos la lista básica de Pokémon
      final listResponse = await getPokemonList(offset: offset, limit: limit);
      
      // Luego hacemos llamadas paralelas para obtener los detalles de cada Pokémon
      final detailsFutures = listResponse.results.map((pokemon) {
        final pokemonId = _extractPokemonIdFromUrl(pokemon.url);
        return getPokemonDetails(pokemonId);
      }).toList();
      
      // Esperamos a que todas las llamadas se completen
      final detailsResults = await Future.wait(detailsFutures);
      
      return detailsResults;
    } on ServerException catch (e) {
      throw ServerException(
        message: e.message,
        statusCode: e.statusCode,
      );
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }

  // Método auxiliar para extraer el ID del Pokémon desde su URL
  String _extractPokemonIdFromUrl(String url) {
    // La URL tiene el formato: "https://pokeapi.co/api/v2/pokemon/1/"
    final uri = Uri.parse(url);
    final pathSegments = uri.pathSegments;
    // El ID es el último segmento no vacío antes del posible trailing slash
    return pathSegments.where((segment) => segment.isNotEmpty).last;
  }
}
