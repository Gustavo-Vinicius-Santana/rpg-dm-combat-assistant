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
  final List<int> selectedItemsToDelete = [];
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
      await Future.delayed(const Duration(milliseconds: 500));
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

  Future<void> _openMonsterEdit(int id) async {
    Navigator.pushNamed(
      context,
      '/mosterEdit',
      arguments: id,
    );
  }

  Future<void> _deleteCharacter(List<int> id) async {
    try {
      await _monstersRepository.deleteRowsByIds(id);
      print(_monsters);
      setState(() {
        selectedItemsToDelete.clear();
      });
      await _loadMonsters();
    } catch (e) {
      print(e);
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
                  actionAdd: () {
                    Navigator.pushNamed(context, '/monsterRegister');
                  },
                  actionDelete: () {
                    _deleteCharacter(selectedItemsToDelete);
                  },
                  label: selectedItemsToDelete.isNotEmpty
                      ? 'Deletar mostro(s)'
                      : 'Adicionar mostro',
                  isDelete: selectedItemsToDelete.isNotEmpty,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: ListSimple(
                      selectIcon: 1,
                      emptyList: 'Não há monstros cadastrados',
                      itemsList: _monsters,
                      selectedItemsToDelete: selectedItemsToDelete,
                      openEdit: _openMonsterEdit,
                      onSelectionChanged: (selectedItems) {
                        setState(() {
                          selectedItemsToDelete.clear();
                          selectedItemsToDelete.addAll(selectedItems);
                        });
                      },
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
