import 'package:effective_app/prsentation/bloc/theme_bloc/theme_cubit.dart';
import 'package:effective_app/prsentation/bloc/characters_list_bloc/characters_list_bloc.dart';
import 'package:effective_app/prsentation/bloc/characters_list_bloc/characters_list_event.dart';
import 'package:effective_app/prsentation/bloc/characters_list_bloc/characters_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/favorite_character.dart';
import '../bloc/favorites_bloc/favorites_bloc.dart';
import '../bloc/favorites_bloc/favorites_event.dart';
import '../bloc/favorites_bloc/favorites_state.dart';
import '../components/character_card_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  late Set<int> favoriteIds;

  @override
  void initState() {
    context.read<CharactersListBloc>().add(
          const FetchCharactersListEvent(),
        );

    context.read<FavoritesBloc>().add(
          LoadFavoritesEvent(),
        );
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_scrollController.position.maxScrollExtent ==
        _scrollController.position.pixels) {
      context.read<CharactersListBloc>().add(
            const LoadMoreCharactersEvent(),
          );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state == ThemeMode.dark;

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("Rick and Morty"),
          actions: [
            IconButton(
              icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
              onPressed: () {
                context.read<ThemeCubit>().toggleTheme();
              },
            ),
          ],
        ),
        body: Column(
          children: [
            BlocListener<CharactersListBloc, CharactersListState>(
              listener: (context, state) {
                if (state is CharactersListSuccess && state.isLoadingMore) {
                  //  Auto scroll to bottom when loading starts
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (_scrollController.hasClients) {
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent + 80,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    }
                  });
                }
              },
              child: BlocBuilder<CharactersListBloc, CharactersListState>(
                builder: (context, state) {
                  if (state is CharactersListLoading) {
                    return const Expanded(
                        child: Center(child: CircularProgressIndicator()));
                  }
                  if (state is CharactersListError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Error: ${state.message}'),
                          ElevatedButton(
                            onPressed: () => context
                                .read<CharactersListBloc>()
                                .add(const FetchCharactersListEvent()),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is CharactersListSuccess) {
                    final characters = state.model.results ?? [];
                    return Expanded(
                      child: RefreshIndicator(
                          onRefresh: () async {
                            context
                                .read<CharactersListBloc>()
                                .add(const RefreshCharactersEvent());
                          },
                          child: GridView.builder(
                            padding: const EdgeInsets.all(12.0),
                            controller: _scrollController,
                            itemCount: characters.length + 1,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5.0,
                              mainAxisSpacing: 5.0,
                              childAspectRatio: 0.84,
                            ),
                            itemBuilder: (context, index) {
                              if (index == characters.length) {
                                return state.isLoadingMore
                                    ? const Padding(
                                        padding: EdgeInsets.all(16),
                                        child: Center(
                                            child: CircularProgressIndicator()),
                                      )
                                    : const SizedBox.shrink();
                              }
                              final char = characters[index];

                              return BlocBuilder<FavoritesBloc, FavoritesState>(
                                builder: (context, favState) {
                                  final isFavorite =
                                      favState.favorites[char.id] ?? false;

                                  return CharacterCardItem(
                                    id: char.id!,
                                    name: char.name.toString(),
                                    imageUrl: char.image.toString(),
                                    status: char.status.toString(),
                                    location: char.location!.name.toString(),
                                    isFavorite: isFavorite,
                                    onFavoriteTap: () {
                                      context.read<FavoritesBloc>().add(
                                            ToggleFavoriteEvent(
                                              FavoriteCharacter(
                                                id: char.id!,
                                                name: char.name!,
                                                image: char.image!,
                                                status: char.status!,
                                                location: char.location!.name!,
                                              ),
                                            ),
                                          );
                                    },
                                  );
                                },
                              );
                            },
                          )),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ));
  }
}
