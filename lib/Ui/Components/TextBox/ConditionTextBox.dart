import 'package:flutter/material.dart';

class ConditionTextBox extends StatefulWidget {
  const ConditionTextBox({super.key, required this.condition});
  final String condition;

  @override
  State<ConditionTextBox> createState() => _ConditionTextBoxState();
}

class _ConditionTextBoxState extends State<ConditionTextBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        widget.condition,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}
