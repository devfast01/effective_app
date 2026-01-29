import 'package:effective_app/domain/entities/favorite_character.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FavoritesLocalDataSource {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'favorites.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, _) async {
        await db.execute('''
          CREATE TABLE favorites (
            id INTEGER PRIMARY KEY,
            name TEXT,
            image TEXT
          )
        ''');
      },
    );
  }

  Future<List<FavoriteCharacter>> getFavorites() async {
    final db = await database;
    final result = await db.query('favorites');

    return result.map((e) => FavoriteCharacter.fromMap(e)).toList();
  }

  Future<bool> exists(int id) async {
    final db = await database;
    final res = await db.query(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
    return res.isNotEmpty;
  }

  Future<void> delete(int id) async {
    final db = await database;
    await db.delete(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insert(FavoriteCharacter e) async {
    final db = await database;
    await db.insert(
      'favorites',
      {
        'id': e.id,
        'name': e.name,
        'image': e.image,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
