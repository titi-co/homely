part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<dynamic> get props => [];
}

class ThemeStateIdle extends ThemeState {}

class ThemeStateLoaded extends ThemeState {
  final ThemeData themeData;

  const ThemeStateLoaded({
    required this.themeData,
  });

  @override
  List<dynamic> get props => [themeData];
}
