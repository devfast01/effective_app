import 'dart:convert';
import 'package:effective_app/data/models/characters_model.dart';
import 'package:effective_app/utils/print_helper.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class CharactersListRepository {
  static final _box = Hive.box('characters_cache');

  static Future<CharactersModel> getCharactersList({int page = 1}) async {
    final client = http.Client();
    final cacheKey = 'characters_page_$page';

    try {
      final uri =
          Uri.parse('https://rickandmortyapi.com/api/character?page=$page');
      final response = await client.get(uri);

      if (response.statusCode == 200) {
        await _box.put(cacheKey, response.body);

        final jsonMap = jsonDecode(response.body) as Map<String, dynamic>;

        return CharactersModel.fromJson(jsonMap);
      } else {
        final cachedData = _box.get(cacheKey);

        if (cachedData != null) {
          final jsonMap = jsonDecode(cachedData);
          return CharactersModel.fromJson(jsonMap);
        }
        throw Exception('Failed to load characters: ${response.statusCode}');
      }
    } catch (_) {
      //  OFFLINE FALLBACK
      final cachedData = _box.get(cacheKey);

      if (cachedData != null) {
        final jsonMap = jsonDecode(cachedData);
        return CharactersModel.fromJson(jsonMap);
      }
      rethrow;
    } finally {
      client.close();
    }
  }

  //  Clear cache on refresh
  // static Future<void> clearCache() async {
  //   await _box.clear();
  // }
}
