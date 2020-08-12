import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_complete_guide/widgets/LocationCards/location_cards.dart';
import 'package:flutter_complete_guide/widgets/main_search/main_search.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future _future;

  Future<String> loadString() async =>
      await rootBundle.loadString('assets/data.json');
  List<Marker> allMarkers = [];

  GoogleMapController mapController;
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();

  static final CameraPosition initialLocation = CameraPosition(
    target: const LatLng(51.442928, -0.183450),
    zoom: 15,
  );

  void initState() {
    super.initState();
    _future = loadString();
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
    try {
      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged().listen((newLocalData) {
        if (mapController != null) {
          mapController.animateCamera(
              CameraUpdate.newCameraPosition(getCameraPosition(newLocalData)));
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION DENIED') {
        debugPrint("Permission Denied");
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
            FutureBuilder(
              future: _future,
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                List<dynamic> parsedJson = jsonDecode(snapshot.data);
                allMarkers = parsedJson.map((element) {
                  return Marker(
                      markerId: MarkerId(element['id']),
                      position: LatLng(element['lat'], element['lng']));
                }).toList();

                return GoogleMap(
                  initialCameraPosition: initialLocation,
                  markers: Set.from(allMarkers),
                  onMapCreated: _onMapCreated,
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                );
              },
            ),
            MainSearch(),
            LocationCards(),
          ],
        ),
      ),
    );
  }
}
