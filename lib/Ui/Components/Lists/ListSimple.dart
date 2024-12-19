import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Icons/IconsSvg.dart';

class ListSimple extends StatefulWidget {
  const ListSimple({
    super.key,
    required this.selectIcon,
    required this.emptyList,
    required this.itemsList,
    required this.openEdit,
    required this.selectedItemsToDelete,
    required this.onSelectionChanged,
  });

  final Function(List<int>) onSelectionChanged;
  final List<int> selectedItemsToDelete;
  final Function openEdit;
  final int selectIcon;
  final String emptyList;
  final List<Map<String, dynamic>> itemsList;

  @override
  State<ListSimple> createState() => _ListSimpleState();
}

class _ListSimpleState extends State<ListSimple> {
  bool _isSelectionMode = false;

  final List<int> _localSelectedItems = [];

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

  void _toggleSelectionMode(int? itemId) {
    setState(() {
      _isSelectionMode = true; // Ativa o modo de seleção
      if (itemId != null && !_localSelectedItems.contains(itemId)) {
        _localSelectedItems.add(itemId); // Adiciona o item clicado
      }
      widget.onSelectionChanged(List<int>.from(_localSelectedItems));
    });
  }

  void _toggleItemSelection(int id) {
    setState(() {
      if (_localSelectedItems.contains(id)) {
        _localSelectedItems.remove(id);
      } else {
        _localSelectedItems.add(id);
      }

      if (_localSelectedItems.isEmpty) {
        _isSelectionMode = false;
      }

      widget.onSelectionChanged(List<int>.from(_localSelectedItems));
    });
  }

  @override
  Widget build(BuildContext context) {
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
              final bool isSelected = _localSelectedItems.contains(itemId);

              return ListTile(
                onTap: _isSelectionMode
                    ? () => _toggleItemSelection(itemId)
                    : () {
                        widget.openEdit(itemId);
                      },
                onLongPress: () => _toggleSelectionMode(itemId),
                title: Row(
                  children: [
                    iconList[widget.selectIcon],
                    const SizedBox(width: 5),
                    Text(
                      item['name'],
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                trailing: _isSelectionMode
                    ? Checkbox(
                        value: isSelected,
                        onChanged: (_) => _toggleItemSelection(itemId),
                      )
                    : null,
                selected: isSelected,
                selectedTileColor: Colors.grey[300],
              );
            },
          );
  }
}
