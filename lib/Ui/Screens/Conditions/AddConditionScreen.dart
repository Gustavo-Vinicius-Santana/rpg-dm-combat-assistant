import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/monster_in_combat_repository.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Buttons/ButtonAction.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Cards/CardConditionWithDescription.dart';

class PersonConditionScreen extends StatefulWidget {
  const PersonConditionScreen({super.key});

  @override
  State<PersonConditionScreen> createState() => _PersonConditionScreenState();
}

class _PersonConditionScreenState extends State<PersonConditionScreen> {
  final MonsterInCombatRepository monster_repository =
      MonsterInCombatRepository();

  List<Map<String, dynamic>> _mapConditions = [];
  List _conditionsList = [];

  void _loadConditions(int id) async {
    print('Carregando todas as condições');
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
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _conditionsList.length,
                itemBuilder: (context, index) {
                  return CardConditionWhithDescription(
                    name: _conditionsList[index],
                    description: 'teste',
                    type: 'select',
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
