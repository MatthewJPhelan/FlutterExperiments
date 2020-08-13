import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/global.dart';
import 'package:flutter_complete_guide/models/restaurant.dart';
import 'package:flutter_complete_guide/screens/restaurant_overview.dart';
import 'package:flutter_complete_guide/widgets/LocationRating/location_rating_stars.dart';

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
      padding: EdgeInsets.only(top: 512, bottom: 16),
      child: ListView(
        padding: EdgeInsets.only(left: 16),
        children: getRestaurantsInArea(context),
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  List<Widget> getRestaurantsInArea(BuildContext context) {
    List<Widget> cards = [];
    for (Restaurant restaurant in widget.restaurants) {
      cards.add(restaurantCard(restaurant, context));
    }
    return cards;
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
    child: Stack(
      children: <Widget>[
        Container(
          width: 280,
          margin: EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: restaurant.profilePic,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.white,
          ),
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
                  Text(
                    restaurant.name,
                    style: restaurantCardTitleStyle,
                  ),
                  Text(
                    restaurant.cuisine,
                    style: restaurantCardSubTitleStyle,
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
                  margin: EdgeInsets.only(bottom: 16),
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
  );
}
