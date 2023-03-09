import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homely/src/bloc/propertyBloc/property_bloc_bloc.dart';
import 'package:homely/src/models/Property.dart';
import 'package:homely/src/theme/constants.dart';
import 'package:homely/src/utils/image.dart';

class Details extends StatelessWidget {
  const Details({super.key});

  static const routeName = "/details";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PropertyBloc, PropertyBlocState>(
      builder: (context, state) {
        if (state is PropertyBlocErroState) {
          return Container();
        }
        if (state is PropertyBlocLoadingState) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                value: null,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          );
        }
        if (state is PropertyBlocLoadedState) {
          Property property = state.property;
          return Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                      expandedHeight: MediaQuery.of(context).size.height / 3,
                      floating: false,
                      pinned: false,
                      title: null,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            Container(
                              child: ImageUtils().imageFromBase64String(
                                base64String: state.property.image,
                              ),
                            )
                          ],
                        ),
                      ))
                ];
              },
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: ThemeVariables.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          property.name ?? "Title...",
                          style: ThemeVariables.sectionHeader,
                        ),
                        Text(
                          property.description ?? "Description...",
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
                          property.street ?? "Street...",
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
                          property.district ?? "District...",
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
                          property.city ?? "City...",
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
                          property.state ?? "State...",
                          style: ThemeVariables.bodyRegular,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        return Container();
      },
    );
  }
}
