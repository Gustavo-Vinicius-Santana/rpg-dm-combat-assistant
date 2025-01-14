import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  const InputText(
      {super.key,
      required this.controller,
      this.errorMessage,
      required this.maxLength,
      required this.placeholder,
      required this.label});
  final TextEditingController controller;
  final int maxLength;

  final String? errorMessage;
  final String placeholder;
  final String label;

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  int _charCount = 0;

  @override
  void initState() {
    super.initState();
    _charCount = widget.controller.text.length;
    widget.controller.addListener(_updateCharCounter);
  }

  void _updateCharCounter() {
    setState(() {
      _charCount = widget.controller.text.length;
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateCharCounter);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        controller: widget.controller,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
          labelText: '${widget.label} *',
          hintText: widget.placeholder,
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
          counterText: '$_charCount/${widget.maxLength}',
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
      ),
    );
  }
}
