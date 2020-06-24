import 'package:flutter/material.dart';
//IMPORT PACKAGE UNTUK HTTP REQUEST DAN ASYNCHRONOUS
import 'dart:async'; 
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../services/request.dart';
import '../pages/pnkp.view.dart';

class LknView extends StatefulWidget {
  final data;
  const LknView({Key key,this.data}) : super(key: key);
  @override
  LknViewState createState() => LknViewState();
}

class LknViewState extends State<LknView> {
  var dataPnkp;
  var dataTsk;
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LKN'),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min, 
                children: <Widget>[
                  ListTile(
                    // title: Text(widget.data['LKN'].toString(), style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
                    subtitle: Column(children: <Widget>[
                      Row(children: <Widget>[
                        Text('No LKN : ', style: TextStyle(fontWeight: FontWeight.bold),),
                        Text(widget.data['LKN'].toString(), style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),),
                      ],),
                      Row(children: <Widget>[
                        Text('Tanggal dibuat : ', style: TextStyle(fontWeight: FontWeight.bold),),
                        Text(widget.data['tgl_dibuat'].toString(), style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),),
                      ],)
                    ],)
                  )
                ],
              )
            ),
            ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.data['penangkapan'] == null ? 0:widget.data['penangkapan'].length, //KETIKA DATANYA KOSONG KITA ISI DENGAN 0 DAN APABILA ADA MAKA KITA COUNT JUMLAH DATA YANG ADA
              itemBuilder: (BuildContext context, int index) {
                return Container (
                  child: GestureDetector(
                    onTap: () {
                      print(widget.data['penangkapan'][index]['id']);
                      pnkp(widget.data['penangkapan'][index]['id']).then((response){
                        if (response != null){
                          setState(() {
                          dataPnkp = response;
                            });
                          print(dataPnkp);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PnkpView( data: dataPnkp)));
                        }
                      });
                      // print('enaak');
                    },
                    child: Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min, children: <Widget>[
                          ListTile(
                            title: Text(widget.data['penangkapan'][index]['no_penangkapan'].toString(), style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
                            subtitle: Column(children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text('Tanggal Mulai Penangkapan : ', style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(widget.data['penangkapan'][index]['tanggal_penangkapan'].toString(), style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('Tanggal Berakhir Penangkapan : ', style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(widget.data['penangkapan'][index]['masa_berakhir_penangkapan'].toString(), style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),),
                              ],
                            ),
                          ],),
                          ),
                          ExpansionTile(
                            title: Text('Lihat Tersangka'),
                            children: <Widget>[
                              for ( var i in widget.data['penangkapan'][index]['penangkapan_tersangka'] ) Container(
                                child: GestureDetector(
                                  onTap: () {
                                    print(i['id']);
                                    // print('enaak');
                                  },
                                  child: new Card(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                          leading: CircleAvatar(
                                            backgroundImage: NetworkImage(i['foto'].toString()), // no matter how big it is, it won't overflow
                                          ),
                                          title: Text(i['nama_tersangka'].toString()),
                                          subtitle: Column(
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Text('Jenis Kelamin : ', style: TextStyle(fontWeight: FontWeight.bold),),
                                                  Text(i['jenis_kelamin'].toString(), style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Text('Umur : ', style: TextStyle(fontWeight: FontWeight.bold),),
                                                  Text(i['umur'].toString(), style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),),
                                                ],
                                              ),
                                            ]
                                          ),
                                        ),
                                      ],
                                    )
                                  ),
                                ),
                              )
                            ],
                          )
                        ]
                      ),
                    ),
                  )
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}