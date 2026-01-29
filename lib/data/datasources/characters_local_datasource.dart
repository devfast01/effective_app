import 'dart:convert';
import 'package:hive/hive.dart';
import '../models/characters_model.dart';

abstract class CharactersLocalDataSource {
  Future<void> cacheCharacters(int page, String data);
  CharactersModel? getCachedCharacters(int page);
}

class CharactersLocalDataSourceImpl implements CharactersLocalDataSource {
  final Box box;

  CharactersLocalDataSourceImpl(this.box);

  @override
  Future<void> cacheCharacters(int page, String data) async {
    await box.put('characters_page_$page', data);
  }

  @override
  CharactersModel? getCachedCharacters(int page) {
    final cached = box.get('characters_page_$page');
    if (cached != null) {
      return CharactersModel.fromJson(jsonDecode(cached));
    }
    return null;
  }
}
