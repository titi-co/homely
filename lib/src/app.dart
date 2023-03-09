import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homely/src/screens/home.dart';
import 'package:homely/src/bloc/theme_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
        if (state is ThemeStateLoaded) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'home.ly',
            theme: state.themeData,
            initialRoute: Home.routeName,
            routes: {Home.routeName: (context) => const Home()},
          );
        }
        return Container();
      }),
    );
  }
}
