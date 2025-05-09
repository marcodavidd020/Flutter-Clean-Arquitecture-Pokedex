import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:pokedex_application/core/utils/pokemon_type_utils.dart';
import 'package:pokedex_application/core/utils/string_utils.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon_evolution_chain.dart';
import 'package:pokedex_application/features/pokemon/presentation/bloc/pokemon_evolution/pokemon_evolution_bloc.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/detail/header/favorite_button.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/detail/header/pokemon_header_back_button.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/detail/pokemon_detail_header.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/pokemon_detail_content.dart';

class PokemonDetailPage extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonDetailPage({super.key, required this.pokemon});

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  bool _isFavorite = false;
  late final Color mainType;
  bool _isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    // Configurar controlador de animación
    _rotationController = AnimationController(
      duration: PokemonDetailConstants.rotationDuration,
      vsync: this,
    );
    _rotationController.repeat();

    mainType = PokemonTypeUtils.getBackgroundColorForType(
      widget.pokemon.types.first,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Cargar la cadena de evolución solo en la primera carga
    if (_isFirstLoad) {
      _loadEvolutionChain();
      _isFirstLoad = false;
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  void _loadEvolutionChain() {
    final state = context.read<PokemonEvolutionBloc>().state;
    // Solo cargar si no está cargado o si el Pokémon no está en la cadena actual
    if (state is! PokemonEvolutionLoaded) {
      context.read<PokemonEvolutionBloc>().add(
        LoadPokemonEvolutionChain(widget.pokemon.id),
      );
    } else if (!_evolutionChainContainsPokemon(
      state.evolutionChain,
      widget.pokemon.id,
    )) {
      context.read<PokemonEvolutionBloc>().add(
        LoadPokemonEvolutionChain(widget.pokemon.id),
      );
    }
  }

  // Verificar si la cadena de evolución ya contiene este Pokémon
  bool _evolutionChainContainsPokemon(
    PokemonEvolutionChain chain,
    int pokemonId,
  ) {
    return chain.chain.any((pokemon) => pokemon.id == pokemonId);
  }

  void _navigateToPokemon(Pokemon pokemon) {
    if (pokemon.id != widget.pokemon.id) {
      context.pushNamed(
        'pokemon_detail',
        pathParameters: {'id': pokemon.id.toString()},
        extra: pokemon,
      );
    }
  }

  void _handleBackPressed() {
    try {
      context.pop();
    } catch (e) {
      // Si no hay nada que hacer pop, redirigir a la página de inicio
      context.go('/');
    }
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    final snackText =
        _isFavorite
            ? '${widget.pokemon.name} añadido a favoritos'
            : '${widget.pokemon.name} eliminado de favoritos';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(snackText),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        action: SnackBarAction(
          label: 'OK',
          textColor: Theme.of(context).primaryColor,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      leading: PokemonHeaderBackButton(
        onBackPressed: _handleBackPressed,
        context: context,
      ),
      title: Text(
        widget.pokemon.name.capitalize(),
        style: const TextStyle(color: Colors.white),
      ),
      actions: [
        FavoriteButton(
          isFavorite: _isFavorite,
          onPressed: _toggleFavorite,
          backgroundColor: Colors.white,
          iconColor: Colors.red,
        ),
      ],
      headerWidget: PokemonDetailHeader(
        pokemon: widget.pokemon,
        onBackPressed: _handleBackPressed,
        context: context,
      ),
      // headerBottomBar: _buildHeaderBottomBar(),
      body: [
        PokemonDetailContent(
          pokemon: widget.pokemon,
          mainType: mainType,
          onPokemonTap: _navigateToPokemon,
        ),
      ],
      backgroundColor: Colors.grey[50]!,
      appBarColor: mainType,
      curvedBodyRadius: 30,
    );
  }
}
