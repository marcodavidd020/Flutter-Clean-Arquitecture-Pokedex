import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_application/core/constants/app_constants.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex_application/features/pokemon/presentation/bloc/pokemon_list_with_details_bloc.dart';
import 'package:pokedex_application/features/pokemon/presentation/bloc/pokemon_list_with_details_event.dart';
import 'package:pokedex_application/features/pokemon/presentation/bloc/pokemon_list_with_details_state.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/pokemon_card.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/pokemon_error_view.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/pokemon_loading_view.dart';

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
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body:
          BlocBuilder<PokemonListWithDetailsBloc, PokemonListWithDetailsState>(
            builder: (context, state) {
              if (state is PokemonListWithDetailsInitial ||
                  (state is PokemonListWithDetailsLoading &&
                      !state.hasInitialData)) {
                return const PokemonGridLoadingView();
              } else if (state is PokemonListWithDetailsLoaded ||
                  state is PokemonListWithDetailsLoadingMore ||
                  (state is PokemonListWithDetailsLoading &&
                      state.hasInitialData)) {
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

                return _buildMainContent(pokemons, isLoadingMore);
              } else if (state is PokemonListWithDetailsError) {
                return _buildErrorView(
                  PokemonErrorView(
                    message: state.message,
                    onRetry: () {
                      context.read<PokemonListWithDetailsBloc>().add(
                        const FetchPokemonListWithDetails(),
                      );
                    },
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
    );
  }

  Widget _buildErrorView(Widget errorWidget) {
    return Scaffold(
      appBar: AppBar(title: Text(AppConstants.appName)),
      body: errorWidget,
    );
  }

  Widget _buildMainContent(List<Pokemon> pokemons, bool isLoadingMore) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        _buildAppBar(),
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: PresentationConstants.paddingLarge,
          ),
          sliver: _buildSearchBar(),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: PresentationConstants.paddingLarge,
          ),
          sliver: _buildPokemonGrid(pokemons, isLoadingMore),
        ),
      ],
    );
  }

  Widget _buildAppBar() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          PresentationConstants.paddingXLarge,
          48,
          PresentationConstants.paddingXLarge,
          PresentationConstants.paddingMedium,
        ),
        child: Center(
          child: Text(
            AppTexts.appTitle,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE74C3C),
              letterSpacing: 2.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          PresentationConstants.paddingXLarge,
          PresentationConstants.paddingMedium,
          PresentationConstants.paddingXLarge,
          PresentationConstants.paddingLarge,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppTexts.searchDescription,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(
                  PresentationConstants.borderRadiusMedium,
                ),
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: PresentationConstants.paddingMedium,
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey.shade600),
                  const SizedBox(width: PresentationConstants.paddingMedium),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: AppTexts.searchHint,
                        border: InputBorder.none,
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPokemonGrid(List<Pokemon> pokemons, bool isLoadingMore) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        left: PresentationConstants.paddingXLarge - 2,
        right: PresentationConstants.paddingXLarge - 2,
      ),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          if (index >= pokemons.length) {
            return _buildLoadingCard();
          }

          final pokemon = pokemons[index];

          return PokemonCard(
            id: pokemon.id,
            name: pokemon.name,
            imageUrl: pokemon.imageUrl,
            types: pokemon.types,
            onTap: () {
              context.goNamed(
                'pokemon_detail',
                pathParameters: {'id': pokemon.id.toString()},
                extra: pokemon,
              );
            },
          );
        }, childCount: isLoadingMore ? pokemons.length + 2 : pokemons.length),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: PokemonCardConstants.cardAspectRatio,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }

  Widget _buildLoadingCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          PresentationConstants.borderRadiusLarge,
        ),
        color: Colors.grey.shade200,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Pokeball de fondo
          Positioned(
            right: -25,
            bottom: -25,
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                AppTexts.pokeballImage,
                width: 120,
                height: 120,
                errorBuilder: (_, __, ___) => const SizedBox(),
              ),
            ),
          ),
          // Indicador de carga
          const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
