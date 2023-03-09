import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:homely/src/bloc/propertiesBloc/properties_bloc_bloc.dart';
import 'package:homely/src/bloc/propertyBloc/property_bloc_bloc.dart';
import 'package:homely/src/bloc/themeBloc/theme_bloc.dart';
import 'package:homely/src/models/Property.dart';
import 'package:homely/src/theme/constants.dart';
import 'package:homely/src/theme/theme.dart';
import 'package:homely/src/utils/image.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  static const routeName = "/home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Future<void> _pullRefresh() async {
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
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ThemeVariables.md),
            child: ToggleMode(),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size(double.infinity, ThemeVariables.md),
          child: Divider(thickness: 1),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, "/add");
        },
        label: const Text("Adicionar"),
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          if (state is PropertiesBlocLoadedState) {
                            return SizedBox(
                              height: constraint.maxHeight,
                              child: RefreshIndicator(
                                color: Theme.of(context).colorScheme.secondary,
                                onRefresh: _pullRefresh,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: state.properties.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Property property = state.properties[index];

                                    if (index == 0) {
                                      return Column(
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
                                          PropertyItem(
                                            id: property.id,
                                            name: property.name,
                                            street: property.street,
                                            district: property.district,
                                            image: property.image,
                                          )
                                        ],
                                      );
                                    }
                                    return PropertyItem(
                                      id: property.id,
                                      name: property.name,
                                      street: property.street,
                                      district: property.district,
                                      image: property.image,
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

class PropertyItem extends StatelessWidget {
  const PropertyItem({
    super.key,
    required this.id,
    required this.name,
    required this.street,
    required this.district,
    required this.image,
  });

  final String? id;
  final String? name;
  final String? street;
  final String? district;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<PropertyBloc>(context).add(PropertyFetch(id: id!));
        Navigator.of(context).pushNamed("/details");
      },
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
            child: ImageUtils().imageFromBase64String(base64String: image),
          ),
          const SizedBox(
            height: ThemeVariables.sm,
          ),
          Text(
            name!,
            style: ThemeVariables.bodyHeader,
          ),
          const SizedBox(
            height: ThemeVariables.xs,
          ),
          Text(
            "$street - $district",
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

class ToggleMode extends StatefulWidget {
  const ToggleMode({
    super.key,
  });

  @override
  State<ToggleMode> createState() => _ToggleModeState();
}

class _ToggleModeState extends State<ToggleMode> {
  late bool isLight;
  @override
  void initState() {
    isLight = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(0),
          backgroundColor: MaterialStateProperty.all<Color>(isLight
              ? ThemeVariables.darkModeColor
              : ThemeVariables.lightModeColor),
        ),
        onPressed: () {
          BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(
              theme: isLight ? Themes.darkTheme : Themes.lightTheme));

          setState(() {
            isLight = !isLight;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(ThemeVariables.xs),
          child: Icon(
            isLight ? Icons.dark_mode : Icons.wb_sunny_outlined,
            color: isLight ? Colors.white : Colors.black,
          ),
        ));
  }
}
