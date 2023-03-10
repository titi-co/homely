import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
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
  final controller = TextEditingController();

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
                  Input(
                    controller: controller,
                    label: "Place name",
                  ),
                  SizedBox(
                    height: ThemeVariables.md,
                  ),
                  Input(
                    controller: controller,
                    label: "Description",
                    isMultline: true,
                  ),
                  const SizedBox(
                    height: ThemeVariables.md,
                  ),
                  Input(
                    controller: controller,
                    label: "Street",
                  ),
                  const SizedBox(
                    height: ThemeVariables.md,
                  ),
                  Input(
                    controller: controller,
                    label: "District",
                  ),
                  const SizedBox(
                    height: ThemeVariables.md,
                  ),
                  Input(
                    controller: controller,
                    label: "City",
                  ),
                  const SizedBox(
                    height: ThemeVariables.md,
                  ),
                  Input(
                    controller: controller,
                    label: "State",
                  ),
                  const SizedBox(
                    height: ThemeVariables.md,
                  ),
                  ImageUploader()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ImageUploader extends StatefulWidget {
  const ImageUploader({
    super.key,
  });

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
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
