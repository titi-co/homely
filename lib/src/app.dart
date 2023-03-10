import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homely/src/bloc/authBloc/auth_bloc.dart';
import 'package:homely/src/bloc/loginBloc/login_bloc.dart';
import 'package:homely/src/bloc/propertiesBloc/properties_bloc_bloc.dart';
import 'package:homely/src/bloc/propertyBloc/property_bloc_bloc.dart';
import 'package:homely/src/bloc/themeBloc/theme_bloc.dart';
import 'package:homely/src/screens/add.dart';
import 'package:homely/src/screens/details.dart';
import 'package:homely/src/screens/home.dart';
import 'package:homely/src/screens/login.dart';
import 'package:homely/src/theme/constants.dart';
import 'package:homely/src/widgets/loading.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider<PropertiesBloc>(
          create: (context) => PropertiesBloc()..add(PropertiesFetch()),
        ),
        BlocProvider<PropertyBloc>(
          create: (context) => PropertyBloc(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<LoginBloc>(
          create: (context) =>
              LoginBloc(authBloc: BlocProvider.of<AuthBloc>(context)),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          if (state is ThemeStateLoaded) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'home.ly',
              theme: state.themeData,
              routes: {
                Login.routeName: (context) => const Login(),
                Home.routeName: (context) => const Home(),
                Details.routeName: (context) => const Details(),
                AddPlace.routeName: (context) => const AddPlace(),
              },
              home: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthInitial) {
                    BlocProvider.of<AuthBloc>(context).add(AppStarted());
                    return const Splash();
                  }

                  if (state is AuthUnauthorized) {
                    return const Login();
                  }

                  if (state is AuthSuccess) {
                    return const Home();
                  }

                  if (state is AuthLoading) {
                    return const Loading();
                  }

                  return Container();
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class Splash extends StatelessWidget {
  const Splash({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ThemeVariables.redColor,
        child: Center(
            child: Text(
          "home.ly",
          style: ThemeVariables.sheetTitle.copyWith(
            color: Colors.white,
          ),
        )),
      ),
    );
  }
}
