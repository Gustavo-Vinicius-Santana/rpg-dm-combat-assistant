import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/character_in_combat_repository.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/combats_repository.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/monster_in_combat_repository.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Buttons/ButtonCombat.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Modals/ModalAddCharacterInCombat.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Modals/ModalAddMonsterInCombat.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/TextBox/TimeAndTurnsBox.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Lists/ListCombat.dart';

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

  String _title = '';
  String _time = '';
  String _timeToNextTurn = '';
  int _turns = 0;
  int _rounds = 0;

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
      _time = combat[0]['timeActual'];
      _turns = combat[0]['turns'];
      _rounds = combat[0]['rounds'];
      _timeToNextTurn = combat[0]['timeToNextTurn'];
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

  void openModalAddCharacter() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ModalAddCharacterInCombat(combatId: id!);
        });
  }

  void openModalAddMonster() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ModalAddMonsterInCombat(combatId: id!);
        });
  }

  void openCombatEdit(int id) {
    Navigator.pushNamed(
      context,
      '/combatEdit',
      arguments: id,
    );
  }

  void nextTurn() async {
    setState(() {
      _turns += 1;
    });

    if (_personsInCombat.length >= _turns) {
      Map<String, dynamic> combatNextTurn = {
        'turns': _turns,
      };

      await _combatsRepository.updateCombat(id!, combatNextTurn);
    }

    if (_personsInCombat.length < _turns) {
      int timeAsInt = int.parse(_time);
      int timeToNextTurnInt = int.parse(_timeToNextTurn);
      timeAsInt = timeAsInt + timeToNextTurnInt;
      String timeActual = timeAsInt.toString();

      Map<String, dynamic> combatNexRound = {
        'rounds': _rounds + 1,
        'timeActual': timeActual,
        'turns': 0,
      };

      await _combatsRepository.updateCombat(id!, combatNexRound);

      setState(() {
        _rounds += 1;
        _turns = 0;
        _time = timeActual;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/',
          (route) => false,
          arguments: 1,
        );
        return false; // Impede o comportamento padrão de voltar
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_title),
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                print("Editar clicado!");
                openCombatEdit(id!);
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 190,
                  child: ButtonCombat(
                    label: 'Adicionar monstro',
                    onPress: () {
                      openModalAddMonster();
                    },
                    iconSelect: 1,
                  ),
                ),
                SizedBox(
                  width: 190,
                  child: ButtonCombat(
                    label: 'Adicionar jogador',
                    onPress: () {
                      openModalAddCharacter();
                    },
                    iconSelect: 0,
                  ),
                ),
              ],
            ),
            const Divider(),
            SizedBox(
              width: 250,
              child: ButtonCombat(
                label: _personsInCombat.length == _turns
                    ? 'Próxima rodada'
                    : 'Próximo turno',
                onPress: () {
                  nextTurn();
                },
                iconSelect: _personsInCombat.length == _turns ? 3 : 2,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TimesAndTurnsBox(
                  text: 'Rodadas: $_rounds',
                ),
                TimesAndTurnsBox(
                  text: 'tempo: $_time',
                ),
              ],
            ),
            const Divider(),
            const Center(
              child: Text(
                'COMBATENTES',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
            ),
            ListCombat(
              actualTurn: _turns,
              personsInCombat: _personsInCombat,
            ),
          ],
        ),
      ),
    );
  }
}
