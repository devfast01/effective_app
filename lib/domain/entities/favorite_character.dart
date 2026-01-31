class FavoriteCharacter {
  final int id;
  final String name;
  final String image;
  final String status;
  final String location;

  const FavoriteCharacter({
    required this.id,
    required this.name,
    required this.image,
    required this.status,
    required this.location,
  });

  //  FROM SQLite
  factory FavoriteCharacter.fromMap(Map<String, dynamic> map) {
    return FavoriteCharacter(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
      status: map['status'] as String,
      location: map['location'] as String,
    );
  }

  //  TO SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'status': status,
      'location': location,
    };
  }
}
