import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homely/src/bloc/propertiesBloc/properties_bloc_bloc.dart';
import 'package:homely/src/models/property_model.dart';
import 'package:homely/src/screens/details.dart';
import 'package:homely/src/theme/constants.dart';
import 'package:homely/src/utils/image.dart';
import 'package:homely/src/widgets/missing_image.dart';

class PropertyItem extends StatelessWidget {
  const PropertyItem({
    super.key,
    required this.property,
    this.onPressed,
  });

  final Property property;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 350,
            width: double.infinity,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
            ),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  child: ImageUtils().imageFromBase64String(
                          base64String: property.image, fit: BoxFit.cover) ??
                      const MissingImage(),
                ),
                Positioned(
                  bottom: ThemeVariables.sm,
                  right: ThemeVariables.sm,
                  child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<PropertiesBloc>(context)
                          .add(PropertiesDelete(property.id));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(
                        ThemeVariables.xs,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).colorScheme.surfaceVariant,
                      ),
                      child: const Icon(
                        Icons.delete_outline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: ThemeVariables.sm,
          ),
          Text(
            property.name,
            style: ThemeVariables.bodyHeader,
          ),
          const SizedBox(
            height: ThemeVariables.xs,
          ),
          Text(
            "${property.street} - ${property.district}",
            style: ThemeVariables.bodyRegular,
          ),
          const SizedBox(
            height: ThemeVariables.xs,
          ),
          const Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
