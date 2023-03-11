import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:homely/src/bloc/authBloc/auth_bloc.dart';
import 'package:homely/src/services/navigation_service.dart';
import 'package:homely/src/services/snackbar_service.dart';
import 'package:homely/src/utils/firebase.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthBloc authBloc;
  SignUpBloc({required this.authBloc}) : super(SignUpInitial()) {
    on<SignUpEvent>((event, emit) async {
      if (event is SignUpButtonPressed) {
        try {
          emit(SignUpLoading());

          final FirebaseAuth auth = FirebaseAuth.instance;

          UserCredential userCredential =
              await auth.createUserWithEmailAndPassword(
                  email: event.username, password: event.password);

          emit(SignUpSuccess());
          SnackBarService.instance
              .showSnackBar("User created successfully!", Colors.green);
          authBloc.add(LoggedIn());
          NavigationService.instance.goback();
        } on FirebaseAuthException catch (error) {
          SnackBarService.instance.showSnackBar(
              FireBaseUtils().getMessageFromErrorCode(error), Colors.red);

          emit(SignUpInitial());
        } catch (error) {
          SnackBarService.instance.showSnackBar(
              FireBaseUtils().getMessageFromErrorCode(error), Colors.red);

          emit(SignUpInitial());
        }
      }

      if (event is ClearError) {
        emit(SignUpInitial());
      }
    });
  }
}
