import 'package:Convene/models/user_details.dart';
import 'package:Convene/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:Convene/models/restaurant.dart';
import 'package:Convene/screens/home_page.dart';
import 'package:Convene/services/locaiton_service.dart';
import 'package:Convene/services/restaurants_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static RestaurantsService _restaurantsService = new RestaurantsService();
  static LocationService _locationService = new LocationService();
  LatLng location;
  List<Restaurant> restaurants;
  UserDetails userDetails;

  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();

    _setInitalData().then((status) {
      if (status) {
        _checkIfLoggedIn().then((loggedIn) {
          if (loggedIn) {
            _getStoredValue().then((value) => {
                  if (value) {_navigateToHome()}
                });
          } else {
            _navigateToLogIn();
          }
        });
      }
    });
  }

  Future<bool> _getStoredValue() async {
    try {
      String providerDetails = await storage.read(key: "provideId");
      String userName = await storage.read(key: "displayName");
      String photoUrl = await storage.read(key: "photoUrl");
      String userEmail = await storage.read(key: "email");

      userDetails =
          new UserDetails(providerDetails, userName, photoUrl, userEmail);
    } catch (e) {
      throw Exception("An error occured getting user data");
    }
    return true;
  }

  Future<bool> _checkIfLoggedIn() async {
    final response = await storage.read(key: "email");

    if (response != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> _setInitalData() async {
    try {
      location = await _getInitalLocation();
      restaurants = await _getInitalRestaurants(location);
    } catch (e) {
      throw Exception('An error occurred getting places nearby: $e');
    }
    return true;
  }

  Future<LatLng> _getInitalLocation() async {
    return await _locationService.getCurrentLocation();
  }

  Future<List<Restaurant>> _getInitalRestaurants(LatLng location) async {
    return await _restaurantsService.getRestaurantsAsync(location);
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => HomePage(
              restaurants: restaurants,
              intialLocation: location,
              userDetails: userDetails,
            )));
  }

  void _navigateToLogIn() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => LogInPage(
              restaurants: restaurants,
              intialLocation: location,
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
