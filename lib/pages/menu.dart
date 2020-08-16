import 'package:flutter/material.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import './newuser.page.dart';
import './login.page.dart';
import './main.menu.dart';
import './main.input.dart';
import './main.edit.dart';
import 'activity.page.dart';
import '../widget/getlkn.dart';
import '../services/fcm.dart';



class Dashboard extends StatefulWidget {
  @override
  Navbarbottom createState() => Navbarbottom();
  final String text;
  final int user;
  Dashboard({Key key, @required this.text,@required this.user}) : super(key: key);
}

class Navbarbottom extends State<Dashboard> {

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }

  int _index = 2;
    var _pages = [
      MainMenu(),
      ActivityListView(),
      MainInput(),
      MainEdit(),
  ];

  @override
  void initState() {
    super.initState();
    new FirebaseNotifications().setUpFirebase(widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
        backgroundColor: Colors.grey[200],
        body: Stack(
          children: <Widget>[_pages.elementAt(_index)]
        ),
        bottomNavigationBar:
        FFNavigationBar(
          theme: FFNavigationBarTheme(
            unselectedItemIconColor: Colors.blue[400],
            barBackgroundColor:  Colors.white,
            selectedItemBackgroundColor: Colors.lightBlueAccent,
            selectedItemIconColor: Colors.white,
            selectedItemLabelColor: Colors.black,
          ),
          selectedIndex: _index,
        onSelectTab: (index) {
          setState(() {
            _index = index;
          });
        },
          items: [
            FFNavigationBarItem(
              iconData: Icons.folder_open,
              label: 'DATA',
            ),
            FFNavigationBarItem(
              iconData: Icons.notifications_active,
              label: 'Aktivitas',
            ),
            FFNavigationBarItem(
              iconData: Icons.add_box,
              label: 'Input Data',
            ),
            FFNavigationBarItem(
              iconData: Icons.mode_edit,
              label: 'Edit data',
            ),
          ],
        ),
      )
    );
  }
}