import 'package:flutter/material.dart';
//IMPORT PACKAGE UNTUK HTTP REQUEST DAN ASYNCHRONOUS
import 'dart:async'; 
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../services/request.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

class PnkpView extends StatefulWidget {
  final data;
  const PnkpView({Key key,this.data}) : super(key: key);
  @override
  PnkpViewState createState() => PnkpViewState();
}

class PnkpViewState extends State<PnkpView> {
  List<Map<String, dynamic>> files=[] ;
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PENANGKAPAN'),
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
                        Text('No Penangkapan : ', style: TextStyle(fontWeight: FontWeight.bold),),
                        Text(widget.data['no_penangkapan'].toString(), style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),),
                      ],),
                      Row(children: <Widget>[
                        Text('Tanggal Mulai Penangkapan : ', style: TextStyle(fontWeight: FontWeight.bold),),
                        Text(widget.data['tanggal_penangkapan'].toString(), style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),),
                      ],),
                      Row(children: <Widget>[
                        Text('Tanggal Berakhir Penangkapan : ', style: TextStyle(fontWeight: FontWeight.bold),),
                        Text(widget.data['masa_berakhir_penangkapan'].toString(), style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),),
                      ],),
                      Row(children: <Widget>[
                        Text('SP Jangkap : ', style: TextStyle(fontWeight: FontWeight.bold),),
                        Text(widget.data['sp_jangkap'].toString(), style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),),
                      ],),
                      Row(children: <Widget>[
                        Text('Tanggal Mulai SP Jangkap : ', style: TextStyle(fontWeight: FontWeight.bold),),
                        Text(widget.data['tanggal_sp_jangkap'].toString(), style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),),
                      ],),
                      Row(children: <Widget>[
                        Text('Tanggal Berakhir SP Jangkap : ', style: TextStyle(fontWeight: FontWeight.bold),),
                        Text(widget.data['masa_berakhir_sp_jangkap'].toString(), style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),),
                      ],),
                    ],)
                  )
                ],
              )
            ),
            RaisedButton(
              child: Text("Download Berkas"),
              onPressed: () {
                if (widget.data['dokumen_penangkapan'] != null) {
                  files.add({'title':'dokumen penangkapan', 'url':widget.data['dokumen_penangkapan']});
                }
                if (widget.data['dokumen_sp_jangkap'] != null) {
                  files.add({'title':'dokumen sp jangkap', 'url':widget.data['dokumen_sp_jangkap']});
                }
                print(files);
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                      elevation: 16,
                      child: Container(
                        height: 400.0,
                        width: 360.0,
                        child: ListView(
                          children: <Widget>[
                            SizedBox(height: 20),
                            Center(
                              child: Text(
                                "Berkas Siap Download",
                                style: TextStyle(fontSize: 24, color: Colors.blue, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 20),
                            for (var i in files) RaisedButton(
                              child: Text(i['title'].toString()),
                              onPressed: () async {
                                //Insert event to be fired up when button is clicked here
                                //in this case, this increments our `countValue` variable by one.
                                print(i['url']);
                                final status = await Permission.storage.request();

                                if(status.isGranted){

                                  final externalDir = await getExternalStorageDirectory();

                                  final id = FlutterDownloader.enqueue(
                                    url: "https://firebasestorage.googleapis.com/v0/b/storage-3cff8.appspot.com/o/2020-05-29%2007-18-34.mp4?alt=media&token=841fffde-2b83-430c-87c3-2d2fd658fd41", 
                                    savedDir: externalDir.path,
                                    fileName: "download",
                                    showNotification: true,
                                    openFileFromNotification: true,
                                  );


                                }else{
                                  print("permission denied");
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            ),
            // ListView.builder(
            //   physics: ScrollPhysics(),
            //   shrinkWrap: true,
            //   itemCount: widget.data['penangkapan'] == null ? 0:widget.data['penangkapan'].length, //KETIKA DATANYA KOSONG KITA ISI DENGAN 0 DAN APABILA ADA MAKA KITA COUNT JUMLAH DATA YANG ADA
            //   itemBuilder: (BuildContext context, int index) {
            //     return Container (
            //       child: GestureDetector(
            //         onTap: () {
            //           print(widget.data['penangkapan'][index]['id']);
            //           // print('enaak');
            //         },
            //         child: Card(
            //           child: Column(
            //             mainAxisSize: MainAxisSize.min, children: <Widget>[
            //               ListTile(
            //                 title: Text(widget.data['penangkapan'][index]['no_penangkapan'].toString(), style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
            //                 subtitle: Column(children: <Widget>[
            //                 Row(
            //                   children: <Widget>[
            //                     Text('Tanggal Mulai Penangkapan : ', style: TextStyle(fontWeight: FontWeight.bold),),
            //                     Text(widget.data['penangkapan'][index]['tanggal_penangkapan'].toString(), style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),),
            //                   ],
            //                 ),
            //                 Row(
            //                   children: <Widget>[
            //                     Text('Tanggal Berakhir Penangkapan : ', style: TextStyle(fontWeight: FontWeight.bold),),
            //                     Text(widget.data['penangkapan'][index]['masa_berakhir_penangkapan'].toString(), style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),),
            //                   ],
            //                 ),
            //               ],),
            //               ),
            //               ExpansionTile(
            //                 title: Text('Lihat Tersangka'),
            //                 children: <Widget>[
            //                   for ( var i in widget.data['penangkapan'][index]['penangkapan_tersangka'] ) Container(
            //                     child: GestureDetector(
            //                       onTap: () {
            //                         print(i['id']);
            //                         // print('enaak');
            //                       },
            //                       child: new Card(
            //                         child: Column(
            //                           mainAxisSize: MainAxisSize.min,
            //                           children: <Widget>[
            //                             ListTile(
            //                               leading: CircleAvatar(
            //                                 backgroundImage: NetworkImage(i['foto'].toString()), // no matter how big it is, it won't overflow
            //                               ),
            //                               title: Text(i['nama_tersangka'].toString()),
            //                               subtitle: Column(
            //                                 children: <Widget>[
            //                                   Row(
            //                                     children: <Widget>[
            //                                       Text('Jenis Kelamin : ', style: TextStyle(fontWeight: FontWeight.bold),),
            //                                       Text(i['jenis_kelamin'].toString(), style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),),
            //                                     ],
            //                                   ),
            //                                   Row(
            //                                     children: <Widget>[
            //                                       Text('Umur : ', style: TextStyle(fontWeight: FontWeight.bold),),
            //                                       Text(i['umur'].toString(), style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),),
            //                                     ],
            //                                   ),
            //                                 ]
            //                               ),
            //                             ),
            //                           ],
            //                         )
            //                       ),
            //                     ),
            //                   )
            //                 ],
            //               )
            //             ]
            //           ),
            //         ),
            //       )
            //     );
            //   }
            // ),
          ],
        ),
      ),
    );
  }
}