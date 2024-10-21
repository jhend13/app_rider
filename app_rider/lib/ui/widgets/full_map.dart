import 'package:flutter/material.dart';
import 'package:app_rider/services/location_service.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class FullMap extends StatefulWidget {
  const FullMap();

  @override
  State createState() => FullMapState();
}

class FullMapState extends State<FullMap> {
  MapboxMap? mapboxMap;
  LocationService locationService = LocationService();

  @override
  void initState() {
    super.initState();
    String accessToken = const String.fromEnvironment("ACCESS_TOKEN");
    MapboxOptions.setAccessToken(accessToken);
  }

  _onMapCreated(MapboxMap mapboxMap) {
    this.mapboxMap = mapboxMap;

    mapboxMap.location.updateSettings(LocationComponentSettings(enabled: true));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: MapWidget(
      cameraOptions: CameraOptions(
          zoom: 10,
          center: Point(coordinates: Position(-117.42503, 47.659016))),
      key: ValueKey('mapWidget'),
      onMapCreated: _onMapCreated,
      onTapListener: (context) async {
        print(await locationService.getPosition());
      },
    ));
  }
}
