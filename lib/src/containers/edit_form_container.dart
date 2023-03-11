import 'package:flutter/material.dart';
import 'package:homely/src/theme/constants.dart';
import 'package:homely/src/widgets/input.dart';

class EditFormContainer extends StatelessWidget {
  const EditFormContainer({
    super.key,
    required this.nameController,
    required this.descriptionController,
    required this.streetController,
    required this.districtController,
    required this.cityController,
    required this.stateController,
  });

  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController streetController;
  final TextEditingController districtController;
  final TextEditingController cityController;
  final TextEditingController stateController;

  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }
}
