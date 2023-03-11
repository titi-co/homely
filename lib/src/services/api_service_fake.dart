/*import 'package:homely/src/mock/property.dart';
import 'package:homely/src/models/property_model.dart';
import 'package:homely/src/services/api_service.dart';

class APIServiceFake extends AbstractAPIService {
  static final List<Property> _properties = properties;

  static final Property _property = property;

  @override
  Future<List<Property>> getProperties() async {
    return Future.delayed(const Duration(seconds: 3), () {
      return _properties;
    });
  }

  @override
  Future<Property> getProperty(String id) async {
    return Future.delayed(const Duration(seconds: 3), () {
      return _property;
    });
  }
}

*/