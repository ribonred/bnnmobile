import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import '../widget/inputForm/lknForm.dart';
import '../widget/inputForm/spkapForm.dart';
import '../widget/inputForm/bbForm.dart';
import '../widget/inputForm/tersangkaForm.dart';
import '../widget/inputForm/prosesTersangkaForm.dart';
import '../widget/inputForm/statusTersangkaForm.dart';

class MainInput extends StatefulWidget{
  
  
  @override
  _MainInputState createState() => _MainInputState();
}

class _MainInputState extends State<MainInput>{
   @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: 
      Container(
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
        child: ListView(
          children:<Widget>[
            Column(children: <Widget>[
              AppBar(
                title: Text('Input Data')
                ,),
          Container(
          height:600,
          child: CustomScrollView(
          slivers:<Widget>[
            SliverList(
          delegate: SliverChildListDelegate([
          GridView.count(
            padding: const EdgeInsets.only(top: 50, right: 5, left: 5),
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget>[
                    Container(
                       decoration: BoxDecoration(
                         boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                         color: Colors.blue[800],
                         borderRadius: BorderRadius.circular(1000),
                         border: Border.all(
                          color: Colors.blue[800],
                          width: 10,
                         ),
                      ),
                      child: new IconButton(icon: new Icon(Icons.assignment),
                        color: Colors.white,
                        iconSize: 40,
                        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => LKNForm()));}
                      )
                    ),
                    SizedBox(height: 15),
                    Text('LKN'),
                  ]
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget>[
                    Container(
                       decoration: BoxDecoration(
                         boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                         color: Colors.blue[800],
                         borderRadius: BorderRadius.circular(1000),
                         border: Border.all(
                          color: Colors.blue[800],
                          width: 10,
                         ),
                      ),
                      child: new IconButton(icon: new Icon(Icons.search),
                        color: Colors.white,
                        iconSize: 40,
                        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => spkapForm()));}
                      )
                    ),
                    SizedBox(height: 15),
                    Text('SP KAP'),
                  ]
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget>[
                    Container(
                       decoration: BoxDecoration(
                         boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                         color: Colors.blue[800],
                         borderRadius: BorderRadius.circular(1000),
                         border: Border.all(
                          color: Colors.blue[800],
                          width: 10,
                         ),
                      ),
                      child: new IconButton(icon: new Icon(Icons.business_center),
                        color: Colors.white,
                        iconSize: 40,
                        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => bbForm()));}
                      ),
                    ),
                    SizedBox(height: 15),
                    Text('BB'),
                  ]
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget>[
                    Container(
                       decoration: BoxDecoration(
                         boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                         color: Colors.blue[800],
                         borderRadius: BorderRadius.circular(1000),
                         border: Border.all(
                          color: Colors.blue[800],
                          width: 10,
                         ),
                      ),
                      child: new IconButton(icon: new Icon(Icons.person_pin),
                        color: Colors.white,
                        iconSize: 40,
                        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => tersangkaForm()));}
                      ),
                    ),
                    SizedBox(height: 15),
                    Text('TERSANGKA'),
                  ]
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget>[
                    Container(
                       decoration: BoxDecoration(
                         boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                         color: Colors.blue[800],
                         borderRadius: BorderRadius.circular(1000),
                         border: Border.all(
                          color: Colors.blue[800],
                          width: 10,
                         ),
                      ),
                      child: new IconButton(icon: new Icon(Icons.account_balance),
                        color: Colors.white,
                        iconSize: 40,
                        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => prosesTersangkaForm()));}
                      ),
                    ),
                    SizedBox(height: 15),
                    Text('PROSES'),
                  ]
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget>[
                    Container(
                       decoration: BoxDecoration(
                         boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                         color: Colors.blue[800],
                         borderRadius: BorderRadius.circular(1000),
                         border: Border.all(
                          color: Colors.blue[800],
                          width: 10,
                         ),
                      ),
                      child: new IconButton(icon: new Icon(Icons.swap_horiz),
                        color: Colors.white,
                        iconSize: 40,
                        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => statusTersangkaForm()));}
                      ),
                    ),
                    SizedBox(height: 15),
                    Text('STATUS'),
                  ]
                ),
              ),
            ],
          )  
        ])
        ),
          ]
        ),

        )
            ],)
            
        
          ]
          
        
        ),
      )
      );
    
  }
}