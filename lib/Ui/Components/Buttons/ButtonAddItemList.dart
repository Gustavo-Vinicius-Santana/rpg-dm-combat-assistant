import 'package:flutter/material.dart';

class ButtonAddItemList extends StatefulWidget {
  const ButtonAddItemList(
      {super.key, required this.action, required this.label});
  final Function action;
  final String label;

  @override
  State<ButtonAddItemList> createState() => _ButtonAddItemListState();
}

class _ButtonAddItemListState extends State<ButtonAddItemList> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => widget.action(),
      style: OutlinedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.add, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            widget.label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
