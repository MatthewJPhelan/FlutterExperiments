import 'package:Convene/models/global.dart';
import 'package:Convene/models/restaurant.dart';
import 'package:Convene/screens/restaurant_overview.dart';
import 'package:Convene/widgets/LocationRating/location_rating_stars.dart';
import 'package:flutter/material.dart';

class FavouriteCard extends StatelessWidget {
  Restaurant restaurant;
  FavouriteCard(this.restaurant);

  String isOpen(bool openNow) {
    return openNow ? "Open Now" : "Closed Now";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RestaurantOverview(restaurant: restaurant)),
        );
      },
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
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: restaurant.profilePic,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.white,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16),
              width: MediaQuery.of(context).size.width - 200,
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
                      restaurant.vicinity,
                      style: restaurantOverviewSubTitleStyle,
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
                  LocationRatingStars(restaurant.rating),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    margin: EdgeInsets.only(right: 8, top: 16),
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
            )
          ],
        ),
      ),
    );
  }
}
