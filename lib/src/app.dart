import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homely/src/bloc/propertiesBloc/properties_bloc_bloc.dart';
import 'package:homely/src/bloc/themeBloc/theme_bloc.dart';
import 'package:homely/src/screens/add.dart';
import 'package:homely/src/screens/details.dart';
import 'package:homely/src/screens/home.dart';

class App extends StatelessWidget {
  const App({super.key});

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
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
        if (state is ThemeStateLoaded) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'home.ly',
            theme: state.themeData,
            initialRoute: Home.routeName,
            routes: {
              Home.routeName: (context) => const Home(),
              Details.routeName: (context) => const Details(),
              AddPlace.routeName: (context) => const AddPlace(),
            },
          );
        }
        return Container();
      }),
    );
  }
}
