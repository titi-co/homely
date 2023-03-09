part of 'property_bloc_bloc.dart';

abstract class PropertyBlocState extends Equatable {
  const PropertyBlocState();

  @override
  List<Object> get props => [];
}

class PropertyBlocLoadingState extends PropertyBlocState {}

class PropertyBlocLoadedState extends PropertyBlocState {}

class PropertyBlocErroState extends PropertyBlocState {}
