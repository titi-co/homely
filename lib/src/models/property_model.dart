import "package:homely/src/entities/property_entity.dart";

class Property {
  final String id;
  final String name;
  final String description;
  final String street;
  final String district;
  final String city;
  final String state;
  final String image;
  final String uid;

  Property(
    this.id,
    this.name,
    this.description,
    this.street,
    this.district,
    this.city,
    this.state,
    this.image,
    this.uid,
  );

  Property copyWith(
      {String? id,
      String? name,
      String? description,
      String? street,
      String? district,
      String? city,
      String? state,
      String? image,
      String? uid}) {
    return Property(
        id ?? this.id,
        name ?? this.name,
        description ?? this.description,
        street ?? this.street,
        district ?? this.district,
        city ?? this.city,
        state ?? this.state,
        image ?? this.image,
        uid ?? this.uid);
  }

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ description.hashCode ^ uid.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Property &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          street == other.street &&
          district == other.description &&
          city == other.description &&
          state == other.state &&
          image == other.image &&
          uid == other.uid;

  @override
  String toString() {
    return 'Property { id: $id, name: $name}';
  }

  PropertyEntity toEntity() {
    return PropertyEntity(
        id, name, description, street, district, city, state, image, uid);
  }

  static Property fromEntity(PropertyEntity entity) {
    return Property(
      entity.id,
      entity.name,
      entity.description,
      entity.street,
      entity.district,
      entity.city,
      entity.state,
      entity.image,
      entity.uid,
    );
  }
}
