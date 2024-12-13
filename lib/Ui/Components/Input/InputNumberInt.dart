import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputNumberInt extends StatefulWidget {
  const InputNumberInt(
      {super.key,
      required this.controller,
      this.errorMessage,
      required this.label});
  final TextEditingController controller;

  final String? errorMessage;
  final String label;

  @override
  State<InputNumberInt> createState() => _InputNumberIntState();
}

class _InputNumberIntState extends State<InputNumberInt> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: '${widget.label} *',
          hintText: '100',
          error: widget.errorMessage != null
              ? Text(
                  widget.errorMessage!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : null,
          hintStyle: const TextStyle(color: Colors.grey),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
          contentPadding: const EdgeInsets.only(bottom: 8),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*$')),
        ],
      ),
    );
  }
}
