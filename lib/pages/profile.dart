import 'package:flutter/material.dart';
import '../widget/profileCard.dart';
import '../services/request.dart';
import '../pages/login.page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/fcm.dart';

class ProfileView extends StatefulWidget {
  final data;
  const ProfileView({Key key,this.data}) : super(key: key);
  @override
  ProfileViewState createState() => ProfileViewState();
}

class ProfileViewState extends State<ProfileView> {
  List role = ['super admin', 'penyidik', 'manager'];
  @override
  Widget build(context) {
    print(widget.data['username']);
    print(widget.data['role']);
    print(role[widget.data['role']]);
    // print(widget.data);
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Profile Page",
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        body: Scaffold(
          body: Column(
            children: <Widget>[
               Padding(
                padding: EdgeInsets.all(8.0),
              ),
              ProfileCard(
                fullName: widget.data['username'].toString(),
                role: role[widget.data['role']].toString(),
              ),
               RaisedButton(
                child: Text('Logout'),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () async {
                  final storage = new FlutterSecureStorage();
                  await storage.delete(key: 'token');
                  String token = await storage.read(key: 'token');
                  print('token');
                  print(token);
                  new FirebaseNotifications().unsubscribe_Topic(widget.data['role']);
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);
                  //do logout
                },
              ),
            ],
          ),
        ),
      );
   }
}