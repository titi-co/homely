import 'package:homely/src/models/property_model.dart';

abstract class PropertyRepository {
  Future<void> addProperty(Property property);

  Future<void> deleteProperty(String id);

  Stream<List<Property>> properties();

  Future<void> updateProperty(Property property);
}
