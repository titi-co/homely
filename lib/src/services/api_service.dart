import 'package:homely/src/models/Property.dart';

abstract class AbstractAPIService {
  Future<List<Property>> getProperties();

  Future<Property> getProperty(String id);
}
