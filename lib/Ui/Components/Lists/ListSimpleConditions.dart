import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Cards/CardSimpleCondition%20.dart';

class ListSimpleConditions extends StatefulWidget {
  const ListSimpleConditions({super.key, required this.personConditions});
  final List personConditions;

  @override
  State<ListSimpleConditions> createState() => _ListSimpleConditionsState();
}

class _ListSimpleConditionsState extends State<ListSimpleConditions> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: widget.personConditions.length,
      itemBuilder: (context, index) {
        return Column(children: [
          CardSimpleCondition(
            name: widget.personConditions[index],
            description: 'teste',
          ),
        ]);
      },
    );
  }
}
