import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PropertyEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String street;
  final String district;
  final String city;
  final String state;
  final String image;
  final String uid;

  const PropertyEntity(this.id, this.name, this.description, this.street,
      this.district, this.city, this.state, this.image, this.uid);

  Map<String, Object> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'street': street,
      'district': district,
      'city': city,
      'state': state,
      'image': image,
      'uid': uid,
    };
  }

  @override
  String toString() {
    return 'PropertyEntity {id: $id, name: $name, description: $description, street: $street, district: $district... }';
  }

  static PropertyEntity fromJson(Map<String, Object> json) {
    return PropertyEntity(
      json['id'] as String,
      json['name'] as String,
      json['description'] as String,
      json['street'] as String,
      json['district'] as String,
      json['city'] as String,
      json['state'] as String,
      json['image'] as String,
      json['uid'] as String,
    );
  }

  static PropertyEntity fromSnapshot(String id, DocumentSnapshot snap) {
    final snapMap = snap.data() as Map;
    return PropertyEntity(
      id,
      snapMap["name"],
      snapMap["description"],
      snapMap["street"],
      snapMap["district"],
      snapMap["city"],
      snapMap["state"],
      snapMap["image"],
      snapMap["uid"],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'street': street,
      'district': district,
      'city': city,
      'state': state,
      'image': image,
      'uid': uid,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
