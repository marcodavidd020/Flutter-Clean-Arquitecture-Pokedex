import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon_evolution_chain.dart';

// Events
abstract class PokemonEvolutionEvent extends Equatable {
  const PokemonEvolutionEvent();

  @override
  List<Object> get props => [];
}

class LoadPokemonEvolutionChain extends PokemonEvolutionEvent {
  final int pokemonId;

  const LoadPokemonEvolutionChain(this.pokemonId);

  @override
  List<Object> get props => [pokemonId];
}

// States
abstract class PokemonEvolutionState extends Equatable {
  const PokemonEvolutionState();

  @override
  List<Object> get props => [];
}

class PokemonEvolutionInitial extends PokemonEvolutionState {}

class PokemonEvolutionLoading extends PokemonEvolutionState {}

class PokemonEvolutionLoaded extends PokemonEvolutionState {
  final PokemonEvolutionChain evolutionChain;

  const PokemonEvolutionLoaded(this.evolutionChain);

  @override
  List<Object> get props => [evolutionChain];
}

class PokemonEvolutionError extends PokemonEvolutionState {
  final String message;

  const PokemonEvolutionError(this.message);

  @override
  List<Object> get props => [message];
}

// Bloc
class PokemonEvolutionBloc extends Bloc<PokemonEvolutionEvent, PokemonEvolutionState> {
  PokemonEvolutionBloc() : super(PokemonEvolutionInitial()) {
    on<LoadPokemonEvolutionChain>(_onLoadPokemonEvolutionChain);
  }

  Future<void> _onLoadPokemonEvolutionChain(
    LoadPokemonEvolutionChain event,
    Emitter<PokemonEvolutionState> emit,
  ) async {
    try {
      emit(PokemonEvolutionLoading());
      
      // Simulamos una carga asíncrona
      await Future.delayed(const Duration(milliseconds: 1500));
      
      // Crear datos de evolución de prueba basados en el ID
      final evolutionChain = _createMockEvolutionChain(event.pokemonId);
      
      emit(PokemonEvolutionLoaded(evolutionChain));
    } catch (e) {
      emit(PokemonEvolutionError(e.toString()));
    }
  }
  
  // Método para generar datos de evolución de prueba
  PokemonEvolutionChain _createMockEvolutionChain(int pokemonId) {
    if (pokemonId >= 1 && pokemonId <= 3) {
      // Línea de evolución Bulbasaur
      return PokemonEvolutionChain(
        chain: [
          Pokemon(
            id: 1,
            name: 'Bulbasaur',
            imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
            types: ['grass', 'poison'],
            height: 7,
            weight: 69,
            stats: [],
          ),
          Pokemon(
            id: 2,
            name: 'Ivysaur',
            imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/2.png',
            types: ['grass', 'poison'],
            height: 10,
            weight: 130,
            stats: [],
          ),
          Pokemon(
            id: 3,
            name: 'Venusaur',
            imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/3.png',
            types: ['grass', 'poison'],
            height: 20,
            weight: 1000,
            stats: [],
          ),
        ],
        evolutionMap: {1: [2], 2: [3]},
      );
    } else if (pokemonId >= 4 && pokemonId <= 6) {
      // Línea de evolución Charmander
      return PokemonEvolutionChain(
        chain: [
          Pokemon(
            id: 4,
            name: 'Charmander',
            imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png',
            types: ['fire'],
            height: 6,
            weight: 85,
            stats: [],
          ),
          Pokemon(
            id: 5,
            name: 'Charmeleon',
            imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/5.png',
            types: ['fire'],
            height: 11,
            weight: 190,
            stats: [],
          ),
          Pokemon(
            id: 6,
            name: 'Charizard',
            imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/6.png',
            types: ['fire', 'flying'],
            height: 17,
            weight: 905,
            stats: [],
          ),
        ],
        evolutionMap: {4: [5], 5: [6]},
      );
    } else if (pokemonId >= 7 && pokemonId <= 9) {
      // Línea de evolución Squirtle
      return PokemonEvolutionChain(
        chain: [
          Pokemon(
            id: 7,
            name: 'Squirtle',
            imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/7.png',
            types: ['water'],
            height: 5,
            weight: 90,
            stats: [],
          ),
          Pokemon(
            id: 8,
            name: 'Wartortle',
            imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/8.png',
            types: ['water'],
            height: 10,
            weight: 225,
            stats: [],
          ),
          Pokemon(
            id: 9,
            name: 'Blastoise',
            imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/9.png',
            types: ['water'],
            height: 16,
            weight: 855,
            stats: [],
          ),
        ],
        evolutionMap: {7: [8], 8: [9]},
      );
    } else if (pokemonId >= 25 && pokemonId <= 26) {
      // Línea de evolución Pikachu
      return PokemonEvolutionChain(
        chain: [
          Pokemon(
            id: 25,
            name: 'Pikachu',
            imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png',
            types: ['electric'],
            height: 4,
            weight: 60,
            stats: [],
          ),
          Pokemon(
            id: 26,
            name: 'Raichu',
            imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/26.png',
            types: ['electric'],
            height: 8,
            weight: 300,
            stats: [],
          ),
        ],
        evolutionMap: {25: [26]},
      );
    } else {
      // Pokémon sin evolución o desconocido
      return PokemonEvolutionChain.empty();
    }
  }
} 