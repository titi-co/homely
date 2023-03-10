import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:homely/src/bloc/authBloc/auth_bloc.dart';
import 'package:homely/src/utils/firebase.dart';

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
          final FirebaseAuth auth = FirebaseAuth.instance;

          // TODO: GET TOKEN
          UserCredential userCredential = await auth.signInWithEmailAndPassword(
              email: event.username, password: event.password);

          authBloc.add(LoggedIn());
          emit(LoginInitial());
        } on FirebaseAuthException catch (error) {
          emit(LoginFailure(
              error: FireBaseUtils().getMessageFromErrorCode(error)));
        } catch (error) {
          print(error);
          //emit(SignUpFailure(error: error.toString()));
        }
      }

      if (event is ClearError) {
        emit(LoginInitial());
      }
    });
  }
}
