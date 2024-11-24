import 'package:app_rider/models/address.dart';
import 'package:app_rider/services/api/mapbox.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:app_rider/services/location.dart';
import 'package:app_rider/models/route.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:app_rider/models/point.dart' as point;

// TODO: figure out the bug on hot reload that causes this spam msg:
// Style object (accessing setStyleLayerProperty) should not be stored and used after MapView is destroyed or new style has been loaded.

// ALSO, verify that everything is properly being disposed of when navigating away.

class RouteMap extends StatefulWidget {
  static final GlobalKey<RouteMapState> routeMapKey =
      GlobalKey<RouteMapState>();

  final Address origin;
  final Address destination;

  const RouteMap({super.key, required this.origin, required this.destination});

  @override
  State createState() => RouteMapState();
}

class RouteMapState extends State<RouteMap> with WidgetsBindingObserver {
  MapboxMap? mapboxMap;
  PointAnnotationManager? annotationManager;
  PolylineAnnotationManager? polylineManager;
  MapboxApiService? mapboxApiService;
  late final Uint8List mapMarkerImageData;

  @override
  void initState() {
    super.initState();
    _initMapboxApiService();
    WidgetsBinding.instance.addObserver(this);
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

  _initMapboxApiService() async {
    mapboxApiService = await MapboxApiService.create();
    setState(() {});
  }

  void setRoute() {}

  _onMapCreated(MapboxMap mapboxMap) async {
    this.mapboxMap = mapboxMap;

    // remove scale bar, compass, and enable location puck
    mapboxMap.scaleBar.updateSettings(ScaleBarSettings(enabled: false));
    mapboxMap.compass.updateSettings(CompassSettings(enabled: false));
    mapboxMap.location.updateSettings(LocationComponentSettings(enabled: true));
    mapboxMap.logo.updateSettings(LogoSettings(enabled: false));
    mapboxMap.attribution
        .updateSettings(AttributionSettings(enabled: true, marginLeft: 10));

    annotationManager =
        await mapboxMap.annotations.createPointAnnotationManager();

    polylineManager =
        await mapboxMap.annotations.createPolylineAnnotationManager();

    final ByteData bytes = await rootBundle.load('assets/map-marker-32.png');
    mapMarkerImageData = bytes.buffer.asUint8List();

    // set camera bound
    CameraOptions options = await mapboxMap.cameraForCoordinatesPadding([
      Point(coordinates: Position(widget.origin.long, widget.origin.lat)),
      Point(
          coordinates:
              Position(widget.destination.long, widget.destination.lat))
    ], CameraOptions(zoom: 13),
        MbxEdgeInsets(top: 10, left: 40, bottom: 10, right: 40), null, null);

    mapboxMap.setCamera(options);

    // destination marker
    addMarker(widget.destination.long, widget.destination.lat);

    List<point.Point> points = [
      point.Point(widget.origin.lat, widget.origin.long),
      point.Point(widget.destination.lat, widget.destination.long)
    ];

    Route route = await mapboxApiService!.getRoute(points);

    //show route
    addRoute(route);
  }

  addRoute(Route route) {
    polylineManager!.create(PolylineAnnotationOptions(
        geometry: route.getLineString(),
        lineWidth: 3.0,
        lineColor: 0xFF0000FF));
  }

  addMarker(double long, double lat) {
    PointAnnotationOptions point = PointAnnotationOptions(
        geometry: Point(coordinates: Position(long, lat)),
        image: mapMarkerImageData,
        iconSize: 3.0);

    annotationManager?.create(point);
  }

  @override
  Widget build(BuildContext context) {
    // make sure mapboxApiService is initialized first
    if (mapboxApiService == null) {
      return const Center(child: CircularProgressIndicator());
    }

    var isDarkMode = Theme.of(context).brightness == Brightness.dark;

    mapboxMap?.style.setStyleURI(
        (isDarkMode) ? MapboxStyles.DARK : MapboxStyles.MAPBOX_STREETS);

    return Expanded(
        child: MapWidget(
            styleUri:
                (isDarkMode) ? MapboxStyles.DARK : MapboxStyles.MAPBOX_STREETS,
            key: const ValueKey('mapWidget'),
            onMapCreated: _onMapCreated,
            onTapListener: (context) {}));
  }
}
