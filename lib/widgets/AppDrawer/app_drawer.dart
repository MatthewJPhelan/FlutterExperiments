import 'package:Convene/models/user_details.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

class AppDrawer extends StatefulWidget {
  final UserDetails userDetails;

  const AppDrawer({Key key, this.userDetails}) : super(key: key);
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: Container(
        color: Colors.grey[850],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              leading: _getListItem(
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.userDetails.photoUrl),
                ),
              ),
              title: Text(widget.userDetails.userName),
              onTap: () => print("1"),
            ),
            ListTile(
              leading: _getListItem(Icon(
                FontAwesomeIcons.addressBook,
                color: Colors.white,
              )),
              title: Text("Item 2"),
              onTap: () => print("2"),
            ),
            ListTile(
              leading: _getListItem(
                Icon(
                  FontAwesomeIcons.accusoft,
                  color: Colors.white,
                ),
              ),
              title: Text("Item 3"),
              onTap: () => print("3"),
            ),
          ],
        ),
      ),
    );
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
