import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String title;
  const PageTitle({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16, bottom: 16),
      child: Row(
        children: [
          Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(true),
                    child: Container(
                      padding: EdgeInsets.only(top: 32, left: 16),
                      child: Icon(
                        Icons.chevron_left,
                        color: Colors.black,
                        size: 32,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      this.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24.0,
                          letterSpacing: 2.5,
                          color: Colors.grey[850],
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w800),
                    ),
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: EdgeInsets.only(top: 32, left: 16),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
