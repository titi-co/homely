part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<dynamic> get props => [];
}

class ThemeChanged extends ThemeEvent {
  final Themes theme;

  const ThemeChanged({required this.theme});

  @override
  List<dynamic> get props => [theme];
}
