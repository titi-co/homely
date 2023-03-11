import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homely/propertyRepository/firebase_property_repository.dart';
import 'package:homely/src/bloc/authBloc/auth_bloc.dart';
import 'package:homely/src/bloc/loginBloc/login_bloc.dart';
import 'package:homely/src/bloc/propertiesBloc/properties_bloc_bloc.dart';
import 'package:homely/src/bloc/signupBloc/signup_bloc.dart';
import 'package:homely/src/bloc/themeBloc/theme_bloc.dart';
import 'package:homely/src/containers/splash_container.dart';
import 'package:homely/src/screens/add.dart';
import 'package:homely/src/screens/details.dart';
import 'package:homely/src/screens/edit.dart';
import 'package:homely/src/screens/home.dart';
import 'package:homely/src/screens/login.dart';
import 'package:homely/src/screens/singup.dart';
import 'package:homely/src/services/navigation_service.dart';
import 'package:homely/src/services/snackbar_service.dart';
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
          create: (context) =>
              PropertiesBloc(propertyRepository: FirebasePropertyRepository())
                ..add(PropertiesFetch()),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<LoginBloc>(
          create: (context) =>
              LoginBloc(authBloc: BlocProvider.of<AuthBloc>(context)),
        ),
        BlocProvider<SignUpBloc>(
          create: (context) =>
              SignUpBloc(authBloc: BlocProvider.of<AuthBloc>(context)),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          if (state is ThemeStateLoaded) {
            return MaterialApp(
              navigatorKey: NavigationService.instance.navigationKey,
              scaffoldMessengerKey: SnackBarService.instance.scaffoldKey,
              debugShowCheckedModeBanner: false,
              title: 'home.ly',
              theme: state.themeData,
              routes: {
                Login.routeName: (context) => const Login(),
                SignUp.routeName: (context) => const SignUp(),
                Home.routeName: (context) => const Home(),
                Details.routeName: (context) => const Details(),
                AddPlace.routeName: (context) => const AddPlace(),
                EditPlace.routeName: (context) => const EditPlace(),
              },
              home: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthInitial) {
                    BlocProvider.of<AuthBloc>(context).add(AppStarted());
                    return const SplashContainer();
                  }

                  if (state is AuthUnauthorized) {
                    return const Login();
                  }

                  if (state is AuthSuccess) {
                    // ? Fetch data on AuthSuccess
                    BlocProvider.of<PropertiesBloc>(context)
                        .add(PropertiesFetch());
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
