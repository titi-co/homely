import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImageUtils {
  Image? imageFromBase64String({String? base64String, fit = BoxFit.cover}) {
    if (base64String == null) return null;
    base64String = base64String.replaceAll('data:image/jpeg;base64,', '');

    return Image(
      fit: fit,
      image: MemoryImage(
        base64Decode(base64String),
      ),
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }

        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.secondary,
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    );
  }

  bool isAValidBase64Image(String base64String) {
    if (base64String == "") return false;

    return true;
  }
}
