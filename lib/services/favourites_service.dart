import 'package:Convene/models/restaurant.dart';
import 'package:Convene/services/restaurants_service.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavouritesService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User user;
  RestaurantsService _restaurantsService = new RestaurantsService();

  FavouritesService() {
    this.user = _auth.currentUser;
  }

  Future<List<String>> getFavouritesAsync() async {
    CollectionReference ref =
        _firestore.collection('users').doc(user.uid).collection('favourites');

    List<String> favouritesList = [];

    await ref.get().then((QuerySnapshot querySnapshot) => {
          querySnapshot.docs.forEach((doc) {
            favouritesList.add(doc.id);
          })
        });

    return favouritesList;
  }
}
