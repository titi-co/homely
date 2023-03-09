import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:homely/src/theme/constants.dart';

class AddPlace extends StatelessWidget {
  const AddPlace({super.key});

  static const routeName = "/add";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(ThemeVariables.md),
          child: FilledButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.secondary),
            ),
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.all(ThemeVariables.md),
              child: Text(
                "Add place",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.brightness ==
                            Brightness.dark
                        ? Colors.black
                        : Colors.white),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: ThemeVariables.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add place",
                    style: ThemeVariables.sheetTitle,
                  ),
                  const SizedBox(
                    height: ThemeVariables.lg,
                  ),
                  const AddField(
                    label: "Place name",
                  ),
                  const SizedBox(
                    height: ThemeVariables.md,
                  ),
                  const AddField(
                    label: "Description",
                    isMultline: true,
                  ),
                  const SizedBox(
                    height: ThemeVariables.md,
                  ),
                  const AddField(
                    label: "Street",
                  ),
                  const SizedBox(
                    height: ThemeVariables.md,
                  ),
                  const AddField(
                    label: "District",
                  ),
                  const SizedBox(
                    height: ThemeVariables.md,
                  ),
                  const AddField(
                    label: "City",
                  ),
                  const SizedBox(
                    height: ThemeVariables.md,
                  ),
                  const AddField(
                    label: "State",
                  ),
                  const SizedBox(
                    height: ThemeVariables.md,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Chip(
                      labelPadding: EdgeInsets.all(8),
                      avatar: CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Icon(
                          Icons.done,
                          color: Colors.white,
                        ),
                      ),
                      label: Text('Send image'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AddField extends StatelessWidget {
  const AddField({super.key, required this.label, this.isMultline = false});

  final String label;
  final bool isMultline;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: isMultline ? 5 : 1,
      minLines: 1,
      decoration: InputDecoration(
        floatingLabelStyle: const TextStyle(color: Colors.black),
        focusedBorder: OutlineInputBorder(
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
