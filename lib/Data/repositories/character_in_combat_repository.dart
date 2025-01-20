import '../db.dart';

class CharacterInCombatRepository {
  Future<int> insertCharacterInCombat(Map<String, dynamic> character) async {
    final db = await DB.instance.database;
    return db.insert('characters_participants', character);
  }

  Future<List<Map<String, dynamic>>> getCharacterInCombatByCombatId(
      int id) async {
    final db = await DB.instance.database;
    return db.query(
      'characters_participants',
      where: 'combat_id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getCharacterInCombatById(int id) async {
    final db = await DB.instance.database;
    return db.query(
      'characters_participants',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateCharacterInCombat(
      int id, Map<String, dynamic> character) async {
    final db = await DB.instance.database;
    return db.update(
      'characters_participants',
      character,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteCharacterInCombat(int id) async {
    final db = await DB.instance.database;
    return db.delete(
      'characters_participants',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getCharacterConditions(int id) async {
    final db = await DB.instance.database;

    final result = await db.query(
      'monsters_participants',
      columns: ['condition_1', 'condition_2', 'condition_3', 'condition_4'],
      where: 'combat_id = ?',
      whereArgs: [id],
    );

    return result;
  }
}
