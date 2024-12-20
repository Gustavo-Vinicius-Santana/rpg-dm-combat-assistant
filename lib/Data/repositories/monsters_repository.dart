import '../db.dart';

class MonstersRepository {
  Future<int> insertMonster(Map<String, dynamic> monster) async {
    final db = await DB.instance.database;
    return db.insert('monsters', monster);
  }

  Future<List<Map<String, dynamic>>> getAllMonsters() async {
    final db = await DB.instance.database;
    return db.query('monsters');
  }

  Future<List<Map<String, dynamic>>> getMonsterById(int id) async {
    final db = await DB.instance.database;
    return db.query('monsters', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteRowsByIds(List<int> ids) async {
    final db = await DB.instance.database;

    if (ids.isEmpty) {
      return 0;
    }

    final placeholders = List.filled(ids.length, '?').join(',');

    return await db.delete(
      'monsters',
      where: 'id IN ($placeholders)',
      whereArgs: ids,
    );
  }

  Future<int> updateMonster(int id, Map<String, dynamic> monster) async {
    final db = await DB.instance.database;
    return db.update(
      'monsters',
      monster,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteMonster(int id) async {
    final db = await DB.instance.database;
    return db.delete(
      'monsters',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
