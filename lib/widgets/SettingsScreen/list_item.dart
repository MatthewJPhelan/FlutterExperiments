import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsListItem extends StatefulWidget {
  final String title;
  final bool control;
  final IconData icon;
  @override
  _SettingsListItemState createState() => _SettingsListItemState();

  SettingsListItem(this.title, this.control, [this.icon]);
}

void _setPrefs(bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("notificationsActive", value);
}

Future<bool> _getPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.containsKey("notificationsActive")) {
    return prefs.getBool("notificationsActive");
  } else {
    prefs.setBool("notificationsActive", true);
    return true;
  }
}

class _SettingsListItemState extends State<SettingsListItem> {
  bool isSwitched = false;

  Widget buildListItem(String title, bool control, [IconData icon]) {
    IconData iconData = icon != null ? icon : Icons.chevron_right;
    if (control == true) {
      print("insert control");
      return Container(
        margin: EdgeInsets.only(top: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            FutureBuilder<bool>(
              future: _getPrefs(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  isSwitched = snapshot.data;
                  return Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                      _setPrefs(isSwitched);
                    },
                    activeTrackColor: Colors.teal[50],
                    activeColor: Colors.tealAccent,
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(title), Icon(iconData)],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildListItem(widget.title, widget.control, widget.icon);
  }
}
