import 'package:flutter/material.dart';

class CardSimpleCondition extends StatefulWidget {
  const CardSimpleCondition(
      {super.key, required this.name, required this.description});
  final String name;
  final String description;

  @override
  State<CardSimpleCondition> createState() => _CardSimpleConditionState();
}

class _CardSimpleConditionState extends State<CardSimpleCondition> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Text('${widget.name}', style: const TextStyle(fontSize: 20.0)),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${widget.description}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
