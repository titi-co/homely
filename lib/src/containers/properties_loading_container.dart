import 'package:flutter/material.dart';
import 'package:homely/src/theme/constants.dart';

class PropertiesLoadingContainer extends StatelessWidget {
  const PropertiesLoadingContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "My places",
            style: ThemeVariables.sectionHeader,
          ),
          const SizedBox(
            height: ThemeVariables.md,
          ),
          Expanded(
            child: Center(
              child: CircularProgressIndicator(
                value: null,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
