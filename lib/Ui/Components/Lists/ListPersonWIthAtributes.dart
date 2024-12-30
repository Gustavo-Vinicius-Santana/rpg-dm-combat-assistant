import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Data/repositories/character_repository.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Icons/IconsSvg.dart';

class ListPersonWithAtributes extends StatefulWidget {
  const ListPersonWithAtributes(
      {super.key,
      required this.itemsList,
      required this.selectIcon,
      required this.emptyList});

  final String emptyList;
  final int selectIcon;
  final List<Map<String, dynamic>> itemsList;

  @override
  State<ListPersonWithAtributes> createState() =>
      _ListPersonWithAtributesState();
}

class _ListPersonWithAtributesState extends State<ListPersonWithAtributes> {
  final CharacterRepository characterRepository = CharacterRepository();
  List<Map<String, dynamic>> _characters = [];

  @override
  void initState() {
    super.initState();
    print('estado iniciado');
    _loadCharacters();
  }

  Future<void> _loadCharacters() async {
    try {
      final characters = await characterRepository.getAllCharacters();
      setState(() {
        _characters = characters;
        print(_characters);
      });
    } catch (e) {
      print('Erro ao carregar personagens: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final List iconList = [
      AppIcons.jogadorCabecaIcon(),
      AppIcons.monstrosCabecaIcon(),
      AppIcons.combateEspadasIcon(),
    ];

    final List bigIconList = [
      AppIcons.jogadorBigCabecaIcon(),
      AppIcons.monstrosBigCabecaIcon(),
      AppIcons.combateBigEspadasIcon(),
    ];
    return _characters.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                bigIconList[widget.selectIcon],
                Text(
                  widget.emptyList,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: _characters.length,
            itemBuilder: (context, index) {
              final item = _characters[index];
              bool isChecked = false;

              return ListTile(
                title: Row(
                  children: [
                    iconList[widget.selectIcon],
                    Expanded(
                      child: Text(item['name']),
                    ),
                    Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                    ),
                  ],
                ),
                subtitle: Column(
                  children: [
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('PV'),
                            Text('${item['lifeActual']}/${item['lifeMax']}'),
                          ],
                        ),
                        Column(
                          children: [
                            Text('ARMOR'),
                            Text('${item['armor']}'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
  }
}
