import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon_evolution_chain.dart';
import 'package:pokedex_application/features/pokemon/presentation/bloc/pokemon_evolution/pokemon_evolution_bloc.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/detail/body/pokemon_evolution_redesigned.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/detail/body/pokemon_section_title.dart';

class PokemonEvolutionSection extends StatelessWidget {
  final Pokemon pokemon;
  final Color mainType;
  final Function(Pokemon) onPokemonTap;

  const PokemonEvolutionSection({
    super.key,
    required this.pokemon,
    required this.mainType,
    required this.onPokemonTap,
  });

  @override
  Widget build(BuildContext context) {
    // Recargar la cadena de evolución si es necesario
    _refreshEvolutionChainIfNeeded(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: PokemonSectionTitle(
            title: AppTexts.evolutionsTitle,
            color: mainType,
          ),
        ),
        const SizedBox(height: 8),
        BlocBuilder<PokemonEvolutionBloc, PokemonEvolutionState>(
          builder: (context, state) {
            if (state is PokemonEvolutionLoading) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is PokemonEvolutionLoaded) {
              return _buildEvolutionChain(state.evolutionChain);
            } else if (state is PokemonEvolutionError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.red.shade300,
                        size: 48,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        AppTexts.noEvolutionsErrorMessage,
                        style: TextStyle(
                          color: Colors.red.shade300,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () => _refreshEvolutionChain(context),
                        child: Text(AppTexts.retryText),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildEvolutionChain(PokemonEvolutionChain evolutionChain) {
    if (evolutionChain.chain.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            AppTexts.noEvolutionsMessage,
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      );
    }

    // Convertir el callback para que sea compatible con la API esperada
    void onPokemonIdTap(int id) {
      // Encuentra el Pokémon por ID y llama a onPokemonTap
      final pokemonList = evolutionChain.chain;
      for (var pokemon in pokemonList) {
        if (pokemon.id == id) {
          onPokemonTap(pokemon);
          break;
        }
      }
    }

    // Construir la estructura de evolución adaptada
    List<ChainLink> evolvesToList = [];

    // Añadir evoluciones si existen
    if (evolutionChain.chain.length > 1) {
      for (int i = 1; i < evolutionChain.chain.length; i++) {
        Pokemon evoPokemon = evolutionChain.chain[i];
        PokemonSpecies evoSpecies = PokemonSpecies(
          id: evoPokemon.id,
          name: evoPokemon.name,
          url: '',
          imageUrl: evoPokemon.imageUrl,
        );

        ChainLink evoLink = ChainLink(
          evolvesTo: [],
          evolutionDetails: [EvolutionDetail(minLevel: 16)],
          species: evoSpecies,
        );

        evolvesToList.add(evoLink);
      }
    }

    // Construir un ChainLink para el primer Pokémon en la cadena
    PokemonSpecies firstSpecies = PokemonSpecies(
      id: evolutionChain.chain[0].id,
      name: evolutionChain.chain[0].name,
      url: '',
      imageUrl: evolutionChain.chain[0].imageUrl,
    );

    ChainLink chainLink = ChainLink(
      evolvesTo: evolvesToList,
      evolutionDetails: [],
      species: firstSpecies,
    );

    return PokemonEvolutionRedesigned(
      evolutionChain: EvolutionChain(chain: chainLink),
      onPokemonTap: onPokemonIdTap,
      mainType: pokemon.types.first,
    );
  }

  void _refreshEvolutionChainIfNeeded(BuildContext context) {
    final state = context.read<PokemonEvolutionBloc>().state;
    if (state is PokemonEvolutionInitial) {
      _refreshEvolutionChain(context);
    }
  }

  void _refreshEvolutionChain(BuildContext context) {
    context.read<PokemonEvolutionBloc>().add(
      LoadPokemonEvolutionChain(pokemon.id),
    );
  }
}
