import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class Route {
  // seconds
  double duration;
  // meters
  double distance;
  String? summary;
  List<List<double>> coordinates;

  Route(
      {required this.duration,
      required this.distance,
      required this.coordinates,
      this.summary});

  // returns coordinateas as a Mapbox linestring
  LineString getLineString() {
    return LineString(
        coordinates:
            coordinates.map((list) => Position(list[0], list[1])).toList());
  }

  factory Route.fromJSON(Map<String, dynamic> json) {
    // convert List<dynamic> type to List<List<double>>
    List<List<double>> coordinates =
        (json['geometry']['coordinates'] as List<dynamic>)
            .map((pair) => <double>[pair[0] as double, pair[1] as double])
            .toList();

    return Route(
        duration: json['duration'],
        distance: json['distance'],
        coordinates: coordinates,
        summary: json['legs'][0]['summary']);
  }
}
