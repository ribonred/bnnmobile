import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String fullName;
  final String role;

  ProfileCard({this.fullName, this.role});

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[card(context)],
    );
  }

  Widget card(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          SizedBox(height:10.0),
          profilePic(context),
          nameNnumber(),
        ],
      ),
    );
  }

  Widget profilePic(BuildContext context) {
    //double width = MediaQuery.of(context).size.width / 2 - 64.0;
    return Container(
      alignment: Alignment.center,
      child: Icon(
        Icons.account_circle,
        size: 124.0,
        color: Colors.blueAccent,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget nameNnumber() {
    Text name = Text(
      fullName,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.blueAccent,
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
      ),
    );

    Text number = Text(
      role,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.blueAccent,
        fontSize: 18.0,
        fontWeight: FontWeight.w400,
      ),
    );
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        top: 120.0,
      ),
      child: Column(
        children: <Widget>[
          name,
          SizedBox(
            height: 1.0,
          ),
          number
        ],
      ),
    );
  }
}