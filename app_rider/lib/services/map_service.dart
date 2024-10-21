import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MapService {
  final String _accessToken = const String.fromEnvironment("ACCESS_TOKEN");

  MapService() {
    MapboxOptions.setAccessToken(_accessToken);
  }
}
