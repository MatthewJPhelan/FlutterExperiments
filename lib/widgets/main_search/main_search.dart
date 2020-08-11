import 'package:flutter/material.dart';

class MainSearch extends StatefulWidget {
  const MainSearch({
    Key key,
  }) : super(key: key);

  @override
  _MainSearchState createState() => _MainSearchState();
}

class _MainSearchState extends State<MainSearch> {
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  //Textfield now printing keystrokes
  _printLatestValue() {
    print("Text field: ${myController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 40,
      ),
      child: Container(
        padding: EdgeInsets.only(left: 8, right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Container(
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Icon(
                  Icons.search,
                  color: Colors.grey[800],
                  size: 24.0,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: myController,
                      decoration: InputDecoration(
                        hintText: "Enter an address or landmark...",
                        hintStyle: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey[300],
                            fontFamily: 'Roboto'),
                        border: InputBorder.none,
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
