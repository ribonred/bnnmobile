  
import 'package:flutter/material.dart';

class VerticalText extends StatefulWidget {
  @override
  _VerticalTextState createState() => _VerticalTextState();
}

class _VerticalTextState extends State<VerticalText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10),
      child: RotatedBox(
          quarterTurns: -1,
          child: Text(
            'BNN',
            style: TextStyle(
              color: Colors.white,
              fontSize: 45,
              fontWeight: FontWeight.w900,
            ),
          )),
    );
  }
}