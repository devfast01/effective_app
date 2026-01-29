

import '../entities/favorite_character.dart';
import '../repositories/favorites_repository.dart';

class GetFavoritesUseCase {
  final FavoritesRepository repository;

  GetFavoritesUseCase(this.repository);

  Future<List<FavoriteCharacter>> call() {
    return repository.getFavorites();
  }
}
