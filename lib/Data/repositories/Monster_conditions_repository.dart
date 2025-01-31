import '../db.dart';

class MonsterConditionsRepository {
  Future<List<Map<String, dynamic>>> getAllMonsterConditions() async {
    final db = await DB.instance.database;
    return db.query('monsters_conditions');
  }

  Future<List<Map<String, dynamic>>> getMonsterConditions(int id) async {
    final db = await DB.instance.database;
    return db.rawQuery('''
    SELECT c.name_id, c.description 
    FROM monsters_conditions cc
    JOIN conditions c ON cc.condition_id = c.id
    WHERE cc.monster_participant_id = ?
  ''', [id]);
  }

  Future<int> insertMonsterCondition(Map<String, dynamic> condition) async {
    final db = await DB.instance.database;
    return db.insert('monsters_conditions', condition);
  }

  Future<void> deleteAllMonsterCondition(int id) async {
    final db = await DB.instance.database;
    await db.rawDelete('''
    DELETE FROM monsters_conditions WHERE monster_participant_id = ?
  ''', [id]);
  }
}
