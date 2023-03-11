import 'package:flutter/material.dart';
import 'package:homely/src/bloc/propertiesBloc/properties_bloc_bloc.dart';
import 'package:homely/src/models/property_model.dart';
import 'package:homely/src/screens/details.dart';
import 'package:homely/src/theme/constants.dart';
import 'package:homely/src/widgets/property_item.dart';

class PropertyContainer extends StatelessWidget {
  const PropertyContainer({
    super.key,
    required this.state,
  });

  final PropertiesBlocLoadedState state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      clipBehavior: Clip.none,
      itemCount: state.properties.length,
      itemBuilder: (BuildContext context, int index) {
        Property property = state.properties[index];

        if (index == 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My places",
                style: ThemeVariables.sectionHeader,
              ),
              const SizedBox(
                height: ThemeVariables.md,
              ),
              PropertyItem(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Details(
                        property: property,
                      ),
                    ),
                  );
                },
                property: property,
              )
            ],
          );
        }
        return PropertyItem(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Details(
                  property: property,
                ),
              ),
            );
          },
          property: property,
        );
      },
    );
  }
}
