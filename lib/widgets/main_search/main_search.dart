import 'package:flutter/material.dart';

class MainSearch extends StatelessWidget {
  const MainSearch({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Colors.grey,
              blurRadius: 20.0,
            ),
          ],
          color: Colors.white,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  Icons.import_export,
                  color: Colors.grey[700],
                  size: 30.0,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      cursorColor: Colors.tealAccent,
                      decoration: InputDecoration(
                        hintText: "Location 1",
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.tealAccent,
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      cursorColor: Colors.tealAccent,
                      decoration: InputDecoration(
                        hintText: "Location 2",
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.tealAccent,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
