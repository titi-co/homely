import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homely/src/mock/property.dart';
import 'package:homely/src/models/property_model.dart';
import 'package:homely/src/utils/firebase.dart';

part 'add_event.dart';
part 'add_state.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  AddBloc() : super(AddInitial()) {
    on<AddEvent>((event, emit) async {
      if (event is AddButtonPressed) {
        emit(AddLoading());

        try {
          /*
          final auth = FirebaseAuth.instance;

          Property propertyObject = Property(
              name: event.name,
              description: event.description,
              street: event.street,
              district: event.district,
              city: event.city,
              state: event.state,
              image: event.image,
              uid: auth.currentUser!.uid);

          final propertiesCollection =
              FirebaseFirestore.instance.collection('properties');
          await propertiesCollection.add(propertyObject.toJson());

          emit(AddSuccess());
          */
        } on FirebaseAuthException catch (error) {
          emit(AddFailure(
              error: FireBaseUtils().getMessageFromErrorCode(error)));
        } catch (error) {
          emit(AddFailure(error: error.toString()));
        }
      }

      if (event is ClearState) {
        emit(AddInitial());
      }
    });
  }
}
