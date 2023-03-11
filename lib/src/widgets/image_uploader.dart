import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homely/src/services/snackbar_service.dart';
import 'package:homely/src/theme/constants.dart';
import 'package:image_picker/image_picker.dart';

typedef StringCallback = void Function(String val);

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
      final image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 40,
        requestFullMetadata: false,
        maxHeight: 400,
        maxWidth: 400,
      );
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
      List<int> imageBytes = await this.image!.readAsBytes();

      String base64Image = base64Encode(imageBytes);

      widget.callback(base64Image);
    } on PlatformException catch (e) {
      SnackBarService.instance
          .showSnackBar("Something went wrong: $e", Colors.red);
    } catch (e) {
      SnackBarService.instance
          .showSnackBar("Something went wrong: $e", Colors.red);
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
