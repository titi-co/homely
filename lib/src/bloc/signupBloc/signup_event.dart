part of 'signup_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class ClearError extends SignUpEvent {}

class SignUpButtonPressed extends SignUpEvent {
  final String username;
  final String password;

  const SignUpButtonPressed({
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username, password];
}
