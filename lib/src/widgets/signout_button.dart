import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homely/src/bloc/authBloc/auth_bloc.dart';
import 'package:homely/src/bloc/propertiesBloc/properties_bloc_bloc.dart';
import 'package:homely/src/theme/constants.dart';

class SignOut extends StatefulWidget {
  const SignOut({
    super.key,
    this.onPressed,
  });

  final Function? onPressed;

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
          BlocProvider.of<PropertiesBloc>(context).unsubscribe();
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
