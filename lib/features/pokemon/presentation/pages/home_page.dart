import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex_application/features/pokemon/presentation/bloc/pokemon_list_with_details_bloc.dart';
import 'package:pokedex_application/features/pokemon/presentation/bloc/pokemon_list_with_details_event.dart';
import 'package:pokedex_application/features/pokemon/presentation/bloc/pokemon_list_with_details_state.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/home/pokemon_app_bar.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/home/pokemon_bokeball_background.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/home/pokemon_grid.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/home/pokemon_grid_loading_view.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/home/pokemon_home_app_bar.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/home/pokemon_search_bar.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/pokemon_error_view.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/home/pokemon_loading_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();
  late AnimationController _animationController;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PokemonListWithDetailsBloc>().add(
      const FetchPokemonListWithDetails(limit: 40),
    );
    _scrollController.addListener(_onScroll);

    // Configura la animación
    _animationController = AnimationController(
      duration: PresentationConstants.animationXLong,
      vsync: this,
    );

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<PokemonListWithDetailsBloc>().add(
        const LoadMorePokemonWithDetails(limit: 30),
      );
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;

    return currentScroll >= (maxScroll * 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonListWithDetailsBloc, PokemonListWithDetailsState>(
      builder: (context, state) {
        if (state is PokemonListWithDetailsInitial ||
            (state is PokemonListWithDetailsLoading && !state.hasInitialData)) {
          return _buildScaffoldWithBackground(
            body: const PokemonGridLoadingView(),
            withActions: false,
          );
        } else if (state is PokemonListWithDetailsLoaded ||
            state is PokemonListWithDetailsLoadingMore ||
            (state is PokemonListWithDetailsLoading && state.hasInitialData)) {
          List<Pokemon> pokemons = [];
          bool isLoadingMore = false;

          if (state is PokemonListWithDetailsLoaded) {
            pokemons = state.pokemons;
          } else if (state is PokemonListWithDetailsLoadingMore) {
            pokemons = state.pokemons;
            isLoadingMore = true;
          } else if (state is PokemonListWithDetailsLoading &&
              state.hasInitialData) {
            pokemons = state.initialPokemons;
          }

          return _buildScaffoldWithBackground(
            body: _buildMainContent(pokemons, isLoadingMore),
            withActions: true,
          );
        } else if (state is PokemonListWithDetailsError) {
          return _buildScaffoldWithBackground(
            body: PokemonErrorView(
              message: state.message,
              onRetry: () {
                context.read<PokemonListWithDetailsBloc>().add(
                  const FetchPokemonListWithDetails(),
                );
              },
            ),
            withActions: false,
          );
        }

        return const SizedBox.shrink();
        // return _buildScaffoldWithBackground(
        //   body: const PokemonGridLoadingView(),
        //   withActions: false,
        // );
      },
    );
  }

  Widget _buildScaffoldWithBackground({
    required Widget body,
    required bool withActions,
  }) {
    return Scaffold(
      backgroundColor: PresentationConstants.backgroundColor,
      // Eliminamos el AppBar para controlar el espacio completo
      body: Stack(
        children: [
          // Imagen de fondo (Pokeball) - ahora en la parte superior real
          const PokemonPokeballBackground(),
          // SafeArea para asegurar que el contenido no se superponga con el notch o la barra de estado
          SafeArea(
            child: Column(
              children: [
                // Espacio para los iconos de acción solo cuando es necesario
                if (withActions) const HomeAppBar(),
                // Contenido principal
                Expanded(child: body),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(List<Pokemon> pokemons, bool isLoadingMore) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: PresentationConstants.paddingXLarge,
      ),
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          const PokemonHomeTitle(),
          PokemonSearchBar(searchController: _searchController),
          const SliverToBoxAdapter(
            child: SizedBox(height: PresentationConstants.paddingXLarge),
          ),
          PokemonGrid(
            pokemons: pokemons,
            isLoadingMore: isLoadingMore,
            animationController: _animationController,
            onPokemonTap: (pokemon) {
              context.goNamed(
                'pokemon_detail',
                pathParameters: {'id': pokemon.id.toString()},
                extra: pokemon,
              );
            },
          ),
        ],
      ),
    );
  }
}
