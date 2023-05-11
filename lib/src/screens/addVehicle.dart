import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homely/src/bloc/propertiesBloc/properties_bloc_bloc.dart';
import 'package:homely/src/containers/edit_form_container.dart';
import 'package:homely/src/models/property_model.dart';
import 'package:homely/src/theme/constants.dart';
import 'package:homely/src/utils/sqlite.dart';
import 'package:homely/src/widgets/image_uploader.dart';
import 'package:homely/src/widgets/input.dart';
import 'package:sqflite/sqflite.dart';

class AddVehicle extends StatefulWidget {
  const AddVehicle({super.key, this.property, this.loadCallback});

  final Property? property;
  final dynamic loadCallback;

  static const routeName = "/addVehicle";

  @override
  State<AddVehicle> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddVehicle> {
  final modelController = TextEditingController();
  final colorController = TextEditingController();

  _onAddButtonPressed() async {
    Database db = await SQLiteUtils().db();
    Map<String, dynamic> vehicle = {
      "model": modelController.text,
      "color": colorController.text,
      "propertyid": widget.property!.id
    };
    int response = await db.insert("vehicles", vehicle);
    print("Saved: $response");

    widget.loadCallback();
    Navigator.pop(context);
  }

  @override
  void initState() {
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
                onPressed: _onAddButtonPressed,
                child: Padding(
                  padding: const EdgeInsets.all(ThemeVariables.md),
                  child: Text(
                    "Add Vehicle",
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add Vehicle",
                        style: ThemeVariables.sheetTitle,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Input(label: "Model", controller: modelController),
                      SizedBox(
                        height: 16,
                      ),
                      Input(label: "Color", controller: colorController),
                      SizedBox(
                        height: 16,
                      ),
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
