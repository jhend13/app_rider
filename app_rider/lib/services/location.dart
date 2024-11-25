import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Position> getPosition() async {
    if (await checkPermissions()) {
      const LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );

      return await Geolocator.getCurrentPosition(
          locationSettings: locationSettings);
    }

    return Future.error('Location cannot be accessed.');
  }

  static Future<bool> checkPermissions() async {
    bool locationServiceEnabled;
    LocationPermission permission;

    locationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!locationServiceEnabled) {
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }
}
