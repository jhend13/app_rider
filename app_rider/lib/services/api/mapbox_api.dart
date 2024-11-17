import 'package:app_rider/config/constants.dart' as constants;
import 'package:app_rider/services/api/http_api.dart';
import 'package:app_rider/models/address.dart';
import 'package:app_rider/services/location.dart';
import 'package:geolocator/geolocator.dart' show Position;
//import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapboxApiService implements HttpAPI {
  final String _accessToken;
  final LocationService _locationService = LocationService();

  MapboxApiService(this._accessToken);

  // below pattern would be used if we want MapboxApiService
  // to automatically get the current accessToken from
  // MapboxOptions.getAccessToken (returns Future<String>)
  // but for now passing to generative constructor makes the most sense

  // MapboxApiService._(this._accessToken);

  // static Future<MapboxApiService> create() async {
  //   String token = await MapboxOptions.getAccessToken();
  //   return MapboxApiService._(token);
  // }

  Future<List<Address>> forwardLookup(String address) async {
    // todo
    // probably don't want to keep accessing users location?
    // need to research if programmtically accessing via getPosition()
    // really has any limitations or if there's "too much"
    // also should probably just be passed as a param?...
    Position pos = await _locationService.getPosition();

    final uri = Uri.http(
        constants.uriMapboxApiAuthority, constants.uriMapboxApiGeocodeForward, {
      'q': address,
      'access_token': _accessToken,
      'proximity': '${pos.longitude},${pos.latitude}',
      'types': 'street,address'
    });

    final response = await http.get(uri);
    final json = jsonDecode(response.body) as Map<String, dynamic>;

    // todo
    // implement handling of this ...
    // will also have json['message']
    if (json.containsKey('error_code')) {}

    //return List<Address>.from((json['features'] as List)
    //    .map((feature) => Address.fromJson(feature as Map<String, dynamic>)));
    return (json['features'] as List? ?? [])
        .map((feature) => Address.fromJson(feature as Map<String, dynamic>))
        .toList();
  }
}
