import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_application/core/constants/app_constants.dart';
import 'package:pokedex_application/core/router/app_router.dart';
import 'package:pokedex_application/core/services/service_locator.dart';
import 'package:pokedex_application/core/theme/app_theme.dart';
import 'package:pokedex_application/features/pokemon/presentation/bloc/pokemon_details_bloc.dart';
import 'package:pokedex_application/features/pokemon/presentation/bloc/pokemon_evolution_bloc.dart';
import 'package:pokedex_application/features/pokemon/presentation/bloc/pokemon_list_bloc.dart';
import 'package:pokedex_application/features/pokemon/presentation/bloc/pokemon_list_with_details_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar el inyector de dependencias
  await initServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PokemonListBloc>(create: (_) => sl<PokemonListBloc>()),
        BlocProvider<PokemonDetailsBloc>(
          create: (_) => sl<PokemonDetailsBloc>(),
        ),
        BlocProvider<PokemonEvolutionBloc>(
          create: (_) => sl<PokemonEvolutionBloc>(),
        ),
        BlocProvider<PokemonListWithDetailsBloc>(
          create: (_) => sl<PokemonListWithDetailsBloc>(),
        ),
      ],
      child: MaterialApp.router(
        title: AppConstants.appName,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
