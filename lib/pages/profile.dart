import 'package:flutter/material.dart';
import '../widget/profileCard.dart';

class ProfileView extends StatefulWidget {
  final data;
  const ProfileView({Key key,this.data}) : super(key: key);
  @override
  ProfileViewState createState() => ProfileViewState();
}

class ProfileViewState extends State<ProfileView> {
  @override
  Widget build(context) {
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
                fullName: "Agam",
                role: "Admin",
              ),
               RaisedButton(
                child: Text('Logout'),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () async {
                  //do logout
                },
              ),
            ],
          ),
        ),
      );
   }
}