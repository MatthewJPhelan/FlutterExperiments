import 'package:Convene/models/provider_details.dart';
import 'package:Convene/models/restaurant.dart';
import 'package:Convene/models/user_details.dart';
import 'package:Convene/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LogInPage extends StatefulWidget {
  final List<Restaurant> restaurants;
  final LatLng intialLocation;

  const LogInPage({this.restaurants, this.intialLocation});

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  final storage = new FlutterSecureStorage();

  Future<User> _signIn(BuildContext context) async {
    Scaffold.of(context).showSnackBar(
      new SnackBar(
        content: new Text('Sign in'),
      ),
    );

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    UserCredential userDetails =
        await _firebaseAuth.signInWithCredential(credential);
    ProviderDetails providerDetails =
        new ProviderDetails(userDetails.user.providerData.first.uid);

    List<ProviderDetails> providerData = new List<ProviderDetails>();
    providerData.add(providerDetails);

    UserDetails details = new UserDetails(
        userDetails.user.providerData.first.uid,
        userDetails.user.displayName,
        userDetails.user.photoURL,
        userDetails.user.email,
        providerData);

    await storage.write(
        key: "providerId", value: userDetails.user.providerData.first.uid);
    await storage.write(
        key: "displayName", value: userDetails.user.displayName);
    await storage.write(key: "photoUrl", value: userDetails.user.photoURL);
    await storage.write(key: "email", value: userDetails.user.email);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          restaurants: widget.restaurants,
          intialLocation: widget.intialLocation,
          userDetails: details,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'assets/images/walkingTogether.jpg',
                fit: BoxFit.cover,
                color: Color.fromRGBO(255, 255, 255, 0.6),
                colorBlendMode: BlendMode.modulate,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Container(
                  width: 250,
                  child: Align(
                    alignment: Alignment.center,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        color: Color(0xffffffff),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              FontAwesomeIcons.google,
                              color: Colors.grey[850],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Sign in with Google',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ],
                        ),
                        onPressed: () => _signIn(context)
                            .then((User user) => print(user))
                            .catchError((e) => print(e))),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
