import 'package:flutter/material.dart';
import '../services/request.dart';
import '../pages/lkn.view.dart';
import '../pages/pnkp.view.dart';
import '../pages/tsk.view.dart';

class GetLkn extends StatefulWidget {
  final data;
  final judul;
  final created;
  final title;
  const GetLkn({Key key,this.data,this.judul, this.created, this.title}) : super(key: key);
  @override
  LknState createState() => LknState();
}


class LknState extends State<GetLkn> {
  var data;
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
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title.toString())
        ),
        body: Container(
          margin: EdgeInsets.all(10.0), //SET MARGIN DARI CONTAINER
          child: ListView.builder( //MEMBUAT LISTVIEW
            itemCount: widget.data == null ? 0:widget.data.length, //KETIKA DATANYA KOSONG KITA ISI DENGAN 0 DAN APABILA ADA MAKA KITA COUNT JUMLAH DATA YANG ADA
            itemBuilder: (BuildContext context, int index) { 
              return Container(
                child: GestureDetector(
                  onTap: () { 
                    if (widget.title.toString()=='LKN')
                    {
                      // print(widget.data[index]['id']);
                      lkn(widget.data[index]['id'], null).then((response){
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
                      pnkp(widget.data[index]['id'], null).then((response){
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

                    } 
                    else if (widget.title.toString()=='TERSANGKA')
                    {
                      tsk(widget.data[index]['id'], null).then((response){
                        if (response != null){
                          setState(() {
                          data = response;
                            });
                          // print(data);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TskView( data: data)));
                        }
                      });
                    } 
                    else if (widget.title.toString()=='PROSES TERSANGKA')
                    {

                    }  
                    else if (widget.title.toString()=='STATUS BB')
                    {

                    } 
                    else
                    {
                      print('WEIRD');
                    }
                   },
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min, children: <Widget>[
                      ListTile(
                        title: Text(widget.data[index][widget.judul].toString(), style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
                        subtitle: Column(children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text('di buat : ', style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(widget.data[index][widget.created].toString(), style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15.0),),
                            ],
                          ),
                        ],),
                      ),
                      //TERAKHIR, MEMBUAT BUTTON
                      ButtonTheme.bar(
                        child: ButtonBar(
                          children: <Widget>[
                            // BUTTON PERTAMA f
                            FlatButton(
                              //DENGAN TEXT LIHAT DETAIL
                              child: const Text('LIHAT DETAIL'),
                              onPressed: () { print(widget.data[index]['id']); },
                            ),
                            //BUTTON KEDUA
                            FlatButton(
                              //DENGAN TEXT DENGARKAN
                              child: const Text('EDIT'),
                              onPressed: () { /* ... */ },
                            ),
                          ],
                        ),
                      ),
                    ],),
                  )
                ),
              );
            },
          ),
        )
      );
   
}
}
