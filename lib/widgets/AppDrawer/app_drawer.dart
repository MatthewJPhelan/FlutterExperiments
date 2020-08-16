import 'package:Convene/models/global.dart';
import 'package:Convene/models/user_details.dart';
import 'package:Convene/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AppDrawer extends StatefulWidget {
  final UserDetails userDetails;

  const AppDrawer({Key key, this.userDetails}) : super(key: key);
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final GoogleSignIn _gSignIn = GoogleSignIn();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey[850],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 400,
              margin: EdgeInsets.only(top: 16),
              child: ListView(children: [
                Container(
                  margin: EdgeInsets.only(top: 8),
                  child: ListTile(
                    leading: _getListItem(
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(widget.userDetails.photoUrl),
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.userDetails.userName,
                          style: appDrawerListStyle,
                        ),
                        Text(
                          widget.userDetails.userEmail,
                          style: locationTypeListStyle,
                        )
                      ],
                    ),
                    onTap: () => print("1"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  child: ListTile(
                    leading: _getListItem(Icon(
                      FontAwesomeIcons.heart,
                      color: Colors.white,
                    )),
                    title: Text(
                      "Favourites",
                      style: appDrawerListStyle,
                    ),
                    onTap: () => print("Favourites"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  child: ListTile(
                    leading: _getListItem(
                      Icon(
                        FontAwesomeIcons.locationArrow,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      "Previously Searched",
                      style: appDrawerListStyle,
                    ),
                    onTap: () => print("style: appDrawerListStyle,"),
                  ),
                ),
              ]),
            ),
            Column(
              children: [
                Container(
                  width: 280,
                  child: Divider(
                    color: Colors.tealAccent,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 16),
                      width: 240,
                      child: RaisedButton(
                        onPressed: () => _signOut(),
                        child: Text("Sign Out"),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> _signOut() async {
    _gSignIn.signOut();
    FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.deleteAll();
    print("signed out");
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => SplashScreen()));
  }

  Widget _getListItem(dynamic icon) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            width: 2,
            color: Colors.white,
          )),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: icon,
      ),
    );
  }
}
