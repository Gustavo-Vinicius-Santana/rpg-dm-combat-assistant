import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/character_in_combat_repository.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/combats_repository.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/monster_in_combat_repository.dart';

class CombatScreen extends StatefulWidget {
  const CombatScreen({super.key});

  @override
  State<CombatScreen> createState() => _CombatScreenState();
}

class _CombatScreenState extends State<CombatScreen> {
  final CombatsRepository _combatsRepository = CombatsRepository();

  final CharacterInCombatRepository _characterInCombatRepository =
      CharacterInCombatRepository();
  final MonsterInCombatRepository _monsterInCombatRepository =
      MonsterInCombatRepository();

  final List idsCharacter = [];
  final List idsMonster = [];

  late List<Map<String, dynamic>> _monstersInCombat = [];
  late List<Map<String, dynamic>> _charactersInCombat = [];
  late List<Map<String, dynamic>> _personsInCombat = [];

  late final String _title;
  late final String _time;
  late final int _turns;

  int? id;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments is int) {
      id = arguments;
      _loadCombat(id!);
    } else {
      throw Exception("ID não fornecido ou inválido");
    }
  }

  void _loadCombat(int id) async {
    print('id fornecido pela rota: $id');
    final combat = await _combatsRepository.getCombatById(id);
    print(combat);
    setState(() {
      _title = combat[0]['name'];
      _time = combat[0]['time'];
      _turns = combat[0]['turns'];
    });

    await _loadMonsters(id);
    await _loadCharacters(id);

    _organizedList();
  }

  Future<void> _loadMonsters(int id) async {
    final monstersInCombat =
        await _monsterInCombatRepository.getMonstersInCombat(id);

    setState(() {
      _monstersInCombat = monstersInCombat;
    });
  }

  Future<void> _loadCharacters(int id) async {
    final charactersInCombat =
        await _characterInCombatRepository.getCharacterInCombatByCombatId(id);

    setState(() {
      _charactersInCombat = charactersInCombat;
    });
  }

  void _organizedList() {
    _personsInCombat = [];
    _personsInCombat.addAll(_charactersInCombat);
    _personsInCombat.addAll(_monstersInCombat);
    print("Personagens presentes no combate: $_personsInCombat");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Turnos: $_turns'),
              Text('Tempo: $_time'),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _personsInCombat.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_personsInCombat[index]['name'] as String),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
