import 'package:cloud_firestore/cloud_firestore.dart';

class Property {
  Property({
    this.id,
    this.name,
    this.description,
    this.street,
    this.district,
    this.city,
    this.state,
    this.image,
    this.uid,
  });

  String? id;
  String? name;
  String? description;
  String? street;
  String? district;
  String? city;
  String? state;
  String? image;
  String? uid;

  Map<String, dynamic> toJson() {
    return {
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

  Property fromJson(QueryDocumentSnapshot<Object?> json) {
    return Property(
      name: json['name'],
      description: json['description'],
      street: json['street'],
      district: json['district'],
      city: json['city'],
      state: json['state'],
      image: json['image'],
      uid: json['uid'],
    );
  }
}
