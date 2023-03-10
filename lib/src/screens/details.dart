import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homely/src/bloc/propertyBloc/property_bloc_bloc.dart';
import 'package:homely/src/models/property.dart';
import 'package:homely/src/theme/constants.dart';
import 'package:homely/src/utils/image.dart';
import 'package:sliver_header_delegate/sliver_header_delegate.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  static const routeName = "/details";

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    super.initState();
  }

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
              physics: const ClampingScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                      context,
                    ),
                    sliver: SliverPersistentHeader(
                      pinned: true,
                      delegate: FlexibleHeaderDelegate(
                        leading: Padding(
                          padding: const EdgeInsets.only(left: 8, top: 8),
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceVariant,
                              ),
                              alignment: Alignment.center,
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_back,
                                  size: ThemeVariables.header,
                                ),
                              ),
                            ),
                          ),
                        ),
                        collapsedElevation: 1,
                        statusBarHeight: MediaQuery.of(context).padding.top,
                        expandedHeight: MediaQuery.of(context).size.height / 3,
                        background: MutableBackground(
                          expandedWidget: ImageUtils().imageFromBase64String(
                              base64String: state.property.image),
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ThemeVariables.md,
                        vertical: MediaQuery.of(context).padding.top +
                            ThemeVariables.md),
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
