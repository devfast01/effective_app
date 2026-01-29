import 'package:effective_app/prsentation/bloc/favorites_bloc/favorites_state.dart';
import 'package:effective_app/utils/print_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_favorites_usecase.dart';
import '../../../domain/usecases/toggle_favorite_use_case.dart';
import 'favorites_event.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final ToggleFavoriteUseCase toggleFavorite;
  final GetFavoritesUseCase getFavorites;

  FavoritesBloc(this.toggleFavorite, this.getFavorites)
      : super(FavoritesState.initial()) {
    on<LoadFavoritesEvent>(_onLoadFavorites);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  Future<void> _onLoadFavorites(
    LoadFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final list = await getFavorites();

    printGreen('📦 Loaded favorites count: ${list.length}');

    emit(
      state.copyWith(
        favoriteList: list,
        isLoading: false,
      ),
    );
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    final isFav = await toggleFavorite(event.entity);
    //  TODO 🔥 THIS IS WHAT YOU WANT
    if (isFav) {
      printGreen(
        '❤️ ADDED to favorites → id=${event.entity.id}, name=${event.entity.name}',
      );
    } else {
      printGreen(
        '💔 REMOVED from favorites → id=${event.entity.id}, name=${event.entity.name}',
      );
    }
    final updated = Map<int, bool>.from(state.favorites)
      ..[event.entity.id] = isFav;

    emit(state.copyWith(favorites: updated));
  }
}
