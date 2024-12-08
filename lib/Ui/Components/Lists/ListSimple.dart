import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Icons/IconsSvg.dart';

class ListSimple extends StatefulWidget {
  const ListSimple({super.key, required this.selectIcon});
  final int selectIcon;

  @override
  State<ListSimple> createState() => _ListSimpleState();
}

class _ListSimpleState extends State<ListSimple> {
  final List<String> items = [
    'guhthrum maximus',
    'Zamir',
    'Teste',
    'B22',
    'jogador 5',
    'jogador 6',
    'jogador 7',
    'jogador 8',
    'jogador 9',
    'jogador 10',
    'jogador 11',
    'jogador 12',
    'jogador 13',
    'jogador 14',
    'jogador 15',
    'jogador 16',
    'jogador 17',
    'jogador 18',
    'jogador 19',
    'jogador 20',
  ];

  final List iconList = [
    AppIcons.jogadorCabecaIcon(),
    AppIcons.monstrosCabecaIcon(),
    AppIcons.combateEspadasIcon()
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
