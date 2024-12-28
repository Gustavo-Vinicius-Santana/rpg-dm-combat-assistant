import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Cards/CardPersonInCombat.dart';

class ListCombat extends StatefulWidget {
  const ListCombat({super.key, required this.personsInCombat});
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

          final List conditions = [
            person['condition_1'],
            person['condition_2'],
            person['condition_3'],
            person['condition_4']
          ].where((condition) => condition != null).toList();

          print('CONDIÇÕES DO PERSONAGEM ${person['name']}: $conditions');

          return CardPersonInCombat(
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
