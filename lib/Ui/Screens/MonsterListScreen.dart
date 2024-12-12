import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Buttons/ButtonAddItemList.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Lists/ListSimple.dart';
import 'package:rpg_dm_combat_assistant/data/repositories/monsters_repository.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Loadings/Loading.dart';

class Monsterlistscreen extends StatefulWidget {
  const Monsterlistscreen({super.key});

  @override
  State<Monsterlistscreen> createState() => _MonsterlistscreenState();
}

class _MonsterlistscreenState extends State<Monsterlistscreen> {
  final MonstersRepository _monstersRepository = MonstersRepository();
  List<Map<String, dynamic>> _monsters = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMonsters();
  }

  Future<void> _loadMonsters() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await Future.delayed(const Duration(seconds: 1));
      _monsters = await _monstersRepository.getAllMonsters();
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Erro ao carregar monstros: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Monstros'),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: Loading(),
            )
          : Column(
              children: [
                ButtonAddItemList(
                  action: () {},
                  label: 'Adicionar monstro',
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: ListSimple(
                      selectIcon: 1,
                      emptyList: 'Não há monstros cadastrados',
                      itemsList: _monsters,
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
