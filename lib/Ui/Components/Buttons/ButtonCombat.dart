import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Icons/IconsSvg.dart';

class ButtonCombat extends StatefulWidget {
  const ButtonCombat(
      {super.key,
      required this.label,
      required this.iconSelect,
      required this.onPress});

  final String label;
  final int iconSelect;

  final Function() onPress;

  @override
  State<ButtonCombat> createState() => _ButtonCombatState();
}

class _ButtonCombatState extends State<ButtonCombat> {
  final List iconList = [
    AppIcons.jogadorCabecaIcon(color: Colors.white),
    AppIcons.monstrosCabecaIcon(color: Colors.white),
    AppIcons.combateEspadasIcon(color: Colors.white),
    const Icon(Icons.refresh, color: Colors.white),
  ];

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        widget.onPress();
      },
      style: OutlinedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          iconList[widget.iconSelect],
        ],
      ),
    );
  }
}
