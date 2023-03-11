import 'package:flutter/material.dart';
import 'package:homely/src/theme/constants.dart';

class MissingImage extends StatelessWidget {
  const MissingImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      alignment: Alignment.center,
      child: Text(
        "Image missing...",
        style: ThemeVariables.sheetTitle.copyWith(
            color: Theme.of(context).colorScheme.brightness == Brightness.dark
                ? Colors.black
                : Colors.white),
      ),
    );
  }
}
