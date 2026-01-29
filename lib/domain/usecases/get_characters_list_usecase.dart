import '../../data/models/characters_model.dart';
import '../repositories/characters_repository.dart';

class GetCharactersListUseCase {
  final CharactersRepository repository;

  GetCharactersListUseCase(this.repository);

  Future<CharactersModel> call({int page = 1}) {
    return repository.getCharacters(page: page);
  }
}
