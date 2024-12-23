import '../db.dart';

class CharacterInCombatRepository {
  Future<List<Map<String, dynamic>>> getCharacterInCombatByCombatId(
      int id) async {
    final db = await DB.instance.database;
    return db.query(
      'characters_participants',
      where: 'combat_id = ?',
      whereArgs: [id],
    );
  }
}