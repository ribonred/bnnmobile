import 'package:flutter/material.dart';
import '../widget/first.dart';
import '../widget/forgot.dart';
import '../widget/textLogin.dart';
import '../widget/verticalText.dart';
import '../pages/menu.dart';
import '../services/request.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final String url = 'http://178.128.80.233:8000/get-token/token-auth/';
  final _usernamecontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();

   showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('ALERT'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('username and password not match')
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Dismiss'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


  // authenticate() async {
  //   http.post(url, headers: {
  //     'Accept': 'application/json'
  //   }, body: {
  //     "username": _usernamecontroller.text,
  //     "password": _passwordcontroller.text
  //   }).then((response) async {
  //     print(response.statusCode);
  //     if (response.statusCode == 200){
  //       var content = json.decode(response.body);
  //       await storage.write(key: 'token', value: content['token']);
  //       Navigator.push(context,
  //                   MaterialPageRoute(builder: (context) => Dashboard()));
  //     } else {
  //       showMyDialog();
  //     }
  //   }
  //   );}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.lightBlueAccent]),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(children: <Widget>[
                  VerticalText(),
                  TextLogin(),
                ]),
                Padding(
      padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          controller: _usernamecontroller,
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.lightBlueAccent,
            labelText: 'Username',
            labelStyle: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ),
      
    ),
               Padding(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          controller: _passwordcontroller,
          style: TextStyle(
            color: Colors.white,
          ),
          obscureText: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: 'Password',
            labelStyle: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ),
    ),
                Padding(
      padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
      child: Container(
        alignment: Alignment.centerRight,
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.blue[300],
              blurRadius: 10.0, // has the effect of softening the shadow
              spreadRadius: 1.0, // has the effect of extending the shadow
              offset: Offset(
                5.0, // horizontal, move right 10
                5.0, // vertical, move down 10
              ),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: FlatButton(
          onPressed: () {
              login(_usernamecontroller.text,_passwordcontroller.text).then((response){
                print('response');
                print(response);
                if(response){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
                } else {
                  showMyDialog();
                }
              });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'LOGIN',
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: Colors.lightBlueAccent,
              ),
            ],
          ),
        ),
      ),
    ),
                Forgot(),
                FirstTime(),
                
              ],
            ),
          ],
        ),
      ),
    );
  }


}