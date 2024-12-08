import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Buttons/ButtonAddItemList.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Lists/ListSimple.dart';

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
      body: Column(
        children: [
          Center(
            child: ButtonAddItemList(
              action: () {},
              label: 'Adicionar personagem',
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.55,
              height: MediaQuery.of(context).size.height * 0.6,
              child: const ListSimple(
                selectIcon: 0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
