import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homely/src/bloc/propertiesBloc/properties_bloc_bloc.dart';
import 'package:homely/src/models/property_model.dart';
import 'package:homely/src/screens/edit.dart';
import 'package:homely/src/theme/constants.dart';
import 'package:homely/src/widgets/input.dart';
import 'package:image_picker/image_picker.dart';

class AddPlace extends StatefulWidget {
  const AddPlace({super.key});

  static const routeName = "/add";

  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final streetController = TextEditingController();
  final districtController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  String image = "";

  final _formKey = GlobalKey<FormState>();

  set string(String value) => setState(() => image = value);

  _onAddButtonPressed() {
    BlocProvider.of<PropertiesBloc>(context).add(
      PropertyAdd(
        Property(
            "",
            nameController.text,
            descriptionController.text,
            streetController.text,
            districtController.text,
            cityController.text,
            stateController.text,
            image,
            ""),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(elevation: 0),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(ThemeVariables.md),
          child: FilledButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.secondary),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _onAddButtonPressed();
              }
            },
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
              child: Form(
                key: _formKey,
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
                    Input(
                      maxLength: 24,
                      capitalization: TextCapitalization.sentences,
                      controller: nameController,
                      label: "Place name",
                    ),
                    const SizedBox(
                      height: ThemeVariables.md,
                    ),
                    Input(
                      type: TextInputType.multiline,
                      capitalization: TextCapitalization.sentences,
                      controller: descriptionController,
                      label: "Description",
                      isMultline: true,
                    ),
                    const SizedBox(
                      height: ThemeVariables.md,
                    ),
                    Input(
                      maxLength: 20,
                      capitalization: TextCapitalization.sentences,
                      controller: streetController,
                      label: "Street",
                    ),
                    const SizedBox(
                      height: ThemeVariables.md,
                    ),
                    Input(
                      maxLength: 20,
                      capitalization: TextCapitalization.sentences,
                      controller: districtController,
                      label: "District",
                    ),
                    const SizedBox(
                      height: ThemeVariables.md,
                    ),
                    Input(
                      maxLength: 20,
                      capitalization: TextCapitalization.sentences,
                      controller: cityController,
                      label: "City",
                    ),
                    const SizedBox(
                      height: ThemeVariables.md,
                    ),
                    Input(
                      maxLength: 20,
                      capitalization: TextCapitalization.sentences,
                      controller: stateController,
                      label: "State",
                    ),
                    const SizedBox(
                      height: ThemeVariables.md,
                    ),
                    ImageUploader(
                        callback: (value) => setState(() => image = value))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
