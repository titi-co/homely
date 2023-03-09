import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homely/src/theme/theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeStateLoaded(
            themeData: theme[Themes.lightTheme] as ThemeData)) {
    on<ThemeEvent>((event, emit) async {
      emit(ThemeStateIdle());

      if (event is ThemeChanged) {
        emit(ThemeStateLoaded(themeData: theme[event.theme] as ThemeData));
      }
    });
  }
}
