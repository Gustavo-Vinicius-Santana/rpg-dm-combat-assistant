import '../db.dart';

class ConditionsRepository {
  Future<List<Map<String, dynamic>>> getAllConditions() async {
    final db = await DB.instance.database;
    return db.query('conditions');
  }
}
