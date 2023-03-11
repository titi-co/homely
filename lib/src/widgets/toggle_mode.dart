import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homely/src/bloc/themeBloc/theme_bloc.dart';
import 'package:homely/src/theme/constants.dart';
import 'package:homely/src/theme/theme.dart';

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
        backgroundColor: MaterialStateProperty.all<Color>(
          isLight
              ? ThemeVariables.darkModeColor
              : ThemeVariables.lightModeColor,
        ),
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
      ),
    );
  }
}
