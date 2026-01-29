import 'dart:convert';

import '../../domain/repositories/characters_repository.dart';
import '../datasources/characters_local_datasource.dart';
import '../datasources/characters_remote_datasource.dart';
import '../models/characters_model.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final CharactersRemoteDataSource remote;
  final CharactersLocalDataSource local;

  CharactersRepositoryImpl({
    required this.remote,
    required this.local,
  });

  @override
  Future<CharactersModel> getCharacters({int page = 1}) async {
    try {
      final model = await remote.getCharacters(page);

      // cache success response
      await local.cacheCharacters(
        page,
        jsonEncode(model.toJson()),
      );

      return model;
    } catch (_) {
      // offline fallback
      final cached = local.getCachedCharacters(page);
      if (cached != null) {
        return cached;
      }
      rethrow;
    }
  }
}
