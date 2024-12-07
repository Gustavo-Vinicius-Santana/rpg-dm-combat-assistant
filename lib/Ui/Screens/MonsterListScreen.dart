import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Buttons/ButtonAddItemList.dart';

class Monsterlistscreen extends StatefulWidget {
  const Monsterlistscreen({super.key});

  @override
  State<Monsterlistscreen> createState() => _MonsterlistscreenState();
}

class _MonsterlistscreenState extends State<Monsterlistscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Monstros'),
          ),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              ButtonAddItemList(
                action: () {},
                label: 'Adicionar monstro',
              )
            ],
          ),
        ));
  }
}
