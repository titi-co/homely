import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homely/src/models/Property.dart';
import 'package:homely/src/services/api_service_fake.dart';

part 'properties_bloc_event.dart';
part 'properties_bloc_state.dart';

class PropertiesBloc extends Bloc<PropertiesBlocEvent, PropertiesBlocState> {
  PropertiesBloc() : super(PropertiesBlocLoadingState()) {
    on<PropertiesBlocEvent>((event, emit) async {
      if (event is PropertiesFetch) {
        emit(PropertiesBlocLoadingState());

        List<Property> properties = await APIServiceFake().getProperties();

        if (properties.isEmpty) emit(PropertiesBlocEmptyState());

        emit(PropertiesBlocLoadedState(properties: properties));
      }
    });
  }
}
