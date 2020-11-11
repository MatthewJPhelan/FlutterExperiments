import 'package:flutter/material.dart';
import 'package:Convene/models/global.dart';
import 'package:Convene/models/restaurant.dart';
import 'package:Convene/widgets/LocationRating/location_rating_stars.dart';

class TopLevelLocation extends StatelessWidget {
  final Restaurant restaurant;

  TopLevelLocation({this.restaurant});

  String isOpen(bool openNow) {
    return openNow ? "Open Now" : "Closed Now";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Text(
                    restaurant.name,
                    style: restaurantOverviewTitleStyle,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  margin: EdgeInsets.only(top: 4),
                  child: Text(
                    restaurant.cuisine,
                    style: restaurantOverviewSubTitleStyle,
                  ),
                ),
                LocationRatingStars(restaurant.rating)
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            margin: EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.blueGrey[900],
            ),
            child: Text(
              isOpen(restaurant.openNow),
              style: restaurantCardSubTitleStyle,
            ),
          )
        ],
      ),
    );
  }
}
