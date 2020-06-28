import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as statusCodes;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:convert';


class LknListView extends StatefulWidget{
  @override
  _LknListView createState() => _LknListView();
}

class _LknListView extends State <LknListView>{
  WebSocketChannel channels = WebSocketChannel.connect(Uri.parse("ws://178.128.80.233:8000/notifications/"));
   var channel = IOWebSocketChannel.connect("ws://178.128.80.233:8000/notifications/");
  var sub;
  String text;
  @override
    void initState() {
    super.initState();
   FlutterLocalNotificationsPlugin notifications = FlutterLocalNotificationsPlugin();
    var iOSInit = IOSInitializationSettings();
    var androidInit = AndroidInitializationSettings('app_icon');
    var init = InitializationSettings(androidInit, iOSInit);
    notifications.initialize(init).then((done) {
      sub = channels.stream.listen((newData) {
        setState(() {
          text = newData;
        });

        var messagess= jsonDecode(text);
        notifications.show(
            0,
            "Notifikasi Baru",
            messagess['message'],
            NotificationDetails(
                AndroidNotificationDetails(
                    "announcement_app_0",
                    "Announcement App",
                    ""
                ),
                IOSNotificationDetails()
            )
        );
      });
    });
    }
    @override
   void dispose() {
     super.dispose();
     channels.sink.close(statusCodes.goingAway);
     sub.cancel();
   }
    @override
    Widget build(BuildContext context){
      return Scaffold(
        
        body: StreamBuilder(
              stream: channel.stream,
              builder: (context, snapshot) {
                var message;
                if (snapshot.hasData){
                  var content = json.decode(snapshot.data);
                    message = content['message'];
            
                }
                return Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(snapshot.hasData ? '$message':''),
                );
        }),
      );
      
    }


  }