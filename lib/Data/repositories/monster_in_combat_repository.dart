import '../db.dart';

class MonsterInCombatRepository {
  Future<int> insertMonsterInCombat(Map<String, dynamic> monster) async {
    final db = await DB.instance.database;
    return db.insert('monsters_participants', monster);
  }

  Future<List<Map<String, dynamic>>> getMonstersInCombat(int id) async {
    final db = await DB.instance.database;
    return db.query('monsters_participants',
        where: 'combat_id = ?', whereArgs: [id]);
  }

  Future<int> updateMonsterInCombat(
      int id, Map<String, dynamic> monster) async {
    final db = await DB.instance.database;
    return db.update(
      'monsters_participants',
      monster,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteMonsterInCombat(int id) async {
    final db = await DB.instance.database;
    return db.delete(
      'monsters_participants',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
