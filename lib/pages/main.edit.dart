import 'package:flutter/material.dart';
import '../services/request.dart';

class MainEdit extends StatefulWidget{
  
  
  @override
  _MainEditState createState() => _MainEditState();
}

class _MainEditState extends State<MainEdit>{
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
                title: Text('Edit')
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
                        onPressed: () {
                          lkn(null, null).then((response){
                            if (response['results']){
                              
                            }
                          });
                        }
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
                        onPressed: () {print('Icon tapped.');}
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
                        onPressed: () {print('Icon tapped.');}
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
                        onPressed: () {print('Icon tapped.');}
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
                        onPressed: () {print('Icon tapped.');}
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
                        onPressed: () {print('Icon tapped.');}
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