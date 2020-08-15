import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';




class FirebaseNotifications {
  FirebaseMessaging _firebaseMessaging;

  void setUpFirebase(user) {
    _firebaseMessaging = FirebaseMessaging();
    firebaseCloudMessaging_Listeners(user);
    
  }

  void firebaseCloudMessaging_Listeners(user) {
    if (Platform.isIOS) iOS_Permission();
    subscribe_Topic(user);
    _firebaseMessaging.getToken().then((token) {
      print("token fcm: $token");
    });
    
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
    FlutterLocalNotificationsPlugin notifications = FlutterLocalNotificationsPlugin();
    notifications.show(
            1,
            message['notification']['title'],
            message['notification']['body'],
            NotificationDetails(
                AndroidNotificationDetails(
                    "announcement_app_0",
                    "Announcement App",
                    ""
                ),
                IOSNotificationDetails()
            )
        );
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  void subscribe_Topic(user){
    if (user == 2){
      _firebaseMessaging.subscribeToTopic("moderator");
    }else{
      _firebaseMessaging.subscribeToTopic("regular");
    }
    
  }
}