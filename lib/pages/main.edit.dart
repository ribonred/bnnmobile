import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import '../widget/editForm/lknForm.dart';
import '../widget/editForm/spkapForm.dart';
import '../widget/editForm/bbForm.dart';
import '../widget/editForm/tersangkaForm.dart';
import '../widget/editForm/prosesTersangkaForm.dart';
import '../widget/editForm/statusTersangkaForm.dart';
import '../widget/editForm/statusBbForm.dart';
import '../services/request.dart';

class MainEdit extends StatefulWidget{
  @override
  _MainEditState createState() => _MainEditState();
}

class _MainEditState extends State<MainEdit>{
  var data;
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
                title: Text('Edit Data')
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
            crossAxisCount: 3,
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
                        onPressed: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => spkapForm()));

                          // data = await lknList();
                          // if (data.length>0) {
                          //   print("data lebih dr 0");
                          //   Navigator.push(context, MaterialPageRoute(builder: (context) => spkapForm(data: data)));
                          // } else {
                          //   print("data 0");
                          // }
                        }
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
                          width: 6,
                         ),
                      ),
                      child: new IconButton(icon: new Icon(Icons.business_center),
                        color: Colors.white,
                        iconSize: 40,
                        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => bbForm()));}
                      ),
                    ),
                    SizedBox(height: 10),
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
                    Text('PROSES TSK'),
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
                    Text('STATUS TSK'),
                  ]
                ),
              ),
              // Container(
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children:<Widget>[
              //       Container(
              //          decoration: BoxDecoration(
              //            boxShadow: [
              //             BoxShadow(
              //               color: Colors.grey.withOpacity(0.8),
              //               spreadRadius: 3,
              //               blurRadius: 5,
              //               offset: Offset(0, 0), // changes position of shadow
              //             ),
              //           ],
              //            color: Colors.blue[800],
              //            borderRadius: BorderRadius.circular(1000),
              //            border: Border.all(
              //             color: Colors.blue[800],
              //             width: 10,
              //            ),
              //         ),
              //         child: new IconButton(icon: new Icon(Icons.swap_horiz),
              //           color: Colors.white,
              //           iconSize: 40,
              //           onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => statusBbForm()));}
              //         ),
              //       ),
              //       SizedBox(height: 15),
              //       Text('STATUS BB'),
              //     ]
              //   ),
              // ),
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