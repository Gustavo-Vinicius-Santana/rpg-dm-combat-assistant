import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Cards/CardPersonInCombat.dart';

class ListCombat extends StatefulWidget {
  const ListCombat(
      {super.key, required this.personsInCombat, required this.actualTurn});
  final int actualTurn;
  final List<Map<String, dynamic>> personsInCombat;

  @override
  State<ListCombat> createState() => _ListCombatState();
}

class _ListCombatState extends State<ListCombat> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.personsInCombat.length,
        itemBuilder: (context, index) {
          widget.personsInCombat
              .sort((a, b) => b['iniciative'].compareTo(a['iniciative']));

          final person = widget.personsInCombat[index];
          final isActive = index == widget.actualTurn;
          print('--------------------------------------');
          print('turno do personagem ${person['name']}: $isActive $index');
          print('tamanho da lista: ${widget.personsInCombat.length}');
          print('turno atual: ${widget.actualTurn}');

          final List conditions = [
            person['condition_1'],
            person['condition_2'],
            person['condition_3'],
            person['condition_4']
          ].where((condition) => condition != null).toList();

          print('CONDIÇÕES DO PERSONAGEM ${person['name']}: $conditions');

          return CardPersonInCombat(
            isTurn: isActive,
            id: person['id'],
            combatId: person['combat_id'],
            name: person['name'],
            player: 'teste',
            armor: person['armor'],
            lifeMax: person['lifeMax'],
            lifeActual: person['lifeActual'],
            type: person['type'],
            iniciative: person['iniciative'],
            conditions: conditions,
          );
        },
      ),
    );
  }
}
