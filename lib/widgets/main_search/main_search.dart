import 'package:flutter/material.dart';
import 'package:Convene/models/restaurant.dart';
import 'package:Convene/screens/home_page.dart';
import 'package:Convene/services/locaiton_service.dart';
import 'package:Convene/services/restaurants_service.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class MainSearch extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const MainSearch({Key key, this.scaffoldKey}) : super(key: key);

  @override
  _MainSearchState createState() => _MainSearchState();
}

class _MainSearchState extends State<MainSearch> {
  final myController = TextEditingController();
  static const kGoogleApiKey = "API_KEY";
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

  RestaurantsService _restaurantsService = new RestaurantsService();
  LocationService _locationService = new LocationService();

  @override
  void initState() {
    super.initState();
    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  //Textfield now printing keystrokes
  _printLatestValue() {
    print("Text field: ${myController.text}");
  }

  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);

      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

      LatLng searchedLocation = LatLng(lat, lng);

      var currentLocation = await _locationService.getCurrentLocation();

      LatLng middleLocation = await _restaurantsService.getInitalLocation(
          currentLocation, searchedLocation);

      List<Restaurant> restaurants = await _restaurantsService
          .getRestaurantsAsync(currentLocation, searchedLocation);

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  restaurants: restaurants,
                  intialLocation: middleLocation,
                  followUser: false,
                  searchedDescription: p.description,
                )),
      );
    }
  }

  void _getDataAndOpenDrawer() {
    widget.scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 8,
          top: MediaQuery.of(context).size.height * 0.075,
          child: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.grey[800],
            ),
            onPressed: () => _getDataAndOpenDrawer(),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            left: 54,
            right: 16,
            top: MediaQuery.of(context).size.height * 0.075,
          ),
          child: Container(
            padding: EdgeInsets.only(left: 8, right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
            child: Container(
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(5, 2, 12, 2),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey[600],
                      size: 24.0,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          onTap: () async {
                            Prediction p = await PlacesAutocomplete.show(
                                context: context,
                                apiKey: kGoogleApiKey,
                                mode: Mode.overlay, // Mode.fullscreen
                                language: "en",
                                components: [
                                  new Component(Component.country, "uk")
                                ]);
                            displayPrediction(p);
                          },
                          controller: myController,
                          decoration: InputDecoration(
                            hintText: "Enter an address or landmark...",
                            hintStyle: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey[500],
                                fontFamily: 'Roboto'),
                            border: InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
