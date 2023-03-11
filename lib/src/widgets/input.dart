import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({
    super.key,
    required this.label,
    this.isMultline = false,
    required this.controller,
    this.type = TextInputType.text,
    this.correct = true,
    this.capitalization = TextCapitalization.none,
    this.obscure = false,
    this.maxLength,
  });

  final String label;
  final bool isMultline;
  final TextEditingController controller;
  final TextInputType type;
  final bool correct;
  final TextCapitalization capitalization;
  final bool obscure;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscure,
      maxLength: maxLength,
      textCapitalization: capitalization,
      enableSuggestions: correct,
      autocorrect: correct,
      keyboardType: type,
      validator: (value) {
        if (value!.isEmpty) return "This field cannot be empty!";
      },
      controller: controller,
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
