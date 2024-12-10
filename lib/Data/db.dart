import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  DB._();

  static final DB instance = DB._();

  static Database? _database;

  get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'rpg_dm_combat_assistant.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(Database db, int version) async {
    await db.execute(_characterTable);
    await db.execute(_combatTable);
    await db.execute(_monsterTable);
  }

  static const String _characterTable = '''
    CREATE TABLE characters(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      player TEXT NOT NULL,
      name TEXT NOT NULL,
      armor TEXT NOT NULL,
      lifeMax INTEGER NOT NULL,
      lifeActual INTEGER NOT NULL,
      condition TEXT NOT NULL,
  ''';

  static const String _combatTable = '''
    CREATE TABLE combats(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      turns INTEGER NOT NULL,
      time TEXT NOT NULL,
      players TEXT NOT NULL,
      monsters TEXT NOT NULL,
 ''';

  static const String _monsterTable = '''
    CREATE TABLE monsters(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      armor TEXT NOT NULL,
      lifeMax INTEGER NOT NULL,
      lifeActual INTEGER NOT NULL,
      condition TEXT NOT NULL
 ''';
}
