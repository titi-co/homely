import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homely/src/models/property_model.dart';
import 'package:homely/src/services/api_service_fake.dart';

part 'property_bloc_event.dart';
part 'property_bloc_state.dart';

class PropertyBloc extends Bloc<PropertyBlocEvent, PropertyBlocState> {
  PropertyBloc() : super(PropertyBlocLoadingState()) {
    on<PropertyBlocEvent>((event, emit) async {
      if (event is PropertyFetch) {
        // emit(PropertyBlocLoadingState());

        // Property property = await APIServiceFake().getProperty(event.id);

        // emit(PropertyBlocLoadedState(property: property));
      }
    });
  }
}
