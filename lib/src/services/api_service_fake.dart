import 'package:homely/src/mock/property.dart';
import 'package:homely/src/models/Property.dart';
import 'package:homely/src/services/api_service.dart';

class APIServiceFake extends AbstractAPIService {
  static final List<Property> _properties = properties;

  @override
  Future<List<Property>> getProperties() async {
    return Future.delayed(const Duration(seconds: 3), () {
      return _properties;
    });
  }
}
