import 'package:flutter/material.dart';

GlobalKey<_InputEmailState> globalKey = GlobalKey();

class InputEmail extends StatefulWidget {
  const InputEmail ({Key key}) : super(key: key);
  @override
  _InputEmailState createState() => _InputEmailState();
  
}
class _InputEmailState extends State<InputEmail> {
  
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          controller: controller,
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
      
    );
  }
 
  
}

