import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homely/src/bloc/theme_bloc.dart';
import 'package:homely/src/theme/constants.dart';
import 'package:homely/src/theme/theme.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static const routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: ThemeVariables.md,
        elevation: 0,
        title: Text(
          "home.ly",
          style: ThemeVariables.logo,
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
        onPressed: () {},
        label: const Text("Adicionar"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(ThemeVariables.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Minhas propriedades",
                    style: ThemeVariables.sectionHeader,
                  ),
                  const SizedBox(
                    height: ThemeVariables.md,
                  ),
                  const PropertyItem(),
                  const SizedBox(
                    height: ThemeVariables.md,
                  ),
                  const PropertyItem(),
                  const SizedBox(
                    height: ThemeVariables.md,
                  ),
                  const PropertyItem()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PropertyItem extends StatelessWidget {
  const PropertyItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 350,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.red,
            image: const DecorationImage(
                image: NetworkImage(
                  "https://thumbor.forbes.com/thumbor/fit-in/900x510/https://www.forbes.com/home-improvement/wp-content/uploads/2022/07/download-23.jpg",
                ),
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(Colors.black26, BlendMode.darken)),
          ),
        ),
        const SizedBox(
          height: ThemeVariables.sm,
        ),
        Text(
          "Manitoba, Canadá",
          style: ThemeVariables.bodyHeader,
        ),
        const SizedBox(
          height: ThemeVariables.xs,
        ),
        Text(
          "4 quartos / 3 banheiros",
          style: ThemeVariables.bodyRegular,
        ),
      ],
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
                : ThemeVariables.lightModeColor)),
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
