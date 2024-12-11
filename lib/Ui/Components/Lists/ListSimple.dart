import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Icons/IconsSvg.dart';

class ListSimple extends StatefulWidget {
  const ListSimple(
      {super.key,
      required this.selectIcon,
      required this.emptyList,
      required this.itemsList});
  final int selectIcon;
  final String emptyList;
  final List<Map<String, dynamic>> itemsList;
  @override
  State<ListSimple> createState() => _ListSimpleState();
}

class _ListSimpleState extends State<ListSimple> {
  final List<String> items = [];

  final List iconList = [
    AppIcons.jogadorCabecaIcon(),
    AppIcons.monstrosCabecaIcon(),
    AppIcons.combateEspadasIcon()
  ];

  final List bigIconList = [
    AppIcons.jogadorBigCabecaIcon(),
    AppIcons.monstrosBigCabecaIcon(),
    AppIcons.combateBigEspadasIcon()
  ];

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
                    fontWeight: FontWeight.bold),
              ),
            ],
          ))
        : ListView.builder(
            shrinkWrap: true,
            itemCount: widget.itemsList.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () => print(items[index]),
                title: Row(
                  children: [
                    iconList[widget.selectIcon],
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.itemsList[index]['player'],
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          );
  }
}
