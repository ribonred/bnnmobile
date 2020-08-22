import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as statusCodes;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:convert';
import '../services/request.dart';


class ActivityListView extends StatefulWidget{
  @override
  _ActivityListView createState() => _ActivityListView();
}

class _ActivityListView extends State <ActivityListView>{
  bool loading = true;
  List activities = [];
  String urlNext = '';
  String urlPrev = '';

  void getActivities() async {
    try {
      final response = await activity(null);
      if(response.statusCode == 200){
        activities = json.decode(response.body)['results'];
        urlNext = json.decode(response.body)['next'];
        setState(() {
          loading = false;
        });
        print('activities: $activities');
      } else {
        setState(() {
          loading = false;
        });
        print("Error getting activity list");
      }
    } catch (e) {
      print(e);
      setState(() {
        loading = false;
      });
      print("Error getting activity list");
    }
  }

  @override
  void initState() {
    getActivities();
    print('activities');
    print(activities.length);
    super.initState();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aktivitas'),
      ),
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                const Color(0xFF3366FF),
                const Color(0xFF00CCFF),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.2),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: ListView.builder(
          itemCount: activities.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min, children: <Widget>[
                    ListTile(
                      title: Text(activities[index]['message'].toString(), style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                      subtitle: Column(children: <Widget>[
                        Row(children: <Widget>[
                          Text('di buat : ', style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(activities[index]['created'].toString(), style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12.0),),
                        ],)
                      ],)
                    ),
                    ButtonTheme.bar(
                      child: ButtonBar(
                        children: <Widget>[
                          // BUTTON PERTAMA
                          FlatButton(
                            //DENGAN TEXT DENGARKAN
                            child: const Text('MARK AS READ'),
                            onPressed: () async { 
                              final isRead = await activity(activities[index]['id'].toString());
                              if (isRead.statusCode == 200){
                                activities.removeWhere((item) => item['id'] == activities[index]['id']);
                                activities.join(', ');
                                setState(() {
                                  activities = activities;
                                });
                              } else {
                                print("error on mark as read");
                                print(isRead);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ]
                ),
              )
            );
          },
        )
      ),
      bottomNavigationBar: Material(
        color: Colors.blue,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: RaisedButton(
                  onPressed: urlPrev == null || urlPrev == '' ? null : () async {
                    final newData = await loadData(urlPrev);
                    print('url prev');
                    print(urlPrev);
                    setState(() {
                      activities = newData['results'];
                      urlNext = newData['next'];
                      urlPrev = newData['previous'];
                    });
                  },
                  color: Colors.white,
                  textColor: Colors.blue,
                  disabledColor: Colors.grey,
                  child: Text('Prev'),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: RaisedButton(
                  onPressed: urlNext == null || urlNext == '' ? null : () async {
                    final newData = await loadData(urlNext);
                    print('url next');
                    print(urlNext);
                    setState(() {
                      activities = newData['results'];
                      urlNext = newData['next'];
                      urlPrev = newData['previous'];
                    });
                  },
                  color: Colors.white,
                  textColor: Colors.lightBlue,
                  disabledColor: Colors.grey,
                  child: Text('Next'),
                ),
              )
            ],
          )
        ),
      )
    );
  }
}