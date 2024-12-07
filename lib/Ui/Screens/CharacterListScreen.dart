import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Buttons/ButtonAddItemList.dart';

class Characterlistscreen extends StatefulWidget {
  const Characterlistscreen({super.key});

  @override
  State<Characterlistscreen> createState() => _CharacterlistscreenState();
}

class _CharacterlistscreenState extends State<Characterlistscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(
        child: Text('Personagens'),
      )),
      body: Center(
        child: Column(children: <Widget>[
          ButtonAddItemList(
            action: () {},
            label: 'Adicionar personagem',
          ),
        ]),
      ),
    );
  }
}
