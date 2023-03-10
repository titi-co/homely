import 'package:homely/src/models/property.dart';

abstract class AbstractAPIService {
  Future<List<Property>> getProperties();

  Future<Property> getProperty(String id);
}
