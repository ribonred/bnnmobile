import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import '../services/request.dart';
import '../widget/getlkn.dart';

final List<String> imageList = [
  'assets/images/bnn.jpeg',
  'assets/images/bnn2.jpeg'
];

class Approval extends StatefulWidget{
  
  
  @override
  _ApprovalState createState() => _ApprovalState();
}

class _ApprovalState extends State<Approval>{
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
            child: Image.asset(
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
            crossAxisCount: 4,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget>[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              spreadRadius: 3,
                              blurRadius: 3,
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
                          iconSize: 25,
                          onPressed: () {
                            lkn(null, null).then((response){
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
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              spreadRadius: 3,
                              blurRadius: 3,
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
                          iconSize: 25,
                          onPressed: () {
                            pnkp(null, null).then((response){
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
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              spreadRadius: 3,
                              blurRadius: 3,
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
                          iconSize: 25,
                          onPressed: () {
                            bb(null, null).then((response){
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
                    ),
                    // Container(
                    //    decoration: BoxDecoration(
                    //      boxShadow: [
                    //       BoxShadow(
                    //         color: Colors.grey.withOpacity(0.8),
                    //         spreadRadius: 3,
                    //         blurRadius: 3,
                    //         offset: Offset(0, 0), // changes position of shadow
                    //       ),
                    //     ],
                    //      color: Colors.blue[800],
                    //      borderRadius: BorderRadius.circular(1000),
                    //      border: Border.all(
                    //       color: Colors.blue[800],
                    //       width: 5,
                    //      ),
                    //   ),
                    //   child: new IconButton(icon: new Icon(Icons.business_center),
                    //     color: Colors.white,
                    //     iconSize: 25,
                    //     onPressed: () {
                    //       bb(null, null).then((response){
                    //         if (response['results'] != null){
                    //           setState(() {
                    //           data = response['results'];
                    //            });
                    //           Navigator.push(context, MaterialPageRoute(builder: (context) => GetLkn( data: data, judul:'nama_barang', created:'jenis_barang', title:'BARANG BUKTI')));
                    //         }
                    //       });
                    //     }
                    //   ),
                    // ),
                    SizedBox(height: 15),
                    Text('BB',style: TextStyle(fontWeight: FontWeight.bold)),
                  ]
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget>[
                    Expanded(
                      child:Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              spreadRadius: 3,
                              blurRadius: 3,
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
                          iconSize: 25,
                          onPressed: () {
                            tsk(null, null).then((response){
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
                    ),
                    // Container(
                    //    decoration: BoxDecoration(
                    //      boxShadow: [
                    //       BoxShadow(
                    //         color: Colors.grey.withOpacity(0.8),
                    //         spreadRadius: 3,
                    //         blurRadius: 3,
                    //         offset: Offset(0, 0), // changes position of shadow
                    //       ),
                    //     ],
                    //      color: Colors.blue[800],
                    //      borderRadius: BorderRadius.circular(1000),
                    //      border: Border.all(
                    //       color: Colors.blue[800],
                    //       width: 5,
                    //      ),
                    //   ),
                    //   child: new IconButton(icon: new Icon(Icons.person_pin),
                    //     color: Colors.white,
                    //     iconSize: 25,
                    //     onPressed: () {
                    //       tsk(null, null).then((response){
                    //         if (response['results'] != null){
                    //           setState(() {
                    //           data = response['results'];
                    //            });
                    //           Navigator.push(context, MaterialPageRoute(builder: (context) => GetLkn( data: data, judul:'nama_tersangka', created:'jenis_kelamin', title:'TERSANGKA')));
                    //         }
                    //       });
                    //     }
                    //   ),
                    // ),
                    SizedBox(height: 15),
                    Text('TERSANGKA',style: TextStyle(fontWeight: FontWeight.bold)),
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