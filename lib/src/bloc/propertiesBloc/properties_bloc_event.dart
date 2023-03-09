part of 'properties_bloc_bloc.dart';

abstract class PropertiesBlocEvent extends Equatable {
  const PropertiesBlocEvent();

  @override
  List<Object> get props => [];
}

class PropertiesFetch extends PropertiesBlocEvent {}
