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
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      // Exclui as tabelas antigas
      await db.execute('DROP TABLE IF EXISTS characters');
      await db.execute('DROP TABLE IF EXISTS monsters');
      await db.execute('DROP TABLE IF EXISTS combats');
      await db.execute('DROP TABLE IF EXISTS persons_in_combat');
      await db.execute('DROP TABLE IF EXISTS monsters_participants');
      await db.execute('DROP TABLE IF EXISTS characters_participants');
      await db.execute('DROP TABLE IF EXISTS conditions');
      await db.execute('DROP TABLE IF EXISTS monsters_conditions');
      await db.execute('DROP TABLE IF EXISTS characters_conditions');

      // Cria as tabelas novamente com a nova estrutura
      await _onCreate(db, newVersion);
    }
  }

  _onCreate(Database db, int version) async {
    await db.execute(_characterTable);
    await db.execute(_monsterTable);
    await db.execute(_combatTable);

    await db.execute(_personsInCombatTable);
    await db.execute(_monstersParticipantsTable);
    await db.execute(_charactersParticipantsTable);

    await db.execute(_conditionsTable);
    await db.execute(_monstersConditionsTable);
    await db.execute(_charactersConditionsTable);

    // INSERT DATA TEST (APENAS NAS VERSÕES DE DESENVOLVIMENTO)
    // await innitialInsert(db);
  }

  Future<void> innitialInsert(Database db) async {
    // Inserir personagens
    // --------------------------------------------------------
    await db.insert('characters', {
      'player': 'Player 1',
      'name': 'Warrior',
      'armor': '18',
      'lifeMax': 100,
      'lifeActual': 100,
    });

    await db.insert('characters', {
      'player': 'Player 2',
      'name': 'Mage',
      'armor': '16',
      'lifeMax': 70,
      'lifeActual': 70,
    });

    await db.insert('characters', {
      'player': 'Player 3',
      'name': 'Rogue',
      'armor': '15',
      'lifeMax': 80,
      'lifeActual': 80,
    });
    // --------------------------------------------------------

    // Inserir monstros
    await db.insert('monsters', {
      'name': 'Goblin',
      'armor': '14',
      'lifeMax': 30,
      'lifeActual': 30,
    });

    await db.insert('monsters', {
      'name': 'Orc',
      'armor': '16',
      'lifeMax': 60,
      'lifeActual': 60,
    });

    await db.insert('monsters', {
      'name': 'Dragon',
      'armor': '20',
      'lifeMax': 200,
      'lifeActual': 200,
    });
    // --------------------------------------------------------

    // Inserir combates
    await db.insert('combats', {
      'name': 'Battle in the Forest',
      'turns': 0,
      'rounds': 0,
      'timeActual': '30',
      'timeToNextTurn': '6',
    });

    await db.insert('combats', {
      'name': 'Dungeon Encounter',
      'turns': 0,
      'rounds': 0,
      'timeActual': '30',
      'timeToNextTurn': '6',
    });
    // --------------------------------------------------------

    // Inserir participantes nos combates
    await db.insert('persons_in_combat', {
      'combat_id': 1,
      'participant_type': 'character',
      'participant_id': 1, // Refere-se ao ID do Warrior
    });

    await db.insert('persons_in_combat', {
      'combat_id': 1,
      'participant_type': 'monster',
      'participant_id': 1, // Refere-se ao ID do Goblin
    });

    await db.insert('persons_in_combat', {
      'combat_id': 2,
      'participant_type': 'character',
      'participant_id': 2, // Refere-se ao ID do Mage
    });

    await db.insert('persons_in_combat', {
      'combat_id': 2,
      'participant_type': 'monster',
      'participant_id': 2, // Refere-se ao ID do Orc
    });
    // --------------------------------------------------------

    // Inserir monstros participantes no combate
    await db.insert('monsters_participants', {
      'combat_id': 1,
      'monster_id': 1, // Refere-se ao ID do Goblin
      'name': 'Goblin',
      'type': 'monster',
      'iniciative': 7,
      'armor': '14',
      'lifeMax': 30,
      'lifeActual': 30,
    });

    await db.insert('monsters_participants', {
      'combat_id': 2,
      'monster_id': 2, // Refere-se ao ID do Orc
      'name': 'Orc',
      'type': 'monster',
      'iniciative': 20,
      'armor': '16',
      'lifeMax': 60,
      'lifeActual': 60,
    });
    // --------------------------------------------------------

    // Inserir personagens participantes no combate
    await db.insert('characters_participants', {
      'combat_id': 1,
      'character_id': 1,
      'player': 'Player 1',
      'name': 'Warrior',
      'type': 'character',
      'iniciative': 10,
      'armor': '18',
      'lifeMax': 100,
      'lifeActual': 100,
    });

    await db.insert('characters_participants', {
      'combat_id': 2,
      'character_id': 2,
      'player': 'Player 2',
      'name': 'Mage',
      'type': 'character',
      'iniciative': 16,
      'armor': '16',
      'lifeMax': 70,
      'lifeActual': 70,
    });

    await db.insert('conditions', {
      'name_id': 'fallen',
      'description': 'The character is falling.',
    });

    await db.insert('conditions', {
      'name_id': 'poisoned',
      'description': 'The character is poisoned.',
    });

    await db.insert('conditions', {
      'name_id': 'bleeding',
      'description': 'The character is bleeding.',
    });

    await db.insert('conditions', {
      'name_id': 'raged',
      'description': 'The character is raging.',
    });

    //--------------------------------------------------------

    // Inserir condições nos personagens
    await db.insert('characters_conditions', {
      'character_participant_id': 1,
      'condition_id': 1,
    });

    await db.insert('characters_conditions', {
      'character_participant_id': 2,
      'condition_id': 2,
    });

    // Inserir condições nos monstros
    await db.insert('monsters_conditions', {
      'monster_participant_id': 1,
      'condition_id': 1,
    });

    await db.insert('monsters_conditions', {
      'monster_participant_id': 1,
      'condition_id': 2,
    });

    await db.insert('monsters_conditions', {
      'monster_participant_id': 2,
      'condition_id': 3,
    });

    await db.insert('monsters_conditions', {
      'monster_participant_id': 2,
      'condition_id': 2,
    });

    await db.insert('monsters_conditions', {
      'monster_participant_id': 2,
      'condition_id': 4,
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
      condition_1 TEXT,
      condition_2 TEXT,
      condition_3 TEXT,
      condition_4 TEXT
    )
  ''';

  static const String _monsterTable = '''
    CREATE TABLE monsters(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      armor TEXT NOT NULL,
      lifeMax INTEGER NOT NULL,
      lifeActual INTEGER NOT NULL,
      condition_1 TEXT,
      condition_2 TEXT,
      condition_3 TEXT,
      condition_4 TEXT
    )
 ''';

  static const String _combatTable = '''
    CREATE TABLE combats(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      turns INTEGER NOT NULL,
      timeActual TEXT NOT NULL,
      timeToNextTurn TEXT NOT NULL,
      rounds INTEGER NOT NULL DEFAULT 0
    )
 ''';

  static const String _personsInCombatTable = '''
    CREATE TABLE persons_in_combat(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      combat_id INTEGER NOT NULL,
      participant_type TEXT NOT NULL,
      participant_id INTEGER NOT NULL,
      FOREIGN KEY (combat_id) REFERENCES combats(id)
    )
  ''';

  static const String _monstersParticipantsTable = '''
    CREATE TABLE monsters_participants (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      combat_id INTEGER NOT NULL,
      monster_id INTEGER NOT NULL,
      name TEXT NOT NULL,
      type TEXT NOT NULL,
      iniciative interger,
      armor TEXT NOT NULL,
      lifeMax INTEGER NOT NULL,
      lifeActual INTEGER NOT NULL,
      FOREIGN KEY (combat_id) REFERENCES combats(id),
      FOREIGN KEY (monster_id) REFERENCES monsters(id)
    );
  ''';

  static const String _charactersParticipantsTable = '''
    CREATE TABLE characters_participants (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      combat_id INTEGER NOT NULL,
      character_id INTEGER NOT NULL,
      player TEXT NOT NULL,
      name TEXT NOT NULL,
      type TEXT NOT NULL,
      iniciative interger,
      armor TEXT NOT NULL,
      lifeMax INTEGER NOT NULL,
      lifeActual INTEGER NOT NULL,
      FOREIGN KEY (combat_id) REFERENCES combats(id),
      FOREIGN KEY (character_id) REFERENCES characters(id)
    );
  ''';

  static const String _conditionsTable = '''
    CREATE TABLE conditions(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name_id TEXT NOT NULL,
      description TEXT
    )
  ''';

  static const String _charactersConditionsTable = '''
  CREATE TABLE characters_conditions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    character_participant_id INTEGER NOT NULL,
    condition_id INTEGER NOT NULL,
    FOREIGN KEY (character_participant_id) REFERENCES characters_participants(id),
    FOREIGN KEY (condition_id) REFERENCES conditions(id) ON DELETE CASCADE
  )
  ''';

  static const String _monstersConditionsTable = '''
  CREATE TABLE monsters_conditions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    monster_participant_id INTEGER NOT NULL,
    condition_id INTEGER NOT NULL,
    FOREIGN KEY (monster_participant_id) REFERENCES monsters_participants(id),
    FOREIGN KEY (condition_id) REFERENCES conditions(id) ON DELETE CASCADE
  )
  ''';
}
