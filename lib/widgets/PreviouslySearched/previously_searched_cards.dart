import 'package:Convene/models/global.dart';
import 'package:Convene/models/restaurant.dart';
import 'package:Convene/screens/home_page.dart';
import 'package:Convene/screens/restaurant_overview.dart';
import 'package:Convene/services/locaiton_service.dart';
import 'package:Convene/services/restaurants_service.dart';
import 'package:Convene/widgets/LocationRating/location_rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PreviouslySearchedCard extends StatefulWidget {
  Map<String, dynamic> searched;

  PreviouslySearchedCard(this.searched);

  @override
  _PreviouslySearchedCardState createState() => _PreviouslySearchedCardState();
}

class _PreviouslySearchedCardState extends State<PreviouslySearchedCard> {
  LocationService _locationService = new LocationService();
  GoogleMapController mapController;
  RestaurantsService _restaurantsService = new RestaurantsService();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<Map<String, String>> _getSemanticLocations() async {
    String searchedDescription;

    widget.searched["initialdescription"] != null
        ? searchedDescription = widget.searched["initialdescription"]
        : searchedDescription = await _locationService.getSematicLocation(
            widget.searched["searched"]["Lat"],
            widget.searched["searched"]["long"]);

    return {
      "currentSemantic": await _locationService.getSematicLocation(
          widget.searched["current"]["Lat"],
          widget.searched["current"]["long"]),
      "searchedSemantic": searchedDescription,
      "midPointSemantic": await _locationService.getSematicLocation(
          widget.searched["midpoint"]["Lat"],
          widget.searched["midpoint"]["long"]),
    };
  }

  Future<Null> getMap(
      double lat, double lng, String semanticDescription) async {
    LatLng searchedLocation = LatLng(lat, lng);
    String searchedDescription = semanticDescription;
    List<Restaurant> restaurants =
        await _restaurantsService.getRestaurantsAsync(searchedLocation);

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HomePage(
                restaurants: restaurants,
                intialLocation: searchedLocation,
                followUser: false,
                searchedDescription: searchedDescription,
              )),
    );
  }

  Widget searchedCard(context, cur, sea, mid, midlat, midlong) {
    return GestureDetector(
      onTap: () => getMap(midlat, midlong, mid),
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500],
              blurRadius: 12,
              offset: Offset(-4, 4),
            )
          ],
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width - 220,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Searched from:",
                          style: locationTypeListTitleStyle,
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          cur,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mid Point:",
                          style: locationTypeListTitleStyle,
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          mid,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Searched for:",
                          style: locationTypeListTitleStyle,
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          sea,
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 200,
              height: 240,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(midlat, midlong),
                  zoom: 14.5,
                ),
                myLocationEnabled: false,
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    return FutureBuilder<Map<String, String>>(
        future: _getSemanticLocations(),
        builder: (context, AsyncSnapshot<Map<String, String>> snapshot) {
          if (snapshot.hasData) {
            return searchedCard(
                context,
                snapshot.data["currentSemantic"],
                snapshot.data["searchedSemantic"],
                snapshot.data["midPointSemantic"],
                widget.searched["midpoint"]["Lat"],
                widget.searched["midpoint"]["long"]);
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
