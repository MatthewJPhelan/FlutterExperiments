import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/global.dart';
import 'package:flutter_complete_guide/models/restaurant.dart';
import 'package:flutter_complete_guide/screens/restaurant_overview.dart';
import 'package:flutter_complete_guide/widgets/LocationRating/location_rating_stars.dart';

class LocationCards extends StatefulWidget {
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

  List<Restaurant> getRestaurants() {
    List<Restaurant> restaurants = [];
    NetworkImage profilePic = new NetworkImage(
        "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=CmRaAAAAsDE99D0L5Bbbe3caQnG1vTD9Bwc_Vp81UdRD2Io_GKv-BU1Lx0jBcNBGPNAL3MX0Wjl9Hqdv7-RYSMWYTZDgCFgV8BuASOPZVsqER316ZN2bw_uTf3YVoQeULMU_RkQOEhAXWh5ArbPjUCfcpJ8jemqXGhSVEUC7yDxItH1i0OiPEiXj24VHhA&key=API_KEY");
    Restaurant localRestaurant = new Restaurant(
        placeId: "ChIJsXHaDVgPdkgRgg8HuJD_4gU",
        icon:
            "https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png",
        name: "The Earlsfield Gastropub",
        priceLevel: 2,
        openNow: true,
        rating: 4.3,
        types: [
          "bar",
          "restaurant",
          "food",
          "point_of_interest",
          "establishment"
        ],
        phoneNum: '07777777777',
        vicinity: "511 Garratt Ln, London",
        lat: 51.4423572,
        lng: -0.1895192798927222,
        profilePic: profilePic,
        cuisine: 'Bar');
    restaurants.add(localRestaurant);

    NetworkImage profilePic1 = new NetworkImage(
        "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=CmRaAAAA1v3mcSnUe44WGigF0BGAsJ-iozMKyfLGQ7FM4ffbDYQinUD5ubhv6l3YBXW7eH-x9QM6Mw8ApP0bVIyNFLjIh_E3SXaK-3vXYdJRNun3DlyAdGY4QG-x8cgLDqJMt6kGEhBujxnk6p0Jwp7TZYVO823-GhRpW4uNLILXzFlY4LDdN8bD-Jpl9Q&key=API_KEY");
    Restaurant localRestaurant1 = new Restaurant(
        placeId: "ChIJMUTWAFgPdkgRxbvLXcdtdAc",
        icon:
            "https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png",
        name: "Burrito Mex",
        priceLevel: 1,
        openNow: true,
        rating: 4.3,
        types: [
          "meal_takeaway",
          "restaurant",
          "food",
          "point_of_interest",
          "establishment"
        ],
        phoneNum: '07123123456',
        vicinity: "368 Garratt Ln, London",
        lat: 51.4416093,
        lng: -0.18773,
        profilePic: profilePic1,
        cuisine: 'Meal Takeaway');
    restaurants.add(localRestaurant1);

    NetworkImage profilePic2 = new NetworkImage(
        "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=CmRaAAAAX6Y8y5fz_5f0pjACYUV3SeefXWfehEDgAPWLCCA66bhKSfgssoBbJNBQnJmkWA9tUcP76_tMKjU0rkEGQydpu61sL9ggeu2PJvVq7WEx6edrIxFFa9sEyyJBdpjm8qvOEhAXMW0FL9Hlz7r6ade2i2I4GhTdvRlnWdVux40xtLd9qDGy2f_pvg&key=API_KEY");
    Restaurant localRestaurant2 = new Restaurant(
        placeId: "ChIJ1wBIBPgFdkgRqa_yf4iihGA",
        icon:
            "https://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png",
        name: "Donburi & Co",
        priceLevel: 1,
        openNow: false,
        rating: 4.1,
        types: ["restaurant", "food", "point_of_interest", "establishment"],
        phoneNum: '07987654321',
        vicinity: "394 Garratt Ln, London",
        lat: 51.4408644,
        lng: -0.18711,
        profilePic: profilePic2,
        cuisine: 'Restaurant');
    restaurants.add(localRestaurant2);

    return restaurants;
  }

  List<Widget> getRestaurantsInArea(BuildContext context) {
    List<Restaurant> restaurants = getRestaurants();
    List<Widget> cards = [];
    for (Restaurant restaurant in restaurants) {
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
          margin: EdgeInsets.only(right: 20),
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
              width: 240,
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
            )
          ],
        ),
        //   child: Stack(
        //     children: <Widget>[

        //       // Container(
        //       //   margin: EdgeInsets.only(top: 30),
        //       //   child: Row(
        //       //     children: <Widget>[
        //       //       Text(
        //       //         "Status:  ",
        //       //         style: techCardSubTitleStyle,
        //       //       ),
        //       //       Text(technician.status, style: statusStyles[technician.status])
        //       //     ],
        //       //   ),
        //       // ),
        //       // Container(
        //       //   margin: EdgeInsets.only(top: 40),
        //       //   child: Column(
        //       //     crossAxisAlignment: CrossAxisAlignment.start,
        //       //     children: <Widget>[
        //       //       Row(
        //       //         children: <Widget>[
        //       //           Text(
        //       //             "Rating: " + technician.rating.toString(),
        //       //             style: techCardSubTitleStyle,
        //       //           )
        //       //         ],
        //       //       ),
        //       //       Row(children: getRatings(technician))
        //       //     ],
        //       //   ),
        //       // )
        //     ],
        //   ),
        // ),
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
