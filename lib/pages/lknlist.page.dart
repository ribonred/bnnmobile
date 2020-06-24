import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';


class LknListView extends StatefulWidget{
  @override
  _LknListView createState() => _LknListView();
}

class _LknListView extends State <LknListView>{
    var channel = IOWebSocketChannel.connect("ws://178.128.80.233:8000/notifications/");
    
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