import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_application/core/constants/app_constants.dart';
import 'package:pokedex_application/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokedex_application/features/pokemon/presentation/bloc/pokemon_list_with_details_bloc.dart';
import 'package:pokedex_application/features/pokemon/presentation/bloc/pokemon_list_with_details_event.dart';
import 'package:pokedex_application/features/pokemon/presentation/bloc/pokemon_list_with_details_state.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/home/pokemon_app_bar.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/home/pokemon_build_loading_card.dart';
import 'package:pokedex_application/features/pokemon/presentation/widgets/home/pokemon_card.dart';
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
    return Scaffold(
      backgroundColor: PresentationConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: PresentationConstants.backgroundColor,
        actionsPadding: const EdgeInsets.only(
          right: PresentationConstants.paddingLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/svg/generation.svg',
              width: 25,
              height: 25,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/svg/sort.svg',
              width: 25,
              height: 25,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/svg/filter.svg',
              width: 25,
              height: 25,
            ),
          ),
        ],
      ),
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
        _buildSliverPadding(const PokemonAppBar()),
        _buildSliverPadding(
          PokemonSearchBar(searchController: _searchController),
        ),
        SliverToBoxAdapter(
          child: const SizedBox(height: PresentationConstants.paddingLarge),
        ),
        _buildSliverPadding(_buildPokemonGrid(pokemons, isLoadingMore)),
      ],
    );
  }

  SliverPadding _buildSliverPadding(Widget sliver) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: PresentationConstants.paddingXLarge,
      ),
      sliver: sliver,
    );
  }

  Widget _buildPokemonGrid(List<Pokemon> pokemons, bool isLoadingMore) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index) {
        if (index >= pokemons.length) {
          return PokemonBuildLoadingCard(
            animationController: _animationController,
          );
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
        crossAxisCount: PokemonCardConstants.cardCrossAxisCount,
        childAspectRatio: PokemonCardConstants.cardAspectRatio,
        crossAxisSpacing: PokemonCardConstants.cardCrossAxisSpacing,
        mainAxisSpacing: PokemonCardConstants.cardMainAxisSpacing,
      ),
    );
  }
}
