import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Icons/IconsSvg.dart';

class ListSimple extends StatefulWidget {
  const ListSimple(
      {super.key, required this.selectIcon, required this.emptyList});
  final int selectIcon;
  final String emptyList;

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
    return items.isEmpty
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
            itemCount: items.length,
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
                      items[index],
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          );
  }
}
