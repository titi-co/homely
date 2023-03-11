import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homely/propertyRepository/property_repository.dart';
import 'package:homely/src/models/property_model.dart';

part 'properties_bloc_event.dart';
part 'properties_bloc_state.dart';

class PropertiesBloc extends Bloc<PropertiesBlocEvent, PropertiesBlocState> {
  late final PropertyRepository propertyRepository;
  StreamSubscription? _propertySubscription;

  PropertiesBloc({required PropertyRepository propertyRepository})
      : super(PropertiesBlocLoadingState()) {
    on<PropertiesBlocEvent>((event, emit) async {
      if (event is PropertiesFetch) {
        emit(PropertiesBlocLoadingState());
        _propertySubscription?.cancel();
        _propertySubscription = propertyRepository.properties().listen(
          (properties) {
            add(
              PropertiesUpdated(properties),
            );
          },
        );
      } else if (event is PropertiesUpdated) {
        emit((PropertiesBlocLoadedState(properties: event.properties)));
      } else if (event is PropertiesDelete) {
        propertyRepository.deleteProperty(event.id);
      } else if (event is PropertyAdd) {
        propertyRepository.addProperty(event.property);
      } else if (event is PropertyUpdate) {
        propertyRepository.updateProperty(event.property);
      }
    });
  }

  @override
  Future<void> close() async {
    _propertySubscription?.cancel();
    super.close();
  }
}
