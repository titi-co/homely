part of 'properties_bloc_bloc.dart';

abstract class PropertiesBlocEvent extends Equatable {
  const PropertiesBlocEvent();

  @override
  List<Object> get props => [];
}

class PropertiesFetch extends PropertiesBlocEvent {}

class PropertiesDelete extends PropertiesBlocEvent {
  final String id;

  const PropertiesDelete(this.id);
}

class PropertiesUpdated extends PropertiesBlocEvent {
  final List<Property> properties;

  const PropertiesUpdated(this.properties);
}

class PropertyAdd extends PropertiesBlocEvent {
  final Property property;
  final File image;

  const PropertyAdd(this.property, this.image);
}

class PropertyUpdate extends PropertiesBlocEvent {
  final Property property;
  final File image;

  const PropertyUpdate(this.property, this.image);
}
