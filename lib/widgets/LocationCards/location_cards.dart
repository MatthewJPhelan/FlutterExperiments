import 'package:flutter/material.dart';
import 'package:Convene/models/global.dart';
import 'package:Convene/models/restaurant.dart';
import 'package:Convene/screens/restaurant_overview.dart';
import 'package:Convene/widgets/LocationRating/location_rating_stars.dart';

class LocationCards extends StatefulWidget {
  final List<Restaurant> restaurants;

  const LocationCards({this.restaurants});
  @override
  _LocationCardsState createState() => _LocationCardsState();
}

class _LocationCardsState extends State<LocationCards> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.70),
      child: ListView.builder(
          padding: EdgeInsets.only(left: 16),
          scrollDirection: Axis.horizontal,
          itemCount: widget.restaurants.length,
          itemBuilder: (BuildContext ctxt, int index) =>
              restaurantCard(widget.restaurants[index], context)),
    );
  }
}

Widget restaurantCard(Restaurant restaurant, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RestaurantOverview(restaurant: restaurant)),
      );
    },
    child: Container(
      margin: EdgeInsets.only(right: 12, bottom: 16),
      child: Stack(
        children: <Widget>[
          Container(
            width: 280,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: restaurant.profilePic,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[900],
                    blurRadius: 8,
                    offset: Offset(-4, 4),
                  )
                ]),
          ),
          Row(
            children: <Widget>[
              Container(
                width: 220,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(0, 0, 0, 0.6),
                    Color.fromRGBO(0, 0, 0, 0),
                  ]),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 40),
                      child: Text(
                        restaurant.name,
                        style: restaurantCardTitleStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        restaurant.cuisine,
                        style: restaurantCardSubTitleStyle,
                      ),
                    ),
                    LocationRatingStars(restaurant.rating)
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 12),
                    padding: EdgeInsets.all(10),
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Image(
                      color: Colors.white,
                      image: restaurant.icon,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
