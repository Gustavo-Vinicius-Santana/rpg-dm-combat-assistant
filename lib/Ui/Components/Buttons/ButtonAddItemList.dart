import 'package:flutter/material.dart';

class ButtonAddItemList extends StatefulWidget {
  const ButtonAddItemList(
      {super.key,
      required this.actionAdd,
      required this.label,
      required this.isDelete,
      required this.actionDelete});
  final Function actionAdd;
  final Function actionDelete;
  final String label;
  final bool isDelete;

  @override
  State<ButtonAddItemList> createState() => _ButtonAddItemListState();
}

class _ButtonAddItemListState extends State<ButtonAddItemList> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        widget.isDelete ? widget.actionDelete() : widget.actionAdd();
      },
      style: OutlinedButton.styleFrom(
          backgroundColor: widget.isDelete ? Colors.red : Colors.blue,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.isDelete
              ? const Icon(Icons.delete, color: Colors.white)
              : const Icon(Icons.add, color: Colors.white),
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
