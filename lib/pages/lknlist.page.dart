import 'package:flutter/material.dart';


class LknListView extends StatefulWidget{
  @override
  _LknListView createState() => _LknListView();
}

class _LknListView extends State <LknListView>{
    final List<Widget> _listViewData = [
        Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.folder_open),
              isThreeLine: true,
              title: Text('Ini nomor LKN'),
              subtitle: Text('Di buat oleh: Admin'),
              trailing: Icon(Icons.more_vert),
            ),
          ],
        ),),
        Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.folder_open),
              isThreeLine: true,
              title: Text('Ini nomor LKN'),
              subtitle: Text('Di buat oleh: Admin'),
              trailing: Icon(Icons.more_vert),
            ),
          ],
        ),),
        Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.folder_open),
              isThreeLine: true,
              title: Text('Ini nomor LKN'),
              subtitle: Text('Di buat oleh: Admin'),
              trailing: Icon(Icons.more_vert),
            ),
          ],
        ),),
        Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.folder_open),
              isThreeLine: true,
              title: Text('Ini nomor LKN'),
              subtitle: Text('Di buat oleh: Admin'),
              trailing: Icon(Icons.more_vert),
            ),
          ],
        ),),
        Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.folder_open),
              isThreeLine: true,
              title: Text('Ini nomor LKN'),
              subtitle: Text('Di buat oleh: Admin'),
              trailing: Icon(Icons.more_vert),
            ),
          ],
        ),),
        Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.folder_open),
              isThreeLine: true,
              title: Text('Ini nomor LKN'),
              subtitle: Text('Di buat oleh: Admin'),
              trailing: Icon(Icons.more_vert),
            ),
          ],
        ),),
        Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.folder_open),
              isThreeLine: true,
              title: Text('Ini nomor LKN'),
              subtitle: Text('Di buat oleh: Admin'),
              trailing: Icon(Icons.more_vert),
            ),
          ],
        ),),
        Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.folder_open),
              isThreeLine: true,
              title: Text('Ini nomor LKN'),
              subtitle: Text('Di buat oleh: Admin'),
              trailing: Icon(Icons.more_vert),
            ),
          ],
        ),),
  ];
    @override
    Widget build(BuildContext context){
      return Scaffold(
        body: CustomScrollView(
          slivers:<Widget>[
            SliverAppBar(
              title:Text('LKN LIST'),
              expandedHeight: 120,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                _listViewData.toList(),
            ),
            ),
          ],
        ),
      );
      
    }

}