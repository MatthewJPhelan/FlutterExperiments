import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Convene/models/global.dart';
import 'package:Convene/models/restaurant.dart';
import 'package:Convene/widgets/LocationCards/location_cards.dart';
import 'package:Convene/widgets/main_search/main_search.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  final List<Restaurant> restaurants;
  final LatLng intialLocation;
  final bool followUser;
  final String searchedDescription;
  List<Marker> allMarkers = [];

  HomePage(
      {this.restaurants,
      this.intialLocation,
      this.followUser: true,
      this.searchedDescription: ''}) {
    restaurants.forEach((element) {
      allMarkers.add(element.marker);
    });
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleMapController mapController;
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();

  void initState() {
    super.initState();
    getCurrentLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  CameraPosition getCameraPosition(newLocalData) {
    return CameraPosition(
        bearing: 192.8,
        target: LatLng(newLocalData.latitude, newLocalData.longitude),
        tilt: 0,
        zoom: 15);
  }

  void getCurrentLocation() async {
    if (widget.followUser) {
      try {
        if (_locationSubscription != null) {
          _locationSubscription.cancel();
        }

        _locationSubscription =
            _locationTracker.onLocationChanged().listen((newLocalData) {
          if (mapController != null) {
            mapController.animateCamera(CameraUpdate.newCameraPosition(
                getCameraPosition(newLocalData)));
          }
        });
      } on PlatformException catch (e) {
        if (e.code == 'PERMISSION DENIED') {
          debugPrint("Permission Denied");
        }
      }
    } else {
      if (mapController != null) {
        CameraPosition camerPostion = CameraPosition(
            bearing: 192.8,
            target: LatLng(widget.intialLocation.latitude,
                widget.intialLocation.longitude),
            tilt: 0,
            zoom: 15);
        mapController.animateCamera(
            CameraUpdate.newCameraPosition(getCameraPosition(camerPostion)));
      }
    }
  }

  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  Widget _getTopThird() {
    if (widget.followUser) {
      return MainSearch();
    } else {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromRGBO(0, 0, 0, 0.8),
            Color.fromRGBO(0, 0, 0, 0),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(true),
              child: Container(
                padding: EdgeInsets.only(top: 32, bottom: 32, left: 16),
                child: Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 32, bottom: 32, right: 16),
              child: Text(
                widget.searchedDescription,
                style: restaurantCardTitleStyle,
              ),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: widget.intialLocation,
                zoom: 15,
              ),
              markers: Set.from(widget.allMarkers),
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
            ),
            _getTopThird(),
            LocationCards(restaurants: widget.restaurants),
          ],
        ),
      ),
    );
  }
}
