import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/character_repository.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Buttons/ButtonAddItemList.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Lists/ListSimple.dart';

class Characterlistscreen extends StatefulWidget {
  const Characterlistscreen({super.key});

  @override
  State<Characterlistscreen> createState() => _CharacterlistscreenState();
}

class _CharacterlistscreenState extends State<Characterlistscreen> {
  final CharacterRepository _repository = CharacterRepository();
  List<Map<String, dynamic>> _characters = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCharacters();
  }

  Future<void> _loadCharacters() async {
    setState(() {
      _isLoading = true;
    });
    final characters = await _repository.getAllCharacters();
    setState(() {
      _characters = characters;
      _isLoading = false;
      print(_characters);
    });
  }

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
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.6,
              child: ListSimple(
                selectIcon: 0,
                emptyList: 'Não há jogadores cadastrado',
                itemsList: _characters,
              ),
            ),
          )
        ],
      ),
    );
  }
}
