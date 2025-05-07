import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pokedex_application/core/network/dio_client.dart';
import 'package:pokedex_application/core/network/network_info.dart';
import 'package:pokedex_application/features/pokemon/data/datasources/pokemon_remote_data_source.dart';
import 'package:pokedex_application/features/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'package:pokedex_application/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:pokedex_application/features/pokemon/domain/usecases/get_pokemon_details.dart';
import 'package:pokedex_application/features/pokemon/domain/usecases/get_pokemon_list.dart';
import 'package:pokedex_application/features/pokemon/domain/usecases/get_pokemon_evolution_chain.dart';
import 'package:pokedex_application/features/pokemon/domain/usecases/get_pokemon_list_with_details.dart';
import 'package:pokedex_application/features/pokemon/presentation/bloc/pokemon_details_bloc.dart';
import 'package:pokedex_application/features/pokemon/presentation/bloc/pokemon_list_bloc.dart';
import 'package:pokedex_application/features/pokemon/presentation/bloc/pokemon_evolution/pokemon_evolution_bloc.dart';
import 'package:pokedex_application/features/pokemon/presentation/bloc/pokemon_list_with_details_bloc.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // Características - Pokemon

  // BLoC
  sl.registerFactory(() => PokemonListBloc(getPokemonList: sl()));

  sl.registerFactory(() => PokemonDetailsBloc(getPokemonDetails: sl()));

  sl.registerFactory(() => PokemonEvolutionBloc());
  
  sl.registerFactory(() => PokemonListWithDetailsBloc(getPokemonListWithDetails: sl()));

  // Casos de uso
  sl.registerLazySingleton(() => GetPokemonList(repository: sl()));
  sl.registerLazySingleton(() => GetPokemonDetails(repository: sl()));
  sl.registerLazySingleton(() => GetPokemonEvolutionChain(repository: sl()));
  sl.registerLazySingleton(() => GetPokemonListWithDetails(repository: sl()));

  // Repositorios
  sl.registerLazySingleton<PokemonRepository>(
    () => PokemonRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Fuentes de datos
  sl.registerLazySingleton<PokemonRemoteDataSource>(
    () => PokemonRemoteDataSourceImpl(dioClient: sl()),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton(() => DioClient(
    dio: sl(), 
    networkInfo: sl(),
    // Activar para desarrollo si hay problemas con la verificación de conectividad
    debugSkipConnectionCheck: false,
  ));

  // Dependencias externas
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
}
