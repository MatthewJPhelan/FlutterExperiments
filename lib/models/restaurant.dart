import 'package:flutter/material.dart';

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
  double lat;
  double lng;
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
      this.lat,
      this.lng,
      this.profilePic,
      this.cuisine});
}
