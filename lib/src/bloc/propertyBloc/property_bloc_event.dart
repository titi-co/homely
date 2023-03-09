part of 'property_bloc_bloc.dart';

abstract class PropertyBlocEvent extends Equatable {
  const PropertyBlocEvent();

  @override
  List<dynamic> get props => [];
}

class PropertyFetch extends PropertyBlocEvent {
  final int id;

  const PropertyFetch({required this.id});

  @override
  List<dynamic> get props => [id];
}
