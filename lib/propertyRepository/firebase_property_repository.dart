import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:homely/propertyRepository/property_repository.dart';
import 'package:homely/src/entities/property_entity.dart';
import 'package:homely/src/models/property_model.dart';

class FirebasePropertyRepository implements PropertyRepository {
  late FirebaseAuth auth;
  FirebasePropertyRepository() {
    auth = FirebaseAuth.instance;
  }

  final propertiesCollection =
      FirebaseFirestore.instance.collection('properties');

  @override
  Future<void> addProperty(Property property) {
    return propertiesCollection.add(
        property.copyWith(uid: auth.currentUser!.uid).toEntity().toDocument());
  }

  @override
  Future<void> deleteProperty(String id) async {
    return propertiesCollection.doc(id).delete();
  }

  @override
  Stream<List<Property>> properties() {
    return propertiesCollection
        .where("uid", isEqualTo: auth.currentUser!.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) =>
              Property.fromEntity(PropertyEntity.fromSnapshot(doc.id, doc)))
          .toList();
    });
  }

  @override
  Future<void> updateProperty(Property update) {
    return propertiesCollection
        .doc(update.id)
        .update(update.toEntity().toDocument());
  }
}
