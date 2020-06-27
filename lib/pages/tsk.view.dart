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
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 44,
                        minHeight: 44,
                        maxWidth: 64,
                        maxHeight: 64,
                      ),
                      child: Image.network(widget.data['foto'].toString())
                    ),
                    title: Text(widget.data['nama_tersangka'].toString(), style: TextStyle(fontSize: 28),),
                    subtitle: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('Jenis Kelamin : ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
                            Text(widget.data['jenis_kelamin'].toString(), style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20.0, color: Colors.black)),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text('Umur : ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
                            Text(widget.data['umur'].toString(), style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20.0, color: Colors.black),),
                          ],
                        ),
                      ]
                    ),
                  ),
                ],
              )
            ),
          ],
        ),
      )
    );
  }
}
