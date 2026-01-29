import '../../domain/entities/favorite_character.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../datasources/favorites_local_datasource.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource local;

  FavoritesRepositoryImpl(this.local);

  @override
  Future<bool> isFavorite(int id) => local.exists(id);

  @override
  Future<void> addFavorite(FavoriteCharacter entity) => local.insert(entity);

  @override
  Future<void> removeFavorite(int id) => local.delete(id);

   @override
  Future<List<FavoriteCharacter>> getFavorites() {
    return local.getFavorites();
  }

}
