import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/monster_in_combat_repository.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Buttons/ButtonAction.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/TextBox/ConditionTextBox.dart';

class PersonConditionScreen extends StatefulWidget {
  const PersonConditionScreen({super.key});

  @override
  State<PersonConditionScreen> createState() => _PersonConditionScreenState();
}

class _PersonConditionScreenState extends State<PersonConditionScreen> {
  final MonsterInCombatRepository monster_repository =
      MonsterInCombatRepository();

  List<Map<String, dynamic>> _personConditions = [];
  List _personConditionsList = [];
  int? id;

  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments is int) {
      id = arguments;
      _loadConditions(id!);
    } else {
      throw Exception("ID não fornecido ou inválido");
    }
  }

  void _loadConditions(int id) async {
    print('id fornecido pela rota: $id');

    try {
      _personConditions = await monster_repository.getMonsterConditions(id);

      final conditionMap =
          _personConditions.isNotEmpty ? _personConditions[0] : {};

      setState(() {
        _personConditionsList =
            conditionMap.values.where((value) => value != null).toList();
      });

      print('Condições do personagem: $_personConditions');
      print('Lista de condições: $_personConditionsList');
    } catch (e) {
      print('Erro ao carregar condições: $e');
    }
  }

  void testeEdit() async {
    print("id fornecido pela rota: $id");

    //Map<String, dynamic> personEdited = {
    //'name': 'Goblin',
    //};
    //\await monster_repository.updateMonsterInCombat(1, personEdited);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Condições do personagem'),
      ),
      body: Center(
        child: Column(
          children: [
            ButtonAction(
              onPressed: () {
                testeEdit();
              },
              textInButton: 'Adicionar condição',
              fontSize: 18,
              width: 375,
              height: 50,
            ),
            const Text(
              'CONDIÇÕES',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            Container(
              width: 375,
              height: 500,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _personConditionsList.length,
                itemBuilder: (context, index) {
                  return Column(children: [
                    ConditionTextBox(condition: _personConditionsList[index]),
                    const SizedBox(height: 8),
                  ]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
