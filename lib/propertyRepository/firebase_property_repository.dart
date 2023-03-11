import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:homely/propertyRepository/property_repository.dart';
import 'package:homely/src/entities/property_entity.dart';
import 'package:homely/src/models/property_model.dart';
import 'package:homely/src/services/navigation_service.dart';
import 'package:homely/src/services/snackbar_service.dart';

class FirebasePropertyRepository implements PropertyRepository {
  late FirebaseAuth auth;
  FirebasePropertyRepository() {
    auth = FirebaseAuth.instance;
  }

  final propertiesCollection =
      FirebaseFirestore.instance.collection('properties');

  final firebaseStorage = FirebaseStorage.instance;

  @override
  Future<void> addProperty(Property property, File image) async {
    try {
      var snapshot = await firebaseStorage
          .ref()
          .child(
              'images/${auth.currentUser!.uid} - ${DateTime.now().toString()}')
          .putFile(image);

      var url = await snapshot.ref.getDownloadURL();

      await propertiesCollection
          .add(property
              .copyWith(
                uid: auth.currentUser!.uid,
                image: url,
              )
              .toEntity()
              .toDocument())
          .then((value) {
        NavigationService.instance.goback();
        SnackBarService.instance
            .showSnackBar("Place added Successffully!", Colors.green);
        //Get.snackbar("Place added successfully", "");
        //Get.back();
      });
    } catch (error) {
      SnackBarService.instance.showSnackBar(
        "Error adding place! - $error",
        Colors.red,
      );
    }
  }

  @override
  Future<void> deleteProperty(String id) async {
    try {
      await propertiesCollection.doc(id).delete().then((value) {
        SnackBarService.instance
            .showSnackBar("Place deleted Successffully!", Colors.green);
        //Get.snackbar("Place added successfully", "");
        //Get.back();
      });
    } catch (error) {
      SnackBarService.instance.showSnackBar(
        "Error deleting place!",
        Colors.red,
      );
    }
  }

  @override
  Stream<List<Property>> properties() {
    try {
      return propertiesCollection
          .where("uid", isEqualTo: auth.currentUser!.uid)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) =>
                Property.fromEntity(PropertyEntity.fromSnapshot(doc.id, doc)))
            .toList();
      });
    } catch (error) {
      SnackBarService.instance.showSnackBar(
        "Error fetching places!",
        Colors.red,
      );
      return const Stream<List<Property>>.empty();
    }
  }

  @override
  Future<void> updateProperty(Property update, File? image) async {
    try {
      var url = "";
      if (image != null) {
        var snapshot = await firebaseStorage
            .ref()
            .child(
                'images/${auth.currentUser!.uid} - ${DateTime.now().toString()}')
            .putFile(image);

        url = await snapshot.ref.getDownloadURL();
      }

      await propertiesCollection
          .doc(update.id)
          .update(update
              .copyWith(
                  uid: auth.currentUser!.uid,
                  image: url == "" ? update.image : url)
              .toEntity()
              .toDocument())
          .then((value) {
        NavigationService.instance.goback();
        SnackBarService.instance
            .showSnackBar("Place updated Successffully!", Colors.green);
        //Get.snackbar("Place added successfully", "");
        //Get.back();
      });
    } catch (error) {
      SnackBarService.instance.showSnackBar(
        "Error updating place!",
        Colors.red,
      );
    }
  }
}
