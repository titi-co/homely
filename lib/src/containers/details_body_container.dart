import 'package:flutter/material.dart';
import 'package:homely/src/models/property_model.dart';
import 'package:homely/src/theme/constants.dart';

class PropertyDetailsBody extends StatelessWidget {
  const PropertyDetailsBody({
    super.key,
    required this.property,
  });

  final Property? property;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ThemeVariables.md,
              vertical: MediaQuery.of(context).padding.top + ThemeVariables.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                property!.name,
                style: ThemeVariables.sectionHeader,
              ),
              Text(
                property!.description,
                style: ThemeVariables.bodyRegular,
              ),
              const SizedBox(
                height: ThemeVariables.lg,
              ),
              Text(
                "Address",
                style: ThemeVariables.sectionHeader,
              ),
              const SizedBox(
                height: ThemeVariables.md,
              ),
              Text(
                "Street",
                style: ThemeVariables.bodyHeader,
              ),
              Text(
                property!.street,
                style: ThemeVariables.bodyRegular,
              ),
              const SizedBox(
                height: ThemeVariables.md,
              ),
              Text(
                "District",
                style: ThemeVariables.bodyHeader,
              ),
              Text(
                property!.district,
                style: ThemeVariables.bodyRegular,
              ),
              const SizedBox(
                height: ThemeVariables.md,
              ),
              Text(
                "City",
                style: ThemeVariables.bodyHeader,
              ),
              Text(
                property!.city,
                style: ThemeVariables.bodyRegular,
              ),
              const SizedBox(
                height: ThemeVariables.md,
              ),
              Text(
                "State",
                style: ThemeVariables.bodyHeader,
              ),
              Text(
                property!.state,
                style: ThemeVariables.bodyRegular,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
