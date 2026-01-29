import '../entities/favorite_character.dart';
import '../repositories/favorites_repository.dart';

class AddFavorite {
  final FavoritesRepository repository;

  AddFavorite(this.repository);

  Future<void> call(FavoriteCharacter character) {
    return repository.addFavorite(character);
  }
}
