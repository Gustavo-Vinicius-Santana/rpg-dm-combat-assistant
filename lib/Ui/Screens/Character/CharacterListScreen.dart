import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/character_repository.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Buttons/ButtonAddItemList.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Lists/ListSimple.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Loadings/Loading.dart';

class Characterlistscreen extends StatefulWidget {
  const Characterlistscreen({super.key});

  @override
  State<Characterlistscreen> createState() => _CharacterlistscreenState();
}

class _CharacterlistscreenState extends State<Characterlistscreen> {
  final CharacterRepository _repository = CharacterRepository();
  final List<int> selectedItemsToDelete = [];
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

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final characters = await _repository.getAllCharacters();
      setState(() {
        _characters = characters;
      });
    } catch (e) {
      print('Erro ao carregar personagens: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _openCharacterEdit(int id) async {
    Navigator.pushNamed(
      context,
      '/characterEdit',
      arguments: id,
    );
  }

  Future<void> _deleteCharacter(List<int> id) async {
    try {
      await _repository.deleteRowsByIds(id);
      print(_characters);
      setState(() {
        selectedItemsToDelete.clear();
      });
      await _loadCharacters();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(
        child: Text('Personagens'),
      )),
      body: _isLoading
          ? const Center(
              child: Loading(),
            )
          : Column(
              children: [
                Center(
                  child: ButtonAddItemList(
                    actionAdd: () {
                      Navigator.pushNamed(context, '/characterRegister');
                    },
                    actionDelete: () {
                      _deleteCharacter(selectedItemsToDelete);
                    },
                    isDelete: selectedItemsToDelete.isNotEmpty,
                    label: selectedItemsToDelete.isNotEmpty
                        ? 'Deletar personagem(s)'
                        : 'Adicionar personagem',
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
                      selectedItemsToDelete: selectedItemsToDelete,
                      openEdit: _openCharacterEdit,
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
