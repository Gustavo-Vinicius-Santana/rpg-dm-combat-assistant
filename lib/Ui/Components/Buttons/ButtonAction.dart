import 'package:flutter/material.dart';

class ButtonAction extends StatefulWidget {
  const ButtonAction(
      {super.key,
      required this.onPressed,
      required this.textInButton,
      required this.width,
      required this.height,
      required this.fontSize});
  final Function onPressed;
  final String textInButton;
  final double fontSize;
  final double width;
  final double height;

  @override
  State<ButtonAction> createState() => _ButtonActionState();
}

class _ButtonActionState extends State<ButtonAction> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
        onPressed: () {
          widget.onPressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          widget.textInButton,
          style: TextStyle(color: Colors.white, fontSize: widget.fontSize),
        ),
      ),
    );
  }
}
