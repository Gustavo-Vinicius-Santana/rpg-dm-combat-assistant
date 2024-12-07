import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Buttons/ButtonAddItemList.dart';

class Combatlistscreen extends StatefulWidget {
  const Combatlistscreen({super.key});

  @override
  State<Combatlistscreen> createState() => _CombatlistscreenState();
}

class _CombatlistscreenState extends State<Combatlistscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Combates'),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ButtonAddItemList(
              action: () {},
              label: 'Adicionar combate',
            ),
          ],
        ),
      ),
    );
  }
}
