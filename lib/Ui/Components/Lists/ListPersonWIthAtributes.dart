import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Icons/IconsSvg.dart';

class ListPersonWithAtributes extends StatefulWidget {
  const ListPersonWithAtributes({
    super.key,
    required this.itemsList,
    required this.selectIcon,
    required this.emptyList,
    required this.selectedIds,
  });

  final String emptyList;
  final int selectIcon;
  final List<Map<String, dynamic>> itemsList;
  final List<int> selectedIds;

  @override
  State<ListPersonWithAtributes> createState() =>
      _ListPersonWithAtributesState();
}

class _ListPersonWithAtributesState extends State<ListPersonWithAtributes> {
  Set<int> _selectedIds = {};

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

    return widget.itemsList.isEmpty
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
            itemCount: widget.itemsList.length,
            itemBuilder: (context, index) {
              final item = widget.itemsList[index];
              final int itemId = item['id'];

              return ListTile(
                title: Row(
                  children: [
                    iconList[widget.selectIcon],
                    Expanded(
                      child: Text(item['name']),
                    ),
                    Checkbox(
                      value: _selectedIds.contains(itemId),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value ?? false) {
                            _selectedIds.add(itemId);
                          } else {
                            _selectedIds.remove(itemId);
                          }
                          widget.selectedIds
                            ..clear()
                            ..addAll(_selectedIds);
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
