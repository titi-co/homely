part of 'add_bloc.dart';

abstract class AddEvent extends Equatable {
  const AddEvent();

  @override
  List<Object> get props => [];
}

class ClearState extends AddEvent {}

class AddButtonPressed extends AddEvent {
  final String name;
  final String description;
  final String street;
  final String district;
  final String city;
  final String state;
  final String image;

  const AddButtonPressed({
    required this.name,
    required this.description,
    required this.street,
    required this.district,
    required this.city,
    required this.state,
    required this.image,
  });

  @override
  List<Object> get props =>
      [name, description, street, district, city, state, image];
}
