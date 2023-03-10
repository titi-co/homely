import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:homely/src/bloc/authBloc/auth_bloc.dart';
import 'package:homely/src/bloc/loginBloc/login_bloc.dart';
import 'package:homely/src/theme/constants.dart';
import 'package:homely/src/widgets/input.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  static const routeName = "/signup";

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late AuthBloc _authBloc;
  late LoginBloc _loginBloc;

  @override
  void initState() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _loginBloc = LoginBloc(authBloc: _authBloc);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: ThemeVariables.md),
            child: LoginForm(
              authBloc: _authBloc,
              loginBloc: _loginBloc,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.authBloc,
    required this.loginBloc,
  });

  final AuthBloc authBloc;
  final LoginBloc loginBloc;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  _onLoginButtonPressed() {
    widget.loginBloc.add(LoginButtonPressed(
      username: _emailController.text,
      password: _passwordController.text,
    ));
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginFailure) {
            _onWidgetDidBuild(
              () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                ));
              },
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "lib/src/assets/icons/icon-logo.svg",
                    height: ThemeVariables.sheet,
                    color: Theme.of(context).colorScheme.brightness ==
                            Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                  const SizedBox(
                    width: ThemeVariables.xs,
                  ),
                  Text(
                    "Create Account",
                    style: ThemeVariables.sheetTitle,
                  ),
                ],
              ),
              const SizedBox(
                height: ThemeVariables.lg,
              ),
              Form(
                child: Column(
                  children: [
                    Input(
                      label: "Email",
                      controller: _emailController,
                    ),
                    const SizedBox(
                      height: ThemeVariables.md,
                    ),
                    Input(
                      label: "Password",
                      controller: _passwordController,
                    ),
                    const SizedBox(
                      height: ThemeVariables.md,
                    ),
                    state is LoginLoading
                        ? const CircularProgressIndicator(
                            value: null,
                          )
                        : Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                  ),
                                  onPressed: state is! LoginLoading
                                      ? _onLoginButtonPressed
                                      : null,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(ThemeVariables.md),
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                                      .colorScheme
                                                      .brightness ==
                                                  Brightness.dark
                                              ? Colors.black
                                              : Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
