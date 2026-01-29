import 'package:effective_app/domain/entities/favorite_character.dart';

abstract class FavoritesRepository {
  Future<bool> isFavorite(int id);
  Future<void> addFavorite(FavoriteCharacter entity);
  Future<void> removeFavorite(int id);
  Future<List<FavoriteCharacter>> getFavorites();
}
