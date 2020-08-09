import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/home_page.dart';
import 'dart:async';

import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _mockCheckForSession().then((status) {
      // ignore: todo
      //TODO: if true navigate to home page, else login page
      if (status) {
        _navigateToHome();
      }
    });
  }

  Future<bool> _mockCheckForSession() async {
    //N.B. This is just a mock of a AJAX/API call
    // ignore: todo
    //TODO: Check for User Session - If logged in return true else return false.
    await Future.delayed(Duration(milliseconds: 3000), () {});
    return true;
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: <Widget>[
            Expanded(
              child: splashImage(),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Shimmer.fromColors(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.clear_all,
                        color: Colors.tealAccent,
                        size: 40.0,
                      ),
                    ),
                    baseColor: Theme.of(context).accentColor,
                    highlightColor: Colors.white,
                  ),
                  Text(
                    'CONVENE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontFamily: 'MuseoModerno',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  FittedBox splashImage() {
    return FittedBox(
      child: Opacity(
        opacity: 0.9,
        child: Image.asset('assets/images/walkingTogether.jpg'),
      ),
      fit: BoxFit.cover,
    );
  }
}
