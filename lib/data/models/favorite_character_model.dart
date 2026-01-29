import 'package:effective_app/domain/entities/favorite_character.dart';

class FavoriteCharacterModel extends FavoriteCharacter {
  const FavoriteCharacterModel({
    required super.id,
    required super.name,
    required super.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }

  factory FavoriteCharacterModel.fromMap(Map<String, dynamic> map) {
    return FavoriteCharacterModel(
      id: map['id'],
      name: map['name'],
      image: map['image'],
    );
  }
}
