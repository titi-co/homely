import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homely/bloc/theme_bloc.dart';
import 'package:homely/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(builder: _buildTheme),
    );
  }

  MaterialApp _buildTheme(BuildContext context, ThemeState state) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: state.themeData,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("home.ly"),
        ),
        body: Center(
            child: TextButton(
          child: const Text("Toggle"),
          onPressed: () {
            BlocProvider.of<ThemeBloc>(context)
                .add(const ThemeChanged(theme: Themes.lightTheme));
          },
        )),
      ),
    );
  }
}
