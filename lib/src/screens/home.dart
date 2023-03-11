import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:homely/src/bloc/authBloc/auth_bloc.dart';
import 'package:homely/src/bloc/propertiesBloc/properties_bloc_bloc.dart';
import 'package:homely/src/bloc/themeBloc/theme_bloc.dart';
import 'package:homely/src/containers/properties_loading_container.dart';
import 'package:homely/src/models/property_model.dart';
import 'package:homely/src/screens/details.dart';
import 'package:homely/src/theme/constants.dart';
import 'package:homely/src/theme/theme.dart';
import 'package:homely/src/utils/image.dart';
import 'package:homely/src/widgets/missing_image.dart';
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
            Text(
              "home.ly",
              style: ThemeVariables.logo,
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: ThemeVariables.md),
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
                                ? Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "My places",
                                          style: ThemeVariables.sectionHeader,
                                        ),
                                        const SizedBox(
                                          height: ThemeVariables.md,
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "You don't have any places",
                                                style: ThemeVariables
                                                    .sectionHeader,
                                              ),
                                              const SizedBox(
                                                height: ThemeVariables.md,
                                              ),
                                              SizedBox(
                                                width: double.infinity,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondary),
                                                  ),
                                                  onPressed: () {
                                                    BlocProvider.of<
                                                                PropertiesBloc>(
                                                            context)
                                                        .add(PropertiesFetch());
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            ThemeVariables.md),
                                                    child: Text(
                                                      "Try again",
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                                    .colorScheme
                                                                    .brightness ==
                                                                Brightness.dark
                                                            ? Colors.black
                                                            : Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
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

class a extends StatelessWidget {
  const a({
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
