import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AppStarted) {
        emit(AuthUnauthorized());
      }

      if (event is LoggedIn) {
        emit(AuthLoading());

        emit(AuthSuccess());
      }

      if (event is LoggedOut) {
        emit(AuthLoading());
        // TODO: TOKEN
        emit(AuthUnauthorized());
      }
    });
  }
}
