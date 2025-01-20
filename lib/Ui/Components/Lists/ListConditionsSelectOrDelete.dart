import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Cards/CardConditionWithDescription.dart';

class ListConditionsSelectOrDelete extends StatefulWidget {
  const ListConditionsSelectOrDelete({super.key, required this.conditionsList});

  final List conditionsList;

  @override
  State<ListConditionsSelectOrDelete> createState() =>
      _ListConditionsSelectOrDeleteState();
}

class _ListConditionsSelectOrDeleteState
    extends State<ListConditionsSelectOrDelete> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: widget.conditionsList.length,
      itemBuilder: (context, index) {
        return CardConditionWhithDescription(
          name: widget.conditionsList[index]['name_id'],
          description: widget.conditionsList[index]['description'],
          type: 'select',
        );
      },
    );
  }
}
