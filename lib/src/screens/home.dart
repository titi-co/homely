import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:homely/src/bloc/propertiesBloc/properties_bloc_bloc.dart';
import 'package:homely/src/containers/properties_empty_container.dart';
import 'package:homely/src/containers/properties_loading_container.dart';
import 'package:homely/src/models/property_model.dart';
import 'package:homely/src/screens/details.dart';
import 'package:homely/src/theme/constants.dart';
import 'package:homely/src/widgets/property_item.dart';
import 'package:homely/src/widgets/signout_button.dart';
import 'package:homely/src/widgets/toggle_mode.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  static const routeName = "/home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Future<void> pullRefresh() async {
      BlocProvider.of<PropertiesBloc>(context).add(PropertiesFetch());
    }

    return Scaffold(
      appBar: AppBar(
        titleSpacing: ThemeVariables.md,
        elevation: 0,
        title: Row(
          children: [
            SvgPicture.asset(
              "lib/src/assets/icons/icon-logo.svg",
              height: ThemeVariables.sheet,
              color: Theme.of(context).colorScheme.brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
            const SizedBox(
              width: ThemeVariables.xs,
            ),
            Expanded(
              child: Text(
                "home.ly",
                style: ThemeVariables.logo,

              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: ThemeVariables.xs),
            child: Row(
              children: const [
                ToggleMode(),
                SizedBox(
                  width: ThemeVariables.sm,
                ),
                SignOut(),
              ],
            ),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size(double.infinity, ThemeVariables.md),
          child: Divider(thickness: 1),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(
            context,
            "/add",
          );
        },
        label: const Text("Add place"),
      ),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: ThemeVariables.md),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<PropertiesBloc, PropertiesBlocState>(
                        builder: (context, state) {
                          if (state is PropertiesBlocLoadingState) {
                            return const PropertiesLoadingContainer();
                          }

                          if (state is PropertiesBlocLoadedState) {
                            return state.properties.isEmpty
                                ? const PropertiesEmptyContainer()
                                : SizedBox(
                                    height: constraint.maxHeight,
                                    child: RefreshIndicator(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      onRefresh: pullRefresh,
                                      child: ListView.builder(
                                        addAutomaticKeepAlives: false,
                                        addRepaintBoundaries: false,
                                        shrinkWrap: true,
                                        clipBehavior: Clip.none,
                                        itemCount: state.properties.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          Property property =
                                              state.properties[index];

                                          if (index == 0) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "My places",
                                                  style: ThemeVariables
                                                      .sectionHeader,
                                                ),
                                                const SizedBox(
                                                  height: ThemeVariables.md,
                                                ),
                                                PropertyItem(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            Details(
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
                                      ),
                                    ),
                                  );
                          }
                          return Container();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
