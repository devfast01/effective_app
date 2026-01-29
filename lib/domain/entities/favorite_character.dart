class FavoriteCharacter {
  final int id;
  final String name;
  final String image;

  const FavoriteCharacter({
    required this.id,
    required this.name,
    required this.image,
  });

  //  FROM SQLite
  factory FavoriteCharacter.fromMap(Map<String, dynamic> map) {
    return FavoriteCharacter(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }

  //  TO SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
