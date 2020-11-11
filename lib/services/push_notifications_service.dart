import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsService {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future initialise() async {
    _fcm.configure(
      //when app in foreground
      onMessage: (Map<String, dynamic> message) async {
        var m = message["notification"]["title"];
        print('onMessage: $m');
      },
      //when app completely closed
      onLaunch: (Map<String, dynamic> message) async {
        var m = message["notification"]["title"];
        print('onMessage: $m');
      },
      //when app is in background
      onResume: (Map<String, dynamic> message) async {
        var m = message["notification"]["title"];
        print('onMessage: $m');
      },
    );
  }
}
