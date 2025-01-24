import '../db.dart';

class ConditionsRepository {
  Future<List<Map<String, dynamic>>> getAllConditions() async {
    final db = await DB.instance.database;
    return db.query('conditions');
  }

  Future<List<Map<String, dynamic>>> getConditionById(int id) async {
    final db = await DB.instance.database;
    return db.query('conditions', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateCondition(int id, Map<String, dynamic> condition) async {
    final db = await DB.instance.database;
    return db.update('conditions', condition, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteCondition(int id) async {
    final db = await DB.instance.database;
    return db.delete('conditions', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> insertCondition(Map<String, dynamic> condition) async {
    final db = await DB.instance.database;
    return db.insert('conditions', condition);
  }
}
