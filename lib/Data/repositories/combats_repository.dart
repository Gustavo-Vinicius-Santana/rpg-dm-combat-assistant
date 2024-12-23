import '../db.dart';

class CombatsRepository {
  Future<List<Map<String, dynamic>>> getAllCombats() async {
    final db = await DB.instance.database;
    return db.query('combats');
  }

  Future<List<Map<String, dynamic>>> getCombatById(int id) async {
    final db = await DB.instance.database;
    return db.query('combats', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> insertCombat(Map<String, dynamic> combat) async {
    final db = await DB.instance.database;
    return db.insert('combats', combat);
  }

  Future<int> updateCombat(int id, Map<String, dynamic> combat) async {
    final db = await DB.instance.database;
    return db.update(
      'combats',
      combat,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteCombat(int id) async {
    final db = await DB.instance.database;
    return db.delete(
      'combats',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
