import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'property_bloc_event.dart';
part 'property_bloc_state.dart';

class PropertyBlocBloc extends Bloc<PropertyBlocEvent, PropertyBlocState> {
  PropertyBlocBloc() : super(PropertyBlocLoadingState()) {
    on<PropertyBlocEvent>((event, emit) {});
  }
}
