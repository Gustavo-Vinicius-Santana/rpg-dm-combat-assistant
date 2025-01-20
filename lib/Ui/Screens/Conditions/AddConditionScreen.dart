import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/character_in_combat_repository.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/monster_in_combat_repository.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Buttons/ButtonAction.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Lists/ListConditionsSelectOrDelete.dart';

class PersonConditionScreen extends StatefulWidget {
  const PersonConditionScreen({super.key});

  @override
  State<PersonConditionScreen> createState() => _PersonConditionScreenState();
}

class _PersonConditionScreenState extends State<PersonConditionScreen> {
  final MonsterInCombatRepository monster_repository =
      MonsterInCombatRepository();
  final CharacterInCombatRepository character_repository =
      CharacterInCombatRepository();

  List<Map<String, dynamic>> _mapConditions = [];
  List _conditionsList = ['teste'];

  List? listPersonConditions;

  int? id;
  String? type;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments;

    if (arguments is Map<String, dynamic>) {
      id = arguments['id'];
      type = arguments['type'];

      _loadPersonConditions(id!);
    }
  }

  void _loadPersonConditions(int id) async {
    print('Carregando todas as condições');

    if (type == 'character') {
      final dataConditionPerson =
          await character_repository.getCharacterConditions(id);

      listPersonConditions = [
        dataConditionPerson[0]['condition_1'],
        dataConditionPerson[0]['condition_2'],
        dataConditionPerson[0]['condition_3'],
        dataConditionPerson[0]['condition_4'],
      ].where((condition) => condition != null).toList();
    }

    if (type == 'monster') {
      final dataConditionPerson =
          await monster_repository.getMonsterConditions(id);

      listPersonConditions = [
        dataConditionPerson[0]['condition_1'],
        dataConditionPerson[0]['condition_2'],
        dataConditionPerson[0]['condition_3'],
        dataConditionPerson[0]['condition_4'],
      ].where((condition) => condition != null).toList();
    }
  }

  void _addCondition(int id) async {
    print('Editar teste');

    try {
      Map<String, dynamic> personEdited = {
        'condition_1': 'teste',
        'condition_2': 'teste',
        'condition_3': 'teste',
        'condition_4': 'teste',
      };

      if (type == 'character') {
        await character_repository.updateCharacterInCombat(id, personEdited);
      }

      if (type == 'monster') {
        await monster_repository.updateMonsterInCombat(id, personEdited);
      }

      Navigator.pushNamed(
        context,
        '/combatScreen',
        arguments: {
          'id': id,
          'openModal': [id, type],
        },
      );
    } catch (e) {
      print('Erro ao editar o personagem: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Condições'),
      ),
      body: Center(
        child: Column(
          children: [
            ButtonAction(
              onPressed: () {
                print('Adicionar condição');

                _addCondition(id!);
              },
              textInButton: 'Adicionar condição',
              fontSize: 18,
              width: 375,
              height: 50,
            ),
            const SizedBox(height: 20),
            Container(
              width: 375,
              height: 500,
              child:
                  ListConditionsSelectOrDelete(conditionsList: _conditionsList),
            )
          ],
        ),
      ),
    );
  }
}
