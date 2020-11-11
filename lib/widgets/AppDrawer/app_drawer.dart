import 'package:Convene/models/global.dart';
import 'package:Convene/models/user_details.dart';
import 'package:Convene/screens/favourites.dart';
import 'package:Convene/screens/previous_searches.dart';
import 'package:Convene/screens/settings.dart';
import 'package:Convene/services/global_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppDrawer extends StatefulWidget {
  final UserDetails userDetails;

  const AppDrawer({Key key, this.userDetails}) : super(key: key);
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final globalService = GlobalService();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 24,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.grey[850], Colors.grey[500]])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1),
              height: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      border: Border.all(
                        width: 2,
                        color: Colors.white,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage(widget.userDetails.photoUrl),
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.userDetails.userName,
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            fontStyle: FontStyle.italic,
                            color: Colors.white),
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        widget.userDetails.userEmail,
                        style: locationTypeListStyle,
                        overflow: TextOverflow.fade,
                      )
                    ],
                  ),
                  Icon(
                    Icons.blur_on,
                    color: Colors.tealAccent,
                    size: 34,
                  ),
                ],
              ),
            ),
            Container(
              child: Divider(
                color: Colors.white,
                indent: 16,
                endIndent: 16,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 24, left: 24, right: 24),
                    child: ListTile(
                      trailing: _getListItem(Icon(
                        Icons.favorite_border,
                        color: Colors.tealAccent,
                      )),
                      title: Text(
                        "Favourites",
                        style: appDrawerListStyle,
                        overflow: TextOverflow.fade,
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Favourites()),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 24, left: 24, right: 24),
                    child: ListTile(
                      trailing: _getListItem(
                        Icon(
                          FontAwesomeIcons.searchLocation,
                          color: Colors.tealAccent,
                        ),
                      ),
                      title: Text(
                        "Previously Searched",
                        style: appDrawerListStyle,
                        overflow: TextOverflow.fade,
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PreviousSearches()),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 24, left: 24, right: 24),
                    child: ListTile(
                      trailing: _getListItem(
                        Icon(
                          Icons.settings,
                          color: Colors.tealAccent,
                          size: 32,
                        ),
                      ),
                      title: Text(
                        "Settings",
                        style: appDrawerListStyle,
                        overflow: TextOverflow.fade,
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Settings()),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 16),
                  child: GestureDetector(
                    onTap: () => globalService.signOut(context),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 24),
                          child: Icon(
                            Icons.input,
                            size: 20,
                          ),
                        ),
                        Text(
                          "Sign Out",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            color: Colors.grey[850],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _getListItem(dynamic icon) {
    return Container(
      padding: EdgeInsets.all(4),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: icon,
      ),
    );
  }
}
