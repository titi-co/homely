import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homely/src/bloc/authBloc/auth_bloc.dart';
import 'package:homely/src/bloc/loginBloc/login_bloc.dart';
import 'package:homely/src/containers/login_form_container.dart';
import 'package:homely/src/theme/constants.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  static const routeName = "/login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: ThemeVariables.md),
            child: LoginForm(
              authBloc: BlocProvider.of<AuthBloc>(context),
              loginBloc: BlocProvider.of<LoginBloc>(context),
            ),
          ),
        ),
      ),
    );
  }
}
