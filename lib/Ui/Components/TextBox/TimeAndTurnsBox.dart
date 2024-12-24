import 'package:flutter/material.dart';

class TimesAndTurnsBox extends StatefulWidget {
  const TimesAndTurnsBox({super.key, required this.text});
  final String text;

  @override
  State<TimesAndTurnsBox> createState() => _TimesAndTurnsBoxState();
}

class _TimesAndTurnsBoxState extends State<TimesAndTurnsBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.6),
        border: Border.all(
          color: Colors.black38,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          widget.text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
