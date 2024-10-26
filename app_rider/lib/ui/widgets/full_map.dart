import 'package:flutter/material.dart';
import 'package:app_rider/services/location_service.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class FullMap extends StatefulWidget {
  const FullMap();

  @override
  State createState() => FullMapState();
}

class FullMapState extends State<FullMap> with WidgetsBindingObserver {
  MapboxMap? mapboxMap;
  LocationService locationService = LocationService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    String accessToken = const String.fromEnvironment("ACCESS_TOKEN");
    MapboxOptions.setAccessToken(accessToken);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    setState(() {});
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  _onMapCreated(MapboxMap mapboxMap) {
    this.mapboxMap = mapboxMap;

    mapboxMap.location.updateSettings(LocationComponentSettings(enabled: true));
  }

  @override
  Widget build(BuildContext context) {
    var isDarkMode = Theme.of(context).brightness == Brightness.dark;

    mapboxMap?.style.setStyleURI(
        (isDarkMode) ? MapboxStyles.DARK : MapboxStyles.MAPBOX_STREETS);

    return Expanded(
        child: MapWidget(
      styleUri: (isDarkMode) ? MapboxStyles.DARK : MapboxStyles.MAPBOX_STREETS,
      cameraOptions: CameraOptions(
          zoom: 13,
          center: Point(coordinates: Position(-117.42503, 47.659016))),
      key: ValueKey('mapWidget'),
      onMapCreated: _onMapCreated,
      onTapListener: (context) async {
        print(await locationService.getPosition());
      },
    ));
  }
}
