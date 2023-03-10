import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homely/src/utils/firebase.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AppStarted) {
        emit(AuthLoading());
        try {
          final FirebaseAuth auth = FirebaseAuth.instance;

          if (auth.currentUser == null) {
            emit(AuthUnauthorized());
          } else {
            emit(AuthSuccess());
          }
        } on FirebaseAuthException catch (error) {
          emit(AuthFailure(
              error: FireBaseUtils().getMessageFromErrorCode(error)));
        } catch (error) {
          emit(AuthFailure(error: error.toString()));
        }
      }

      if (event is LoggedIn) {
        emit(AuthLoading());

        emit(AuthSuccess());
      }

      if (event is LoggedOut) {
        emit(AuthLoading());
        try {
          final FirebaseAuth auth = FirebaseAuth.instance;

          auth.signOut();

          emit(AuthUnauthorized());
        } on FirebaseAuthException catch (error) {
          emit(AuthFailure(
              error: FireBaseUtils().getMessageFromErrorCode(error)));
        } catch (error) {
          emit(AuthFailure(error: error.toString()));
        }
      }
    });
  }
}
