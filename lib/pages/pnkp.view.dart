import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class PnkpView extends StatefulWidget {
  final data;
  const PnkpView({Key key,this.data}) : super(key: key);
  @override
  PnkpViewState createState() => PnkpViewState();
}

class PnkpViewState extends State<PnkpView> {
  // List<Map<String, dynamic>> files=[] ;
  @override
  Widget build(context) {
    List<Map<String, dynamic>> files=[] ;
    // var files = [
    //   {'title':'dokumen penangkapan', 'url':widget.data['dokumen_penangkapan']},
    //   {'title':'dokumen sp jangkap', 'url':widget.data['dokumen_sp_jangkap']}
    // ];
    if (widget.data['dokumen_penangkapan'] != null) {
      files.add({'title':'dokumen penangkapan', 'url':widget.data['dokumen_penangkapan']});
    }
    if (widget.data['dokumen_sp_jangkap'] != null) {
      files.add({'title':'dokumen sp jangkap', 'url':widget.data['dokumen_sp_jangkap']});
    }
    
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
                // if (widget.data['dokumen_penangkapan'] != null) {
                //   files.add({'title':'dokumen penangkapan', 'url':widget.data['dokumen_penangkapan']});
                // }
                // if (widget.data['dokumen_sp_jangkap'] != null) {
                //   files.add({'title':'dokumen sp jangkap', 'url':widget.data['dokumen_sp_jangkap']});
                // }
                print(files);
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                      elevation: 16,
                      child: Container(
                        height: 250.0,
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
                            SizedBox(height: 30),
                            for (var i in files) RaisedButton(
                              child: Text(i['title'].toString()),
                              onPressed: () async {
                                //Insert event to be fired up when button is clicked here
                                //in this case, this increments our `countValue` variable by one.
                                print('url'+i['url']);
                                final status = await Permission.storage.request();
                                if(status.isGranted){
                                  final externalDir = await getExternalStorageDirectory();
                                  final id = FlutterDownloader.enqueue(
                                    url: "${i['url']}",
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
                            if (files.length==0) Center(
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.highlight_off,
                                    color: Colors.pink,
                                    size: 75.0,
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    "Tidak ada berkas untuk diunduh",
                                    style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                                  ),
                                ]
                              )
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}