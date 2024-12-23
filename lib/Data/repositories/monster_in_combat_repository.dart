import '../db.dart';

class MonsterInCombatRepository {
  Future<List<Map<String, dynamic>>> getMonstersInCombat(int id) async {
    final db = await DB.instance.database;
    return db.query('monsters_participants',
        where: 'combat_id = ?', whereArgs: [id]);
  }
}
