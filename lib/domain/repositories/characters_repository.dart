
import '../../data/models/characters_model.dart';

abstract class CharactersRepository {
  Future<CharactersModel> getCharacters({int page});
}
