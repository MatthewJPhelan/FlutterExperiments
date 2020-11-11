import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Restaurant {
  String placeId;
  NetworkImage icon;
  String name;
  int priceLevel;
  bool openNow;
  double rating;
  List<String> types;
  String phoneNum;
  String vicinity;
  Marker marker;
  NetworkImage profilePic;
  String cuisine;

  Restaurant(
      {this.placeId,
      this.icon,
      this.name,
      this.openNow,
      this.priceLevel,
      this.rating,
      this.types,
      this.phoneNum,
      this.vicinity,
      this.marker,
      this.profilePic,
      this.cuisine});

  Map<String, dynamic> toMap() {
    return {
      'place_id': placeId,
      'icon': icon.url,
      'name': name,
      'open_now': openNow,
      'price_level': priceLevel,
      'rating': rating,
      'types': json.encode(types),
      'phone_num': phoneNum,
      'vicinity': vicinity,
      'lat': marker.position.latitude,
      'lng': marker.position.longitude,
      'profile_pic': profilePic.url,
      'cuisine': cuisine
    };
  }
}
