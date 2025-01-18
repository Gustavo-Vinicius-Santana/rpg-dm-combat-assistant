import 'package:flutter/material.dart';
import 'package:rpg_dm_combat_assistant/Ui/Components/Cards/CardConditionEditOrDelete.dart';

class ListConditionsEditOrDelete extends StatefulWidget {
  const ListConditionsEditOrDelete({super.key, required this.personConditions});
  final List personConditions;

  @override
  State<ListConditionsEditOrDelete> createState() =>
      _ListConditionsEditOrDeleteState();
}

class _ListConditionsEditOrDeleteState
    extends State<ListConditionsEditOrDelete> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: widget.personConditions.length,
      itemBuilder: (context, index) {
        return Column(children: [
          CardConditionEditOrDelete(
            name: widget.personConditions[index],
            description: 'teste',
          ),
        ]);
      },
    );
  }
}
