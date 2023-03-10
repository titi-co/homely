import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:homely/src/bloc/authBloc/auth_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthBloc authBloc;
  LoginBloc({
    required this.authBloc,
  }) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginButtonPressed) {
        emit(LoginLoading());

        try {
          // TODO: GET TOKEN
          authBloc.add(const LoggedIn(token: "TOKEN"));
          emit(LoginInitial());
        } catch (error) {
          emit(LoginFailure(error: error.toString()));
        }
      }
    });
  }
}
