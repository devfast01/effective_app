import '../../../domain/entities/favorite_character.dart';

class FavoritesState {
  final Map<int, bool> favorites;
  final List<FavoriteCharacter> favoriteList;
  final bool isLoading;

  FavoritesState({
    required this.favorites,
    required this.favoriteList,
    required this.isLoading,
  });

  factory FavoritesState.initial() => FavoritesState(
        favorites: {},
        favoriteList: [],
        isLoading: false,
      );

  FavoritesState copyWith({
    Map<int, bool>? favorites,
    List<FavoriteCharacter>? favoriteList,
    bool? isLoading,
  }) {
    return FavoritesState(
      favorites: favorites ?? this.favorites,
      favoriteList: favoriteList ?? this.favoriteList,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
