import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Convene/models/global.dart';
import 'package:Convene/models/restaurant.dart';
import 'package:Convene/widgets/LocationOverview/location_show_more.dart';
import 'package:Convene/widgets/LocationOverview/location_types.dart';
import 'package:Convene/widgets/LocationOverview/top_level_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class RestaurantOverview extends StatefulWidget {
  final Restaurant restaurant;
  LatLng _center;

  RestaurantOverview({this.restaurant}) {
    _center = restaurant.marker.position;
  }

  @override
  _RestaurantOverviewState createState() => _RestaurantOverviewState();
}

class _RestaurantOverviewState extends State<RestaurantOverview> {
  GoogleMapController mapController;

  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();

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

  Set<Marker> getMarkers() {
    MarkerId _markerId = new MarkerId(widget.restaurant.placeId);
    Marker _marker = new Marker(
      markerId: _markerId,
      position: widget._center,
      alpha: 0.8,
    );
    Set<Marker> _markers = new Set<Marker>();
    _markers.add(_marker);

    return _markers;
  }

  Widget getPriceLevel(priceLevel) {
    if (priceLevel != null) {
      return Container(
        margin: EdgeInsets.only(top: 8.0),
        padding: EdgeInsets.only(left: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 16),
              child: Text(
                'Price Level',
                style: locationTypeListTitleStyle,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 2),
              child: Row(
                children: List.generate(
                  widget.restaurant.priceLevel,
                  (index) => Icon(
                    Icons.attach_money,
                    color: Colors.tealAccent,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 240,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(0, 0, 0, 0.6),
                      Color.fromRGBO(0, 0, 0, 0),
                    ]),
                    image: DecorationImage(
                      image: widget.restaurant.profilePic,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(true),
                  child: Container(
                    padding: EdgeInsets.only(top: 32, left: 16),
                    child: Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: 180,
                          left: MediaQuery.of(context).size.width - 60),
                      padding: EdgeInsets.all(10),
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Image(
                        color: Colors.white,
                        image: widget.restaurant.icon,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  TopLevelLocation(restaurant: widget.restaurant),
                  LocationTypes(types: widget.restaurant.types),
                  getPriceLevel(widget.restaurant.priceLevel),
                  ExpandableText(
                      "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book."),
                  Container(
                    margin: EdgeInsets.only(left: 16.0, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          child: Text(
                            "Adress",
                            style: locationTypeListTitleStyle,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: Text(widget.restaurant.vicinity),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 230,
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: widget._center,
                        zoom: 14.5,
                      ),
                      myLocationEnabled: true,
                      zoomControlsEnabled: false,
                      myLocationButtonEnabled: false,
                      markers: getMarkers(),
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
}
