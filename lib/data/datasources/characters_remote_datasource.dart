import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/characters_model.dart';

abstract class CharactersRemoteDataSource {
  Future<CharactersModel> getCharacters(int page);
}

class CharactersRemoteDataSourceImpl
    implements CharactersRemoteDataSource {
  final http.Client client;

  CharactersRemoteDataSourceImpl(this.client);

  @override
  Future<CharactersModel> getCharacters(int page) async {
    final uri = Uri.parse(
      'https://rickandmortyapi.com/api/character?page=$page',
    );

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final jsonMap = jsonDecode(response.body);
      return CharactersModel.fromJson(jsonMap);
    } else {
      throw Exception('Server error');
    }
  }
}
