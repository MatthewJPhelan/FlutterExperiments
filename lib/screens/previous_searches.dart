import 'package:Convene/models/global.dart';
import 'package:Convene/widgets/Global/page_title.dart';
import 'package:Convene/widgets/PreviouslySearched/previously_searched_cards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PreviousSearches extends StatefulWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  _PreviousSearchesState createState() => _PreviousSearchesState();
}

class _PreviousSearchesState extends State<PreviousSearches> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            PageTitle(title: "Previous Searches"),
            SizedBox(
              height: MediaQuery.of(context).size.height - 100,
              child: StreamBuilder(
                stream: widget._firestore
                    .collection('users')
                    .doc(widget._auth.currentUser.uid)
                    .collection('searched')
                    .orderBy("datesearched", descending: true)
                    .limit(5)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.data.size == 0) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Crickets...",
                              textAlign: TextAlign.center,
                              style: locationTypeListTitleStyle,
                            ),
                            Text(
                              "No previous searches yet.",
                              textAlign: TextAlign.center,
                              style: restaurantOverviewSubTitleStyle,
                            ),
                          ],
                        ),
                      );
                    }
                    return ListView(
                      scrollDirection: Axis.vertical,
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        var data = document.data();
                        return PreviouslySearchedCard(data);
                      }).toList(),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
