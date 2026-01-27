import 'dart:convert';
import 'dart:developer';
import 'package:effective_app/data/models/characters_model.dart';
import 'package:effective_app/print_helper.dart';
import 'package:http/http.dart' as http;

class CharactersListRepository {
  static Future<CharactersModel> getCharactersList({int page = 1}) async {
    final client = http.Client();

    try {
      final uri =
          Uri.parse('https://rickandmortyapi.com/api/character?page=$page');
      final response = await client.get(uri);

      if (response.statusCode != 200) {
        throw Exception('Failed to load characters: ${response.statusCode}');
      }
      final jsonMap = jsonDecode(response.body) as Map<String, dynamic>;
      return CharactersModel.fromJson(jsonMap);
    } catch (e, stack) {
      rethrow; // or return empty model if you prefer silent failure
    } finally {
      client.close();
    }
  }
}
