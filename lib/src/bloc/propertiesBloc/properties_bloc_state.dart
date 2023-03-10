part of 'properties_bloc_bloc.dart';

abstract class PropertiesBlocState extends Equatable {
  const PropertiesBlocState();

  @override
  List<dynamic> get props => [];
}

class PropertiesBlocLoadingState extends PropertiesBlocState {}

class PropertiesBlocLoadedState extends PropertiesBlocState {
  final List<Property> properties;

  const PropertiesBlocLoadedState({required this.properties});

  @override
  List<dynamic> get props => [properties];
}

class PropertiesBlocEmptyState extends PropertiesBlocState {}

class PropertiesFailure extends PropertiesBlocState {
  final String error;

  const PropertiesFailure({required this.error});

  @override
  List<Object> get props => [error];
}
