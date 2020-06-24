import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import '../services/request.dart';
import '../widget/getlkn.dart';

final List<String> imageList = [
  "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
  "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/19/10/55/christmas-market-4705877_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg",
  "https://cdn.pixabay.com/photo/2016/11/22/07/09/spruce-1848543__340.jpg"
];

class MainMenu extends StatefulWidget{
  
  
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu>{
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
                title: Text('Menu')
                ,),
              SizedBox(height: 30),
          GFCarousel(
            viewportFraction: 1.0,
    items: imageList.map(
     (url) {
     return Container(
         margin: EdgeInsets.only(top: 1.0, bottom: 1.0, right: 1.0, left: 1.0),
         child: ClipRRect(
           borderRadius: BorderRadius.all(Radius.circular(20.0)),
            child: Image.network(
               url,
               fit: BoxFit.cover,
                width: 1000.0,
             ),
          ),
        );
        },
     ).toList(),
    onPageChanged: (index) {
        setState(() {
          
        });
    },
 ),

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
                          width: 5,
                         ),
                      ),
                      child: new IconButton(icon: new Icon(Icons.assignment),
                        color: Colors.white,
                        iconSize: 40,
                        onPressed: () {
                          lkn(null).then((response){
                            if (response['results'] != null){
                              setState(() {
                              data = response['results'];
                               });
                              Navigator.push(context, MaterialPageRoute(builder: (context) => GetLkn( data: data, judul:'LKN',created:'created', title:'LKN')));
                            }
                          });
                        }
                      )
                    ),
                    SizedBox(height: 15),
                    Text('LKN',style: TextStyle(fontWeight: FontWeight.bold),),
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
                          width: 5,
                         ),
                      ),
                      child: new IconButton(icon: new Icon(Icons.search),
                        color: Colors.white,
                        iconSize: 40,
                        onPressed: () {
                          pnkp(null).then((response){
                            if (response['results'] != null){
                              setState(() {
                              data = response['results'];
                               });
                              Navigator.push(context, MaterialPageRoute(builder: (context) => GetLkn( data: data, judul:'no_penangkapan', created:'tanggal_penangkapan', title:'PENANGKAPAN')));
                            }
                          });
                        }
                      ),
                    ),
                    SizedBox(height: 15),
                    Text('SP KAP',style: TextStyle(fontWeight: FontWeight.bold),),
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
                          width: 5,
                         ),
                      ),
                      child: new IconButton(icon: new Icon(Icons.business_center),
                        color: Colors.white,
                        iconSize: 40,
                        onPressed: () {
                          bb('').then((response){
                            if (response['results'] != null){
                              setState(() {
                              data = response['results'];
                               });
                              Navigator.push(context, MaterialPageRoute(builder: (context) => GetLkn( data: data, judul:'nama_barang', created:'jenis_barang', title:'BARANG BUKTI')));
                            }
                          });
                        }
                      ),
                    ),
                    SizedBox(height: 15),
                    Text('BB',style: TextStyle(fontWeight: FontWeight.bold)),
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
                          width: 5,
                         ),
                      ),
                      child: new IconButton(icon: new Icon(Icons.person_pin),
                        color: Colors.white,
                        iconSize: 40,
                        onPressed: () {
                          tsk('').then((response){
                            if (response['results'] != null){
                              setState(() {
                              data = response['results'];
                               });
                              Navigator.push(context, MaterialPageRoute(builder: (context) => GetLkn( data: data, judul:'nama_tersangka', created:'jenis_kelamin', title:'TERSANGKA')));
                            }
                          });
                        }
                      ),
                    ),
                    SizedBox(height: 15),
                    Text('TERSANGKA',style: TextStyle(fontWeight: FontWeight.bold)),
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
                          width: 5,
                         ),
                      ),
                      child: new IconButton(icon: new Icon(Icons.account_balance),
                        color: Colors.white,
                        iconSize: 40,
                        onPressed: () {
                          tskProses('').then((response){
                            if (response != null){
                              setState(() {
                              data = response;
                               });
                              Navigator.push(context, MaterialPageRoute(builder: (context) => GetLkn( data: data, judul:'proses_tersangka', created:'jenis_proses', title:'PROSES TERSANGKA')));
                            }
                          });
                        }
                      ),
                    ),
                    SizedBox(height: 15),
                    Text('PROSES',style: TextStyle(fontWeight: FontWeight.bold)),
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
                          width: 5,
                         ),
                      ),
                      child: new IconButton(icon: new Icon(Icons.swap_horiz),
                        color: Colors.white,
                        iconSize: 40,
                        onPressed: () {
                          bbStatus('').then((response){
                            if (response != null){
                              setState(() {
                              data = response;
                               });
                              Navigator.push(context, MaterialPageRoute(builder: (context) => GetLkn( data: data, judul:'status', created:'tanggal_status', title:'STATUS BB')));
                            }
                          });
                        }
                      ),
                    ),
                    SizedBox(height: 15),
                    Text('STATUS',style: TextStyle(fontWeight: FontWeight.bold)),
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