import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Buttons/ButtonAddItemList.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Lists/ListSimple.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/combats_repository.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Loadings/Loading.dart';

class Combatlistscreen extends StatefulWidget {
  const Combatlistscreen({super.key});

  @override
  State<Combatlistscreen> createState() => _CombatlistscreenState();
}

class _CombatlistscreenState extends State<Combatlistscreen> {
  final CombatsRepository _combatsRepository = CombatsRepository();
  final List<int> selectedItemsToDelete = [];
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

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final combats = await _combatsRepository.getAllCombats();
      setState(() {
        _combats = combats;
        isLoading = false;
      });
    } catch (e) {
      print('Erro ao carregar combates: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _openCombat(int id) async {
    Navigator.pushNamed(
      context,
      '/combatScreen',
      arguments: id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Combates'),
        ),
      ),
      body: isLoading
          ? const Center(
              child: Loading(),
            )
          : Column(
              children: [
                ButtonAddItemList(
                  actionAdd: () {
                    Navigator.pushNamed(context, '/combatRegister');
                  },
                  actionDelete: () {},
                  label: 'Adicionar combate',
                  isDelete: false,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: ListSimple(
                      selectIcon: 2,
                      emptyList: 'Não há combates cadastrados',
                      itemsList: _combats,
                      selectedItemsToDelete: selectedItemsToDelete,
                      openEdit: _openCombat,
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
