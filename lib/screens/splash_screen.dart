import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/restaurant.dart';
import 'package:flutter_complete_guide/screens/home_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<Restaurant> restaurants = new List<Restaurant>();
  LatLng initialLocation;

  Future<LocationData> getLocation() async {
    Location location = Location();

    // bool _serviceEnabled;
    // PermissionStatus _permissionGranted;
    LocationData _locationData = await location.getLocation();

    // _serviceEnabled = await location.serviceEnabled();
    // if (!_serviceEnabled) {
    //   _serviceEnabled = await location.requestService();
    //   if (!_serviceEnabled) {
    //     return;
    //   }
    // }

    // _permissionGranted = await location.hasPermission();
    // if (_permissionGranted == PermissionStatus.denied) {
    //   _permissionGranted = await location.requestPermission();
    //   if (_permissionGranted != PermissionStatus.granted) {
    //     return;
    //   }
    // }

    return _locationData;
  }

  @override
  void initState() {
    super.initState();
    _checkForSession().then((status) {
      // ignore: todo
      //TODO: if true navigate to home page, else login page
      if (status) {
        _navigateToHome();
      }
    });
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

  void handleResponse(List map) {
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
  }

  Future<bool> _checkForSession() async {
    // ignore: todo
    //TODO: Check for User Session - If logged in return true else return false.

    final location = await getLocation();

    double lat = location.latitude;
    double lng = location.longitude;

    print("lat: ${lat}, lng: ${lng}");

    initialLocation = new LatLng(lat, lng);

    final response = await http.get(
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=API_KEY&location=${lat},${lng}&rankby=distance&keyword=restaurant");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      handleResponse(data['results']);
      print(data['results'].length);
    } else {
      throw Exception('An error occurred getting places nearby');
    }

    return true;
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => HomePage(
              restaurants: restaurants,
              intialLocation: initialLocation,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[850],
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: <Widget>[
            // Expanded(
            //   child: splashImage(),
            // ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Shimmer.fromColors(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.clear_all,
                        color: Colors.tealAccent,
                        size: 40.0,
                      ),
                    ),
                    baseColor: Theme.of(context).accentColor,
                    highlightColor: Colors.white,
                  ),
                  Text(
                    'CONVENE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontFamily: 'MuseoModerno',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  FittedBox splashImage() {
    return FittedBox(
      child: Opacity(
        opacity: 0.6,
        child: Image.asset('assets/images/walkingTogether.jpg'),
      ),
      fit: BoxFit.cover,
    );
  }
}
