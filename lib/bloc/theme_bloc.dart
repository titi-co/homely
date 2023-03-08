import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homely/theme/theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState(themeData: theme[Themes.darkTheme] as ThemeData)) {
    on<ThemeEvent>((event, emit) async {
      if (event is ThemeChanged) {
        emit(ThemeState(themeData: theme[event.theme] as ThemeData));
      }
    });
  }
}
