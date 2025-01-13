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

  Future<int> deleteRowsByIds(List<int> ids) async {
    if (ids.isEmpty) return 0;

    final db = await DB.instance.database;
    final placeholders = List.filled(ids.length, '?').join(',');

    return await db.transaction((txn) async {
      // Deletar os participantes relacionados
      for (final table in [
        'characters_participants',
        'monsters_participants'
      ]) {
        await txn.delete(
          table,
          where: 'combat_id IN ($placeholders)',
          whereArgs: ids,
        );
      }

      // Deletar os combates
      final count = await txn.delete(
        'combats',
        where: 'id IN ($placeholders)',
        whereArgs: ids,
      );

      return count;
    });
  }
}
