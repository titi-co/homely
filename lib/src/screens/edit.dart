import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homely/src/bloc/propertiesBloc/properties_bloc_bloc.dart';
import 'package:homely/src/models/property_model.dart';
import 'package:homely/src/theme/constants.dart';
import 'package:homely/src/utils/image.dart';
import 'package:homely/src/widgets/image_uploader.dart';
import 'package:homely/src/widgets/input.dart';
import 'package:homely/src/widgets/missing_image.dart';
import 'package:image_picker/image_picker.dart';

class EditPlace extends StatefulWidget {
  const EditPlace({super.key, this.property});

  final Property? property;

  static const routeName = "/edit";

  @override
  State<EditPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<EditPlace> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final streetController = TextEditingController();
  final districtController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  String image = "";
  File? imageFile;

  set string(String value) => setState(() => image = value);

  _onEditButtonPressed() {
    BlocProvider.of<PropertiesBloc>(context).add(
      PropertyUpdate(
        Property(
          widget.property!.id,
          nameController.text,
          descriptionController.text,
          streetController.text,
          districtController.text,
          cityController.text,
          stateController.text,
          widget.property!.image,
          "",
        ),
        imageFile!,
      ),
    );
  }

  @override
  void initState() {
    nameController.text = widget.property!.name;
    descriptionController.text = widget.property!.description;
    streetController.text = widget.property!.street;
    districtController.text = widget.property!.district;
    cityController.text = widget.property!.city;
    stateController.text = widget.property!.state;
    image = widget.property!.image;
    super.initState();
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
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(ThemeVariables.md),
              child: FilledButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.secondary),
                ),
                onPressed: _onEditButtonPressed,
                child: Padding(
                  padding: const EdgeInsets.all(ThemeVariables.md),
                  child: Text(
                    "Edit place",
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
                        "Edit place",
                        style: ThemeVariables.sheetTitle,
                      ),
                      const SizedBox(
                        height: ThemeVariables.lg,
                      ),
                      Input(
                        controller: nameController,
                        label: "Place name",
                      ),
                      const SizedBox(
                        height: ThemeVariables.md,
                      ),
                      Input(
                        controller: descriptionController,
                        label: "Description",
                        isMultline: true,
                      ),
                      const SizedBox(
                        height: ThemeVariables.md,
                      ),
                      Input(
                        controller: streetController,
                        label: "Street",
                      ),
                      const SizedBox(
                        height: ThemeVariables.md,
                      ),
                      Input(
                        controller: districtController,
                        label: "District",
                      ),
                      const SizedBox(
                        height: ThemeVariables.md,
                      ),
                      Input(
                        controller: cityController,
                        label: "City",
                      ),
                      const SizedBox(
                        height: ThemeVariables.md,
                      ),
                      Input(
                        controller: stateController,
                        label: "State",
                      ),
                      const SizedBox(
                        height: ThemeVariables.md,
                      ),
                      ImageUploader(
                        callback: (value) => setState(() => imageFile = value),
                      )
                    ],
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
