import 'package:effective_app/prsentation/bloc/favorites_bloc/favorites_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'prsentation/bloc/favorites_bloc/favorites_bloc.dart';
import 'prsentation/bloc/favorites_bloc/favorites_state.dart';
import 'prsentation/components/character_card_item.dart';

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
      appBar: AppBar(title: const Text('Favorites')),
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

            return ListView.builder(
              itemCount: state.favoriteList.length,
              itemBuilder: (context, index) {
                final char = state.favoriteList[index];

                return CharacterCardItem(
                  id: char.id,
                  avatarUrl: char.image,
                  name: char.name,
                  timeAgo: "",
                  description: "",
                );
              },
            );
          },
        ),
      ),
    );
  }
}
