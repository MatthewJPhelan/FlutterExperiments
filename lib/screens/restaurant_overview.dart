import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/restaurant.dart';

class RestaurantOverview extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantOverview({this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Container(
            height: 240,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromRGBO(0, 0, 0, 0.6),
                Color.fromRGBO(0, 0, 0, 0),
              ]),
              borderRadius: BorderRadius.all(Radius.circular(8)),
              image: DecorationImage(
                image: restaurant.profilePic,
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
        ],
      ),
    );
  }
}
