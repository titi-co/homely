import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homely/src/models/property.dart';
import 'package:homely/src/utils/firebase.dart';

part 'properties_bloc_event.dart';
part 'properties_bloc_state.dart';

class PropertiesBloc extends Bloc<PropertiesBlocEvent, PropertiesBlocState> {
  PropertiesBloc() : super(PropertiesBlocLoadingState()) {
    on<PropertiesBlocEvent>((event, emit) async {
      if (event is PropertiesFetch) {
        emit(PropertiesBlocLoadingState());

        try {
          final auth = FirebaseAuth.instance;

          final propertiesCollection =
              FirebaseFirestore.instance.collection('properties');

          List<Property> properties = List.empty(growable: true);

          await propertiesCollection
              .where("uid", isEqualTo: auth.currentUser!.uid)
              .get()
              .then((QuerySnapshot querySnapshot) {
            for (var doc in querySnapshot.docs) {
              properties.add(Property().fromJson(doc));
            }
          });

          emit(PropertiesBlocLoadedState(properties: properties));
        } on FirebaseAuthException catch (error) {
          emit(PropertiesFailure(
              error: FireBaseUtils().getMessageFromErrorCode(error)));
        } catch (error) {
          emit(PropertiesFailure(error: error.toString()));
        }
      }
    });
  }
}
