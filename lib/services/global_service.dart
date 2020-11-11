import 'package:Convene/screens/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GlobalService {
  final GoogleSignIn _gSignIn = GoogleSignIn();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Null> signOut(BuildContext context) async {
    _gSignIn.signOut();
    FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.deleteAll();
    print("signed out");
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => SplashScreen()));
  }

  Future<Null> deletionService(BuildContext context, String collection) async {
    switch (collection) {
      case "favourites":
        {
          print("Del faves");
          deleteCollection(collection);
          Navigator.of(context).pop();
        }
        break;
      case "searched":
        {
          print("Del search");
          deleteCollection(collection);
          Navigator.of(context).pop();
        }
        break;
      case "account":
        {
          print("Del acc");
          deleteAccount(context);
        }
        break;
      default:
        {
          print("invalid choice");
        }
    }
  }

  Future<void> deleteCollection(String collection) async {
    User user = _auth.currentUser;

    CollectionReference ref =
        _firestore.collection('users').doc(user.uid).collection(collection);

    ref.get().then((snapshot) => {
          for (DocumentSnapshot ds in snapshot.docs) {ds.reference.delete()}
        });
  }

  Future<void> deleteAccount(context) async {
    try {
      User user = _auth.currentUser;
      deleteCollection("searched");
      deleteCollection("favourites");
      user.delete();
      signOut(context);
    } catch (e) {
      print(e.toString());
    }
  }
}
