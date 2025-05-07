import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex_application/features/pokemon/presentation/pages/home_page.dart';
import 'package:pokedex_application/features/pokemon/presentation/pages/pokemon_detail_page.dart';

class AppRouter {
  static const String home = 'home';
  static const String pokemonDetail = 'pokemon_detail';

  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/pokemon/:id',
        name: pokemonDetail,
        builder: (context, state) {
          final pokemon = state.extra as Pokemon?;
          if (pokemon == null) {
            return const Scaffold(
              body: Center(
                child: Text('Error: Pokémon no encontrado'),
              ),
            );
          }
          return PokemonDetailPage(pokemon: pokemon);
        },
      ),
    ],
  );
}
