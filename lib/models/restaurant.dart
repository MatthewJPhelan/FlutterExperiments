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
}
