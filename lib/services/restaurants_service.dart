import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/restaurant.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class RestaurantsService {
  Future<LocationData> getCurrentLocation() async {
    Location location = Location();
    LocationData _locationData = await location.getLocation();

    return _locationData;
  }

  LatLng calculateMiddlePoint(double currentLat, double currentLng,
      double searchedLat, double searchedLng) {
    double higherLat = max(currentLat, searchedLat);
    double lowerLat = min(currentLat, searchedLat);
    double higherLng = max(currentLng, searchedLng);
    double lowerLng = min(currentLng, searchedLng);

    double latDiff = higherLat - lowerLat;
    double lngDiff = higherLng - lowerLng;

    return LatLng(lowerLat + (latDiff / 2), lowerLng + (lngDiff / 2));
  }

  Future<LatLng> getInitalLocation(LatLng currentLocation,
      [LatLng searchedLocation]) async {
    var location = await getCurrentLocation();
    double currentLat = location.latitude;
    double currentLng = location.longitude;

    if (searchedLocation != null) {
      double searchedLat = searchedLocation.latitude;
      double searchedLng = searchedLocation.longitude;

      return calculateMiddlePoint(
          currentLat, currentLng, searchedLat, searchedLng);
    } else {
      return LatLng(currentLat, currentLng);
    }
  }

  Future<List<Restaurant>> getRestaurantsAsync(LatLng currentLocation,
      [LatLng searchedLocation]) async {
    final location = await getInitalLocation(currentLocation, searchedLocation);

    double lat = location.latitude;
    double lng = location.longitude;

    final response = await http.get(
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=API_KEY&location=${lat},${lng}&rankby=distance&keyword=restaurant");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return handleResponse(data['results']);
    } else {
      throw Exception('An error occurred getting places nearby');
    }
  }

  NetworkImage getIcon(String iconString) {
    return NetworkImage(iconString);
  }

  NetworkImage getProfilePic(String profilePicString) {
    return NetworkImage(
        "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${profilePicString}&key=API_KEY");
  }

  Marker getMarker(String placeId, dynamic element) {
    MarkerId markerId = MarkerId(placeId);
    Marker marker = Marker(
      markerId: markerId,
      position: LatLng(element['lat'], element['lng']),
    );

    return marker;
  }

  bool findIfOpen(element) {
    if (element != null) {
      return element['open_now'];
    }
    return false;
  }

  String removeStopCharacters(String type) {
    return type.replaceAll(new RegExp('[\\W_]+'), ' ').toUpperCase();
  }

  List<Restaurant> handleResponse(List map) {
    List<Restaurant> restaurants = new List<Restaurant>();

    map.forEach((element) {
      Restaurant restaurant;
      if (element['photos'] != null) {
        restaurant = new Restaurant(
          placeId: element['place_id'],
          icon: getIcon(element['icon']),
          name: element['name'],
          openNow: findIfOpen(element['opening_hours']),
          priceLevel: element['price_level'],
          rating: element['rating'].toDouble(),
          types: element['types'].cast<String>(),
          phoneNum: "077777777777",
          vicinity: element['vicinity'],
          marker: getMarker(
            element['place_id'],
            element['geometry']['location'],
          ),
          profilePic: getProfilePic(element['photos'][0]["photo_reference"]),
          cuisine: removeStopCharacters(element['types'][0]),
        );
        restaurants.add(restaurant);
      }
    });

    return restaurants;
  }
}
