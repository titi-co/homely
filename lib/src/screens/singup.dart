import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homely/src/bloc/signupBloc/signup_bloc.dart';
import 'package:homely/src/containers/signup_form_container.dart';
import 'package:homely/src/theme/constants.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  static const routeName = "/signup";

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: ThemeVariables.md),
            child: SignupForm(
              signUpBloc: BlocProvider.of<SignUpBloc>(context),
            ),
          ),
        ),
      ),
    );
  }
}
