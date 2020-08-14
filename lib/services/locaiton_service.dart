import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationService {
  Future<LocationData> getCurrentLocationData() async {
    Location location = Location();
    LocationData _locationData = await location.getLocation();

    return _locationData;
  }

  Future<LatLng> getCurrentLocation() async {
    LocationData locationData = await getCurrentLocationData();
    return LatLng(locationData.latitude, locationData.longitude);
  }
}
