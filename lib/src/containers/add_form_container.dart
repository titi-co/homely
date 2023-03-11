import 'package:flutter/material.dart';
import 'package:homely/src/theme/constants.dart';
import 'package:homely/src/widgets/input.dart';

class AddFormContainer extends StatelessWidget {
  const AddFormContainer({
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
          "Add place",
          style: ThemeVariables.sheetTitle,
        ),
        const SizedBox(
          height: ThemeVariables.lg,
        ),
        Input(
          maxLength: 24,
          capitalization: TextCapitalization.sentences,
          controller: nameController,
          label: "Place name",
        ),
        const SizedBox(
          height: ThemeVariables.md,
        ),
        Input(
          type: TextInputType.multiline,
          capitalization: TextCapitalization.sentences,
          controller: descriptionController,
          label: "Description",
          isMultline: true,
        ),
        const SizedBox(
          height: ThemeVariables.md,
        ),
        Input(
          maxLength: 20,
          capitalization: TextCapitalization.sentences,
          controller: streetController,
          label: "Street",
        ),
        const SizedBox(
          height: ThemeVariables.md,
        ),
        Input(
          maxLength: 20,
          capitalization: TextCapitalization.sentences,
          controller: districtController,
          label: "District",
        ),
        const SizedBox(
          height: ThemeVariables.md,
        ),
        Input(
          maxLength: 20,
          capitalization: TextCapitalization.sentences,
          controller: cityController,
          label: "City",
        ),
        const SizedBox(
          height: ThemeVariables.md,
        ),
        Input(
          maxLength: 20,
          capitalization: TextCapitalization.sentences,
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
