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
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 32,
        ),
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
        ),
        child: Container(
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  Icons.search,
                  color: Colors.grey[700],
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
                        hintText: "Where would you like to go?",
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
