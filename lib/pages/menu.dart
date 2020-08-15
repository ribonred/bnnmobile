import 'package:flutter/material.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import './newuser.page.dart';
import './login.page.dart';
import './main.menu.dart';
import './main.input.dart';
import './main.edit.dart';
import './lknlist.page.dart';
import '../widget/getlkn.dart';
import '../services/fcm.dart';



class Dashboard extends StatefulWidget {
  @override
  Navbarbottom createState() => Navbarbottom();
  final String text;
  Dashboard({Key key, @required this.text}) : super(key: key);
}

class Navbarbottom extends State<Dashboard> {
  int _index = 2;
    var _pages = [
      MainMenu(),
      LknListView(),
      MainInput(),
      MainEdit(),
  ];
    @override
  void initState() {
    super.initState();
    new FirebaseNotifications().setUpFirebase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          );
  }
}