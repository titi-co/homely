import 'package:homely/src/models/property_model.dart';

abstract class AbstractAPIService {
  Future<List<Property>> getProperties();

  Future<Property> getProperty(String id);
}
