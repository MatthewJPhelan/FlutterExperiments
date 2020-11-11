import 'dart:async';
import 'package:Convene/models/user_details.dart';
import 'package:Convene/widgets/AppDrawer/app_drawer.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Convene/models/global.dart';
import 'package:Convene/models/restaurant.dart';
import 'package:Convene/widgets/LocationCards/location_cards.dart';
import 'package:Convene/widgets/main_search/main_search.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart' show rootBundle;

class HomePage extends StatefulWidget {
  final List<Restaurant> restaurants;
  final LatLng intialLocation;
  final UserDetails userDetails;
  final bool followUser;
  final String searchedDescription;

  HomePage(
      {this.restaurants,
      this.intialLocation,
      this.userDetails,
      this.followUser: true,
      this.searchedDescription: ''});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapController mapController;
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Trace trace = FirebasePerformance.instance.newTrace('test traceroony');
  Timer _timerPager;
  PageController _pageViewMapsController = PageController();
  String _mapStyle;
  BitmapDescriptor pinLocationIcon;

  void initState() {
    setCustomMapPin();
    trace.start();
    getCurrentLocation();
    rootBundle.loadString('assets/mapStyle.txt').then((string) {
      _mapStyle = string;
    });
    super.initState();
    trace.stop();
    Future.delayed(Duration(seconds: 1), () => _timerPagerStart());
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'assets/destinationMapMarker.png',
    );
  }

  _timerPagerStart() {
    if (_timerPager == null) {
      _timerPager = Timer.periodic(const Duration(seconds: 5), (timer) {
        try {
          _callNextViewPagerPage();
        } catch (e) {
          _timerPager.cancel();
          _timerPager = null;
        }
      });
    }
  }

  _callNextViewPagerPage() {
    if (_pageViewMapsController.page != 2) {
      _pageViewMapsController.nextPage(
          duration: kTabScrollDuration, curve: Curves.ease);
    } else {
      _pageViewMapsController.animateToPage(0,
          duration: kTabScrollDuration, curve: Curves.ease);
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle(_mapStyle);
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
      return MainSearch(scaffoldKey: scaffoldKey);
    } else {
      return Container(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
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
              width: MediaQuery.of(context).size.width * 0.8,
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

  Set<Marker> getAllMarkers() {
    List<Marker> allMarkers = [];
    widget.restaurants.forEach((element) {
      if (element != null) {
        Marker marker = new Marker(
            markerId: element.marker.markerId,
            position: element.marker.position,
            icon: pinLocationIcon);
        allMarkers.add(marker);
      }
    });

    return Set<Marker>.from(allMarkers);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomPadding: false,
        drawer: AppDrawer(
          userDetails: widget.userDetails,
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: widget.intialLocation,
                zoom: 15,
              ),
              markers: getAllMarkers(),
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
