import 'package:app_rider/services/api/mapbox.dart';
import 'package:app_rider/services/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class Address {
  final String address;
  final String country;
  final String countryCode;
  final String place;
  final String street;
  final String name;
  final int? zipcode;
  double lat;
  double long;

  Address(
      {required this.address,
      required this.country,
      required this.countryCode,
      required this.place,
      required this.street,
      required this.name,
      this.zipcode,
      required this.lat,
      required this.long});

  static Future<Address> fromCurrentLocation() async {
    Position pos = await LocationService.getPosition();
    MapboxApiService mapboxApi = await MapboxApiService.create();
    Address address =
        await mapboxApi.reverseLookupSingle(pos.latitude, pos.longitude);
    return address;
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        address: json['properties']['full_address'],
        country: json['properties']['context']['country']['name'],
        countryCode: json['properties']['context']['country']['country_code'],
        street: json['properties']['context']['street']['name'],
        place: json['properties']['context']['place']['name'],
        name: json['properties']['name'],
        lat: json['properties']['coordinates']['latitude'],
        long: json['properties']['coordinates']['longitude']);
  }

  Address.fromEmpty()
      : address = '',
        country = '',
        countryCode = '',
        place = '',
        street = '',
        name = '',
        lat = 0,
        long = 0,
        zipcode = 0;
}
