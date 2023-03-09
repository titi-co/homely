part of 'property_bloc_bloc.dart';

abstract class PropertyBlocState extends Equatable {
  const PropertyBlocState();

  @override
  List<dynamic> get props => [];
}

class PropertyBlocLoadingState extends PropertyBlocState {}

class PropertyBlocLoadedState extends PropertyBlocState {
  final Property property;

  const PropertyBlocLoadedState({required this.property});

  @override
  List<dynamic> get props => [property];
}

class PropertyBlocErroState extends PropertyBlocState {}
