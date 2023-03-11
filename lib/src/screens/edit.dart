import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homely/src/bloc/propertiesBloc/properties_bloc_bloc.dart';
import 'package:homely/src/models/property_model.dart';
import 'package:homely/src/theme/constants.dart';
import 'package:homely/src/utils/image.dart';
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
          image,
          "",
        ),
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
                    propertyImage: image,
                    callback: (value) => setState(() => image = value),
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

typedef void StringCallback(String val);

class ImageUploader extends StatefulWidget {
  const ImageUploader({
    super.key,
    required this.callback,
    this.propertyImage,
  });

  final StringCallback callback;
  final String? propertyImage;

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
        widget.propertyImage != null
            ? ImageUtils().imageFromBase64String(
                    base64String: widget.propertyImage) ??
                const MissingImage()
            : image != null
                ? Image.file(image!)
                : const Text("No image selected")
      ],
    );
  }
}
