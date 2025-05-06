import 'package:equatable/equatable.dart';

class PokemonListResponse extends Equatable {
  final int count;
  final String? next;
  final String? previous;
  final List<PokemonListItem> results;

  const PokemonListResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  @override
  List<Object?> get props => [count, next, previous, results];
}

class PokemonListItem extends Equatable {
  final String name;
  final String url;

  // Campos calculados
  final int id;
  final String imageUrl;

  PokemonListItem({required this.name, required this.url})
    : id = int.parse(url.split('/')[6]),
      imageUrl =
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${int.parse(url.split('/')[6])}.png';

  @override
  List<Object> get props => [name, url, id, imageUrl];
}
