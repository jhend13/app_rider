import 'package:app_rider/config/constants.dart' as constants;
import 'package:app_rider/services/api/http.dart';
import 'package:app_rider/models/address.dart';
import 'package:app_rider/services/location.dart';
import 'package:geolocator/geolocator.dart' show Position;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart'
    show MapboxOptions;
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapboxApiService implements HttpAPI {
  final String _accessToken;

  // two ways to create MapBoxApiService
  // 1: you already have the access token
  // 2: mapboxapi will get the accesstoken itself but request is async...
  MapboxApiService(this._accessToken);
  MapboxApiService._(this._accessToken);

  static Future<MapboxApiService> create() async {
    String token = await MapboxOptions.getAccessToken();
    return MapboxApiService._(token);
  }

  Future<Address> reverseLookupSingle(double lat, double long) async {
    //mapbox api default limit for reverse api is 1
    final uri = Uri.http(
        constants.uriMapboxApiAuthority, constants.uriMapboxApiGeocodeReverse, {
      'latitude': lat.toString(),
      'longitude': long.toString(),
      'access_token': _accessToken,
      'types': 'street,address'
    });

    final response = await http.get(uri);
    final json = jsonDecode(response.body) as Map<String, dynamic>;

    // todo
    // implement handling of this ...
    // will also have json['message']
    if (json.containsKey('error_code')) {}

    return Address.fromJson(json['features'][0] as Map<String, dynamic>);
  }

  Future<List<Address>> forwardLookup(String address) async {
    // todo
    // probably don't want to keep accessing users location?
    // need to research if programmtically accessing via getPosition()
    // really has any limitations or if there's "too much"
    // also should probably just be passed as a param?...
    Position pos = await LocationService.getPosition();

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
