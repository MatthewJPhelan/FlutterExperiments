import 'dart:async';
import 'package:Convene/models/global.dart';
import 'package:Convene/models/restaurant.dart';
import 'package:Convene/services/favourites_service.dart';
import 'package:Convene/services/restaurants_service.dart';
import 'package:Convene/widgets/Favourites/favourite_card.dart';
import 'package:Convene/widgets/Global/page_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Favourites extends StatefulWidget {
  FavouritesService _favouritesService = new FavouritesService();
  RestaurantsService _restaurantsService = new RestaurantsService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  // List<String> favsIds;
  // List<Restaurant> favRestaurants;
  // @override
  // void initState() {
  //   super.initState();
  //   _getFavouriteRestaurantsIds();
  // }

  // void _getFavouriteRestaurantsIds() async {
  //   favsIds = await widget._favouritesService.getFavouritesAsync();

  //   for (var el in favsIds) {
  //     Restaurant favRestaurant =
  //         await widget._restaurantsService.getRestaurantById(el);
  //     favRestaurants.add(favRestaurant);
  //   }
  // }

  // void _getFavouriteRestaurants() async {
  //   for (var el in favsIds) {
  //     Restaurant favRestaurant =
  //         await widget._restaurantsService.getRestaurantById(el);
  //     favRestaurants.add(favRestaurant);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            PageTitle(title: "Favourites"),
            SizedBox(
              height: MediaQuery.of(context).size.height - 100,
              child: StreamBuilder(
                stream: widget._firestore
                    .collection('users')
                    .doc(widget._auth.currentUser.uid)
                    .collection('favourites')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.data.size == 0) {
                      return Container(
                        width: MediaQuery.of(context).size.width - 80,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Whole lot of nothin'.",
                                textAlign: TextAlign.center,
                                style: locationTypeListTitleStyle,
                              ),
                              Text(
                                "Get favouriting locations you like, or want to see again!",
                                textAlign: TextAlign.center,
                                style: restaurantOverviewSubTitleStyle,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return ListView(
                      scrollDirection: Axis.vertical,
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        return FavouriteCard(widget._restaurantsService
                            .createFavouriteRestaurant(document.data()));
                      }).toList(),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
