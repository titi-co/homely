import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homely/src/bloc/propertiesBloc/properties_bloc_bloc.dart';
import 'package:homely/src/containers/add_form_container.dart';
import 'package:homely/src/models/property_model.dart';
import 'package:homely/src/theme/constants.dart';
import 'package:homely/src/widgets/image_uploader.dart';

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
  File? image;

  final _formKey = GlobalKey<FormState>();

  set string(File value) => setState(() => image = value);

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
            "",
            ""),
        image!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PropertiesBloc, PropertiesBlocState>(
      builder: (context, state) {
        if (state is PropertiesBlocLoadingState) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                value: null,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          );
        }
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(ThemeVariables.md),
              child: FilledButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.secondary),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate() && image != null) {
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
                          : Colors.white,
                    ),
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
                        AddFormContainer(
                          nameController: nameController,
                          descriptionController: descriptionController,
                          streetController: streetController,
                          districtController: districtController,
                          cityController: cityController,
                          stateController: stateController,
                        ),
                        ImageUploader(
                          callback: (value) => setState(() => image = value),
                        ),
                        image == null
                            ? Text(
                                "Please send an image",
                                style: ThemeVariables.bodyRegular.copyWith(
                                  color: Colors.red,
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
