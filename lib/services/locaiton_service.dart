import 'package:geocoding/geocoding.dart' as geoc;
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

  Future<String> getSematicLocation(double lat, double long) async {
    List<geoc.Placemark> placemarks =
        await geoc.placemarkFromCoordinates(lat, long);
    geoc.Placemark placemark = placemarks[0];
    String locality = "";

    if (placemark.locality.length > 0) {
      locality = placemark.locality;
    } else if (placemark.thoroughfare.length > 0) {
      locality = placemark.thoroughfare;
    } else if (placemark.street.length > 0) {
      locality = placemark.street;
    } else if (placemark.subAdministrativeArea.length > 0) {
      locality = placemark.street;
    }

    return "$locality, ${placemark.postalCode}";
  }
}
