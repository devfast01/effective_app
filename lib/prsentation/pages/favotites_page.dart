import 'package:effective_app/prsentation/bloc/favorites_bloc/favorites_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/favorite_character.dart';
import '../bloc/favorites_bloc/favorites_bloc.dart';
import '../bloc/favorites_bloc/favorites_state.dart';
import '../components/character_card.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    context.read<FavoritesBloc>().add(
          LoadFavoritesEvent(),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: false, title: const Text('Favorites')),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<FavoritesBloc>().add(LoadFavoritesEvent());
        },
        child: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.favoriteList.isEmpty) {
              return const Center(
                child: Text('No favorites yet ❤️'),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: state.favoriteList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
                childAspectRatio: 0.84,
              ),
              itemBuilder: (context, index) {
                final char = state.favoriteList[index];

                return BlocBuilder<FavoritesBloc, FavoritesState>(
                  builder: (context, favState) {
                    final isFavorite = favState.favorites[char.id] ?? true;

                    return CharacterCardItem(
                      id: char.id,
                      name: char.name.toString(),
                      imageUrl: char.image.toString(),
                      status: char.status,
                      location: char.location,
                      forceFilledFavoriteIcon: true,
                      isFavorite: isFavorite,
                      onFavoriteTap: () {
                        context.read<FavoritesBloc>().add(
                              ToggleFavoriteEvent(
                                FavoriteCharacter(
                                  id: char.id,
                                  name: char.name,
                                  image: char.image,
                                  status: char.status,
                                  location: char.location,
                                ),
                              ),
                            );
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
