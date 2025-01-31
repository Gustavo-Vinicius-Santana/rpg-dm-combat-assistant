import '../db.dart';

class CharacterConditionsRepository {
  Future<List<Map<String, dynamic>>> getAllPersonConditions() async {
    final db = await DB.instance.database;
    return db.query('characters_conditions');
  }

  Future<List<Map<String, dynamic>>> getCharacterConditions(int id) async {
    final db = await DB.instance.database;
    return db.rawQuery('''
    SELECT c.name_id, c.description 
    FROM characters_conditions cc
    JOIN conditions c ON cc.condition_id = c.id
    WHERE cc.character_participant_id = ?
  ''', [id]);
  }

  Future<int> insertCharacterCondition(Map<String, dynamic> condition) async {
    final db = await DB.instance.database;
    return db.insert('characters_conditions', condition);
  }

  Future<void> deleteAllCharacterCondition(int id) async {
    final db = await DB.instance.database;
    await db.rawDelete('''
    DELETE FROM characters_conditions WHERE character_participant_id = ?
  ''', [id]);
  }
}
