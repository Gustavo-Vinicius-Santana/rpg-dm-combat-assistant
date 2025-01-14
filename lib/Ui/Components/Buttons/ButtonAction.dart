import 'package:flutter/material.dart';

class ButtonAction extends StatefulWidget {
  const ButtonAction(
      {super.key, required this.onPressed, required this.textInButton});
  final Function onPressed;
  final String textInButton;

  @override
  State<ButtonAction> createState() => _ButtonActionState();
}

class _ButtonActionState extends State<ButtonAction> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        widget.onPressed();
      },
      child: Text(widget.textInButton),
    );
  }
}
