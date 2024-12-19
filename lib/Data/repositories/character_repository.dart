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

  Future<List<Map<String, dynamic>>> getCharacterById(int id) async {
    final db = await DB.instance.database;
    return db.query('characters', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteRowsByIds(List<int> ids) async {
    final db = await DB.instance.database;

    if (ids.isEmpty) {
      return 0;
    }

    final placeholders = List.filled(ids.length, '?').join(',');

    return await db.delete(
      'characters',
      where: 'id IN ($placeholders)',
      whereArgs: ids,
    );
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
