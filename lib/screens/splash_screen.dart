import 'package:flutter/material.dart';
import 'package:Convene/models/restaurant.dart';
import 'package:Convene/screens/home_page.dart';
import 'package:Convene/services/locaiton_service.dart';
import 'package:Convene/services/restaurants_service.dart';
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

  @override
  void initState() {
    super.initState();

    _setInitalData().then((status) {
      if (status) {
        _navigateToHome(location, restaurants);
      }
    });
  }

  // Future<bool> _checkForSession() async {
  //   // ignore: todo
  //   //TODO: Check for User Session - If logged in return true else return false.

  //   final response = await http.get(
  //       "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=API_KEY&location=${lat},${lng}&rankby=distance&keyword=restaurant");

  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> data = json.decode(response.body);
  //     handleResponse(data['results']);
  //   } else {
  //     throw Exception('An error occurred getting places nearby');
  //   }

  //   return true;
  // }

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

  void _navigateToHome(LatLng location, List<Restaurant> restaurants) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => HomePage(
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
