import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:homely/src/utils/firebase.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpEvent>((event, emit) async {
      if (event is SignUpButtonPressed) {
        try {
          emit(SignUpLoading());

          final FirebaseAuth auth = FirebaseAuth.instance;
          // TODO: GET TOKEN
          UserCredential userCredential =
              await auth.createUserWithEmailAndPassword(
                  email: event.username, password: event.password);

          emit(SignUpSuccess());
        } on FirebaseAuthException catch (error) {
          emit(SignUpFailure(
              error: FireBaseUtils().getMessageFromErrorCode(error)));
        } catch (error) {
          emit(SignUpFailure(error: error.toString()));
        }
      }

      if (event is ClearError) {
        emit(SignUpInitial());
      }
    });
  }
}
