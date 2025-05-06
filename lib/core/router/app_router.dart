import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex_application/features/pokemon/presentation/pages/home_page.dart';
import 'package:pokedex_application/features/pokemon/presentation/pages/pokemon_detail_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: 'pokemon/:id',
            name: 'pokemon_detail',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              final pokemon = state.extra as Pokemon?;
              return PokemonDetailPage(
                pokemonId: id,
                initialPokemon: pokemon,
              );
            },
          ),
        ],
      ),
    ],
    errorBuilder:
        (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: Center(child: Text('Página no encontrada: ${state.error}')),
        ),
  );
}
