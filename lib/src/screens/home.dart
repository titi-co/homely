import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:homely/src/bloc/authBloc/auth_bloc.dart';
import 'package:homely/src/bloc/propertiesBloc/properties_bloc_bloc.dart';
import 'package:homely/src/bloc/propertyBloc/property_bloc_bloc.dart';
import 'package:homely/src/bloc/themeBloc/theme_bloc.dart';
import 'package:homely/src/models/property.dart';
import 'package:homely/src/screens/details.dart';
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
                                            property: property,
                                          )
                                        ],
                                      );
                                    }
                                    return PropertyItem(
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

class PropertyItem extends StatelessWidget {
  const PropertyItem({
    super.key,
    required this.property,
  });

  final Property property;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Details(
                property: property,
              ),
            ));
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
            child: property.image == null || property.image == ""
                ? const MissingImage()
                : ImageUtils()
                    .imageFromBase64String(base64String: property.image),
          ),
          const SizedBox(
            height: ThemeVariables.sm,
          ),
          Text(
            property.name!,
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

class MissingImage extends StatelessWidget {
  const MissingImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeVariables.redColor,
      alignment: Alignment.center,
      child: Text(
        "Image missing...",
        style: ThemeVariables.sheetTitle.copyWith(color: Colors.white),
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

class SignOut extends StatefulWidget {
  const SignOut({
    super.key,
  });

  @override
  State<SignOut> createState() => _SignOutState();
}

class _SignOutState extends State<SignOut> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(0),
          backgroundColor: MaterialStateProperty.all<Color>(
              Theme.of(context).colorScheme.secondary),
        ),
        onPressed: () {
          BlocProvider.of<AuthBloc>(context).add(LoggedOut());
        },
        child: Padding(
          padding: const EdgeInsets.all(ThemeVariables.xs),
          child: Icon(
            Icons.logout,
            color: Theme.of(context).colorScheme.brightness == Brightness.light
                ? Colors.white
                : Colors.black,
          ),
        ));
  }
}
