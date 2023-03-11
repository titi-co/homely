import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homely/src/bloc/propertiesBloc/properties_bloc_bloc.dart';
import 'package:homely/src/models/property_model.dart';
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

  set string(String value) => setState(() => image = value);

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

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
                      callback: (value) => setState(() => image = value))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

typedef void StringCallback(String val);

class ImageUploader extends StatefulWidget {
  const ImageUploader({
    super.key,
    required this.callback,
  });

  final StringCallback callback;

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 1);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
      List<int> imageBytes = await this.image!.readAsBytes();

      print(imageBytes.length);

      String base64Image = base64Encode(imageBytes);

      widget.callback(base64Image);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    } catch (e) {
      print('Something went wrong: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: pickImage,
          child: Chip(
            labelPadding: const EdgeInsets.all(8),
            avatar: CircleAvatar(
              backgroundColor: image != null ? Colors.green : Colors.teal,
              child: image != null
                  ? const Icon(
                      Icons.done,
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.upload,
                      color: Colors.white,
                    ),
            ),
            label: Text(image != null ? image!.path : 'Send image'),
          ),
        ),
        const SizedBox(
          height: ThemeVariables.md,
        ),
        image != null ? Image.file(image!) : const Text("No image selected")
      ],
    );
  }
}
