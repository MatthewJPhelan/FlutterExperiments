import 'package:flutter/material.dart';
import 'package:Convene/models/global.dart';

class LocationTypes extends StatelessWidget {
  final List<String> types;

  LocationTypes({this.types});

  String removeStopCharacters(String type) {
    return type.replaceAll(new RegExp('[\\W_]+'), ' ').toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      padding: EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 8),
            child: Text(
              'Location Types',
              style: locationTypeListTitleStyle,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            height: 28,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(types.length, (index) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.blueGrey[900],
                  ),
                  child: Text(
                    removeStopCharacters(types[index]),
                    style: locationTypeListStyle,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
