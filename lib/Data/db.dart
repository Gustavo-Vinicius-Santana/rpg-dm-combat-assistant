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

    await db.execute(_conditionsTable);
    await db.execute(_personsInCombatTable);

    // INSERT TEST DATA
    await db.insert('characters', {
      'player': 'Player 1',
      'name': 'Character 1',
      'armor': 'Light',
      'lifeMax': 100,
      'lifeActual': 100,
      'condition_1': 'Alive',
      'condition_2': 'Alive',
      'condition_3': 'Alive',
      'condition_4': 'Alive',
    });

    await db.insert('monsters', {
      'name': 'Monster 1',
      'armor': 'Light',
      'lifeMax': 100,
      'lifeActual': 100,
      'condition': 'Alive',
    });

    await db.insert('combats', {
      'name': 'Combat 1',
      'turns': 1,
      'time': '30',
    });
  }

  static const String _characterTable = '''
    CREATE TABLE characters(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      player TEXT NOT NULL,
      name TEXT NOT NULL,
      armor TEXT NOT NULL,
      lifeMax INTEGER NOT NULL,
      lifeActual INTEGER NOT NULL,
      condition_1 TEXT NOT NULL,
      condition_2 TEXT NOT NULL,
      condition_3 TEXT NOT NULL,
      condition_4 TEXT NOT NULL
    )
  ''';

  static const String _combatTable = '''
    CREATE TABLE combats(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      turns INTEGER NOT NULL,
      time TEXT NOT NULL
    )
 ''';

  static const String _conditionsTable = '''
    CREATE TABLE conditions(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name_id TEXT NOT NULL
      
    )
  ''';

  static const String _personsInCombatTable = '''
    CREATE TABLE persons_in_combat(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      combat_id INTEGER NOT NULL,
      character_id INTEGER NOT NULL,
      monster_id INTEGER NOT NULL
    )
  ''';

  static const String _monsterTable = '''
    CREATE TABLE monsters(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      armor TEXT NOT NULL,
      lifeMax INTEGER NOT NULL,
      lifeActual INTEGER NOT NULL,
      condition TEXT NOT NULL
    )
 ''';
}
