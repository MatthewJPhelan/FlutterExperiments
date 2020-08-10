import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/global.dart';
import 'package:flutter_complete_guide/models/restaurant.dart';
import 'package:flutter_complete_guide/widgets/LocationRating/location_rating_stars.dart';

class TopLevelLocation extends StatelessWidget {
  final Restaurant restaurant;

  TopLevelLocation({this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]),
        ),
      ),
      child: Row(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: restaurantOverviewTitleStyle,
                ),
                Text(
                  restaurant.cuisine,
                  style: restaurantOverviewSubTitleStyle,
                ),
                LocationRatingStars(restaurant.rating)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
