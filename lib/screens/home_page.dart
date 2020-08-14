import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_complete_guide/models/restaurant.dart';
import 'package:flutter_complete_guide/widgets/LocationCards/location_cards.dart';
import 'package:flutter_complete_guide/widgets/main_search/main_search.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  final List<Restaurant> restaurants;
  final LatLng intialLocation;
  final bool followUser;
  List<Marker> allMarkers = [];

  HomePage({this.restaurants, this.intialLocation, this.followUser: true}) {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
            MainSearch(),
            LocationCards(restaurants: widget.restaurants),
          ],
        ),
      ),
    );
  }
}
