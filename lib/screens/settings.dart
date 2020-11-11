import 'package:Convene/models/global.dart';
import 'package:Convene/services/global_service.dart';
import 'package:Convene/widgets/Global/deletion_dialog.dart';
import 'package:Convene/widgets/Global/page_title.dart';
import 'package:Convene/widgets/SettingsScreen/list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final globalService = GlobalService();

  Widget buildListTitle(IconData icon, String title) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon),
              Container(
                margin: EdgeInsets.only(left: 24),
                child: Text(
                  title,
                  style: locationTypeListTitleStyle,
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.grey[400],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            PageTitle(title: "Settings"),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: MediaQuery.of(context).size.height - 140,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildListTitle(Icons.person_outline, "Account"),
                  GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (_) => DeletionDialog("favourites"),
                      barrierDismissible: false,
                    ),
                    child: SettingsListItem(
                      "Clear favourites",
                      false,
                      Icons.remove_circle_outline,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (_) => DeletionDialog("previously searched"),
                      barrierDismissible: false,
                    ),
                    child: SettingsListItem(
                      "Clear previous searches",
                      false,
                      Icons.remove_circle_outline,
                    ),
                  ),
                  buildListTitle(Icons.outlined_flag, "Notifications"),
                  SettingsListItem("Notifications Active", true),
                  buildListTitle(Icons.info_outline, "Legal"),
                  SettingsListItem("Privacy Policy", false),
                  SettingsListItem("Terms & Conditions", false),
                  SettingsListItem("Data providers", false),
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () => showDialog(
                            context: context,
                            builder: (_) => DeletionDialog("account"),
                            barrierDismissible: false,
                          ),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[300],
                                    blurRadius: 12,
                                    offset: Offset(-4, 4),
                                  )
                                ],
                                color: Colors.white),
                            width: 160,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Delete Acount"),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => globalService.signOut(context),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[300],
                                    blurRadius: 12,
                                    offset: Offset(-4, 4),
                                  )
                                ],
                                color: Colors.white),
                            width: 160,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Sign out"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
