import '../entities/favorite_character.dart';
import '../repositories/favorites_repository.dart';

class ToggleFavoriteUseCase {
  final FavoritesRepository repo;

  ToggleFavoriteUseCase(this.repo);

  Future<bool> call(FavoriteCharacter entity) async {
    final exists = await repo.isFavorite(entity.id);

    if (exists) {
      await repo.removeFavorite(entity.id);
      return false; 
    } else {
      await repo.addFavorite(entity);
      return true; 
    }
  }
}
