import 'dart:convert';

import 'package:flutter/material.dart';
import '../services/request.dart';
import '../pages/lkn.view.dart';
import '../pages/pnkp.view.dart';
import '../pages/tsk.view.dart';
import '../pages/bb.view.dart';
import 'dart:convert';

class GetLkn extends StatefulWidget {
  final data;
  final judul;
  final created;
  final title;
  final next;
  const GetLkn({Key key,this.data,this.judul, this.created, this.title, this.next}) : super(key: key);
  @override
  LknState createState() => LknState();
}


class LknState extends State<GetLkn> {
  var data;
  List list = [];
  String urlNext = '';
  String urlPrev = '';
  //DEFINE VARIABLE url UNTUK MENAMPUNG END POINT
  // final String url = 'http://178.128.80.233:8000/mobile-api/lkn/';
  // Map data; //DEFINE VARIABLE data DENGAN TYPE List AGAR DAPAT MENAMPUNG COLLECTION / ARRAY

  // Future<String> getData() async {
  //   // MEMINTA DATA KE SERVER DENGAN KETENTUAN YANG DI ACCEPT ADALAH JSON
  //   var res = await http.get(Uri.encodeFull(url), headers: { 'accept':'application/json' });
  //   var token = await storage.read(key: 'token');
  //   print(token);
    
  //   setState(() {
  //     //RESPONSE YANG DIDAPATKAN DARI API TERSEBUT DI DECODE
  //     var content = json.decode(res.body);
  //     //KEMUDIAN DATANYA DISIMPAN KE DALAM VARIABLE data, 
  //     //DIMANA SECARA SPESIFIK YANG INGIN KITA AMBIL ADALAH ISI DARI KEY hasil
  //     data = content['results'];
  //   });
  //   return 'success!';
  // }
  @override
  // void initState() {
  // super.initState();
  // // this.getData();
  // }
 
  Widget build(context){
    print(widget.next);
    if (list.length == 0) {
      list = widget.data;
    }
    if (urlNext == '' && widget.next != null) {
      urlNext = widget.next;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title.toString())
        ),
        body: Container(
          margin: EdgeInsets.all(10.0), //SET MARGIN DARI CONTAINER
          child: ListView.builder( //MEMBUAT LISTVIEW
            itemCount: list == null ? 0:list.length, //KETIKA DATANYA KOSONG KITA ISI DENGAN 0 DAN APABILA ADA MAKA KITA COUNT JUMLAH DATA YANG ADA
            itemBuilder: (BuildContext context, int index) { 
              return Container(
                child: GestureDetector(
                  onTap: () async { 
                    if (widget.title.toString()=='LKN')
                    {
                      // print(widget.data[index]['id']);
                      lkn(list[index]['id'], null).then((response){
                        if (response != null){
                          setState(() {
                          data = response;
                            });
                          // print(data);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LknView( data: data)));
                        }
                      });
                    }
                    else if (widget.title.toString()=='PENANGKAPAN')
                    {
                      pnkp(list[index]['id'], null).then((response){
                        if (response != null){
                          setState(() {
                          data = response;
                            });
                          // print(data);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PnkpView( data: data)));
                        }
                      });
                    }
                    else if (widget.title.toString()=='BARANG BUKTI')
                    {
                      var bbStatus = await suggestionList('BBStatus', id:list[index]['id']);
                      bbStatus = json.decode(bbStatus.body);

                      bb(list[index]['id'], null).then((response){
                        if (response != null){
                          setState(() {
                          data = response;
                            });
                          // print(data);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BbView( data: data, status: bbStatus,)));
                        }
                      });
                    } 
                    else if (widget.title.toString()=='TERSANGKA')
                    {
                      var tskProses = await suggestionList('TSKProses', id:list[index]['id']);
                      tskProses = json.decode(tskProses.body);

                      tsk(list[index]['id'], null).then((response){
                        if (response != null){
                          setState(() {
                          data = response;
                            });
                          // print(data);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TskView( data: data, proses: tskProses)));
                        }
                      });
                    } 
                   },
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min, children: <Widget>[
                      ListTile(
                        title: Text(list[index][widget.judul].toString(), style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),),
                        subtitle: Column(children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text('di buat : ', style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(list[index][widget.created].toString(), style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12.0),),
                            ],
                          ),
                          
                        ],),
                      ),
                    ],),
                  )
                ),
              );
            },
          ),
        ),
        
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: RaisedButton(
                  onPressed: urlPrev == null || urlPrev == '' ? null : () async {
                    final newData = await loadData(urlPrev);
                    print('url prev');
                    print(urlPrev);
                    setState(() {
                      list = newData['results'];
                      urlNext = newData['next'];
                      urlPrev = newData['previous'];
                    });
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text('Prev'),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: RaisedButton(
                  onPressed: urlNext == null || urlNext == '' ? null : () async {
                    final newData = await loadData(urlNext);
                    print('url next');
                    print(urlNext);
                    setState(() {
                      list = newData['results'];
                      urlNext = newData['next'];
                      urlPrev = newData['previous'];
                    });
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text('Next'),
                ),
              )
            ],
          )
        ),
      );
}
}
