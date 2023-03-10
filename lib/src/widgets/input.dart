import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input(
      {super.key,
      required this.label,
      this.isMultline = false,
      required this.controller});

  final String label;
  final bool isMultline;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: isMultline ? 5 : 1,
      minLines: 1,
      cursorColor: Theme.of(context).colorScheme.brightness == Brightness.light
          ? Colors.black
          : Colors.white,
      decoration: InputDecoration(
        floatingLabelStyle: TextStyle(
            color: Theme.of(context).colorScheme.brightness == Brightness.light
                ? Colors.black
                : Colors.white),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color:
                  Theme.of(context).colorScheme.brightness == Brightness.light
                      ? Colors.black
                      : Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: label,
      ),
    );
  }
}
