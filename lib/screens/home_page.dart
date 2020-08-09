import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/global.dart';
import 'package:flutter_complete_guide/models/technician.dart';
import 'package:flutter_complete_guide/widgets/main_search/main_search.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(51.442928, -0.183450);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              myLocationButtonEnabled: false,
            ),
            MainSearch(),
            Container(
              padding: EdgeInsets.only(top: 550, bottom: 50),
              child: ListView(
                padding: EdgeInsets.only(left: 20),
                children: getTechniciansInArea(),
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Technician> getTechies() {
    List<Technician> techies = [];
    for (int i = 0; i < 10; i++) {
      AssetImage profilePic =
          new AssetImage("assets/images/walkingTogether.jpg");
      Technician myTechy = new Technician(
          "Carlos Teller",
          "070-379-031",
          "First road 23 elm street",
          529.3,
          4,
          "Available",
          profilePic,
          "Electrician");
      techies.add(myTechy);
    }
    return techies;
  }

  List<Widget> getTechniciansInArea() {
    List<Technician> techies = getTechies();
    List<Widget> cards = [];
    for (Technician techy in techies) {
      cards.add(technicianCard(techy));
    }
    return cards;
  }
}

// Map statusStyles = {
//   'Available': statusAvailableStyle,
//   'Unavailable': statusUnavailableStyle
// };

Widget technicianCard(Technician technician) {
  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.only(right: 20),
    width: 280,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: Colors.white,
    ),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              child: CircleAvatar(
                backgroundImage: technician.profilePic,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  technician.name,
                  style: techCardTitleStyle,
                ),
                Text(
                  technician.occupation,
                  style: techCardSubTitleStyle,
                )
              ],
            )
          ],
        ),
        // Container(
        //   margin: EdgeInsets.only(top: 30),
        //   child: Row(
        //     children: <Widget>[
        //       Text(
        //         "Status:  ",
        //         style: techCardSubTitleStyle,
        //       ),
        //       Text(technician.status, style: statusStyles[technician.status])
        //     ],
        //   ),
        // ),
        // Container(
        //   margin: EdgeInsets.only(top: 40),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: <Widget>[
        //       Row(
        //         children: <Widget>[
        //           Text(
        //             "Rating: " + technician.rating.toString(),
        //             style: techCardSubTitleStyle,
        //           )
        //         ],
        //       ),
        //       Row(children: getRatings(technician))
        //     ],
        //   ),
        // )
      ],
    ),
  );
}

// List<Widget> getRatings(Technician techy) {
//   List<Widget> ratings = [];
//   for (int i = 0; i < 5; i++) {
//     if (i < techy.rating) {
//       ratings.add(new Icon(Icons.star, color: Colors.yellow));
//     } else {
//       ratings.add(new Icon(Icons.star_border, color: Colors.black));
//     }
//   }
//   return ratings;
// }
