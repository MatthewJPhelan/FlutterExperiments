import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class LocationRatingStars extends StatelessWidget {
  final double rating;

  LocationRatingStars(this.rating);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: SmoothStarRating(
        color: Colors.tealAccent,
        rating: rating,
        isReadOnly: false,
        size: 16,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star_half,
        defaultIconData: Icons.star_border,
        starCount: 5,
        allowHalfRating: true,
        spacing: 2.0,
        onRated: (value) {
          print("rating value -> $value");
          // print("rating value dd -> ${value.truncate()}");
        },
      ),
    );
  }
}
