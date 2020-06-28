import 'package:flutter/material.dart';
import '../services/request.dart';

class TskView extends StatefulWidget {
  final data;
  const TskView({Key key,this.data}) : super(key: key);
  @override
  TskViewState createState() => TskViewState();
}

class TskViewState extends State<TskView> {
  @override
  Widget build(context) {
    print(widget.data);
    return Scaffold(
      appBar: AppBar(
        title: Text('TERSANGKA'),
      ),
      body: SingleChildScrollView(
              child: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Card(
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(4.0)),
                      child: Image.network(widget.data['foto']),
                    ),
                    Container(
                      height: 100,
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height:20),
                          Padding(
                            padding: const EdgeInsets.only(top: 0, left:10, right: 0),
                            child: Row(
                              children: <Widget>[
                                Text("Nama : " + "${widget.data['nama_tersangka'].toString()}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                              ]
                            ),
                          ),
                          SizedBox(height:15),
                          Padding(
                            padding: const EdgeInsets.only(top: 0, left:10, right: 0),
                            child: Row(
                              children: <Widget>[
                                Text("jenis kelamin : " + "${widget.data['jenis_kelamin'].toString()}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                Padding(
                                  padding: const EdgeInsets.only(top: 0, left:60, right: 0),
                                  child: Text("umur : " + "${widget.data['umur'].toString()}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                ),
                              ]
                            ),
                          )
                        ]
                      ),
                    ),
                  ],
                )
              ),
              Card(
                child: ExpansionTile(
                  title: Text('Lihat Tersangka'),
                  children: <Widget>[
                    for ( var i in widget.data['statustersangka'] ) Container(
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
                                // leading: CircleAvatar(
                                //   backgroundImage: NetworkImage(i['foto'].toString()), // no matter how big it is, it won't overflow
                                // ),
                                title: Text("Tanggal  :  " + i['tanggal'].toString() + ", Jam  :  " + i['waktu'].toString()),
                                subtitle: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text('Status Penahanan : ', style: TextStyle(fontWeight: FontWeight.bold),),
                                        Text(i['status_penahanan'].toString(), style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text('Rekam Jejak : ', style: TextStyle(fontWeight: FontWeight.bold),),
                                        Text(i['rekam_jejak'].toString(), style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text('Keterangan : ', style: TextStyle(fontWeight: FontWeight.bold),),
                                        Text(i['keterangan'].toString(), style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),),
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
                ),
              ),
              Card(
                child: ExpansionTile(
                  title: Text('Lihat Barang - Bukti'),
                  children: <Widget>[
                    for ( var i in widget.data['barangbuktitersangka'] ) Container(
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
                                // leading: CircleAvatar(
                                //   backgroundImage: NetworkImage(i['foto'].toString()), // no matter how big it is, it won't overflow
                                // ),
                                title: Text("Nama  :  " + i['nama_barang'].toString() + ", Jenis  :  " + i['jenis_barang'].toString()),
                                subtitle: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text('SP Sita : ', style: TextStyle(fontWeight: FontWeight.bold),),
                                        Text(i['sp_sita'].toString(), style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text('Tap Status : ', style: TextStyle(fontWeight: FontWeight.bold),),
                                        Text(i['tap_status'].toString(), style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),),
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
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
