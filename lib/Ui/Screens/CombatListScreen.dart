import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Buttons/ButtonAddItemList.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Lists/ListSimple.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/combats_repository.dart';

class Combatlistscreen extends StatefulWidget {
  const Combatlistscreen({super.key});

  @override
  State<Combatlistscreen> createState() => _CombatlistscreenState();
}

class _CombatlistscreenState extends State<Combatlistscreen> {
  final CombatsRepository _combatsRepository = CombatsRepository();
  List<Map<String, dynamic>> _combats = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCombats();
  }

  Future<void> _loadCombats() async {
    setState(() {
      isLoading = true;
    });
    final combats = await _combatsRepository.getAllCombats();
    setState(() {
      _combats = combats;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Combates'),
        ),
      ),
      body: Column(
        children: [
          ButtonAddItemList(
            action: () {},
            label: 'Adicionar combate',
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.6,
              child: ListSimple(
                selectIcon: 2,
                emptyList: 'Não há combates cadastrados',
                itemsList: _combats,
              ),
            ),
          )
        ],
      ),
    );
  }
}
