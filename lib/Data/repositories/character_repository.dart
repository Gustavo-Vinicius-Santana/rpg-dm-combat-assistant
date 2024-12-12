import '../db.dart';

class CharacterRepository {
  Future<int> insertCharacter(Map<String, dynamic> character) async {
    final db = await DB.instance.database;
    return db.insert('characters', character);
  }

  Future<List<Map<String, dynamic>>> getAllCharacters() async {
    final db = await DB.instance.database;
    return db.query('characters');
  }

  Future<int> updateCharacter(int id, Map<String, dynamic> character) async {
    final db = await DB.instance.database;
    return db.update(
      'characters',
      character,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteCharacter(int id) async {
    final db = await DB.instance.database;
    return db.delete(
      'characters',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
