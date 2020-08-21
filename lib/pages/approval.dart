import 'package:flutter/material.dart';
import 'dart:convert';
import '../services/request.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Approval extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Approval Page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue,),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Approval Page'),
        ),
        body: ApprovalPageState(),
      ),
    );
  }
}


class ApprovalPageState extends StatefulWidget {
  ApprovalPageState({Key key}) : super(key: key);

  @override
  _ApprovalPageState createState() => _ApprovalPageState();
}

class _ApprovalPageState extends State<ApprovalPageState> {
  List<Item> _books = [];
  bool loading = true;
  int user = 1;
  List approvals = [];
  var form = {
    'status_mod': '',
  };

  void getActivities() async {
    try {
      Map verify = await verifyToken();
      user = verify['data']['user']['role'];

      final response = await approval(null, null);
      if(response.statusCode == 200){
        approvals = loadApprovals(response.body);
        _books = generateItems(approvals);
        setState(() {
          loading = false;
          approvals = approvals;
        });
      } else {
        setState(() {
          loading = false;
        });
        print("Error getting activity list on else");
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      print("Error getting activity list on catch");
      print(e);
    }
  }

  @override
  void initState() {
    getActivities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 20),
          child: loading ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ) : _buildPanel(),
        ),
      ),
    );
  }

  Widget _buildPanel() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: ExpansionPanelList(
      children: _books.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text('LKN: ${item.lkn}, BB: ${item.barang_bukti}', style: new TextStyle(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic, color: Colors.black.withOpacity(0.8))),
            );
          },
          body: Container(
            decoration: BoxDecoration(
              border: null,
              color: Colors.grey[100],
              borderRadius: BorderRadius.all(Radius.circular(8))),
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                AutoSizeText('LKN: ${item.lkn}', maxLines: 1, minFontSize: 7,),
                AutoSizeText('Penangkapan: ${item.lkn}', maxLines: 1, minFontSize: 7,),
                AutoSizeText('Tersangka: ${item.tersangka}', maxLines: 1, minFontSize: 7,),
                SizedBox(height: 5),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          AutoSizeText('Tanggal: ${item.tanggal_status}', maxLines: 1, minFontSize: 7,),
                          AutoSizeText('Waktu: ${item.waktu_status}', maxLines: 1, minFontSize: 7,),
                          AutoSizeText('Status: ${item.status}', maxLines: 1, minFontSize: 7,),
                          AutoSizeText('Jumlah: ${item.jumlah} ${item.satuan}', maxLines: 1, minFontSize: 7,),
                        ]
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          AutoSizeText('Approve Status: ${item.approve_status}', maxLines: 1, minFontSize: 7,),
                          AutoSizeText('Moderator 1: ${item.moderator_one_status}', maxLines: 1, minFontSize: 7,),
                          AutoSizeText('Moderator 2: ${item.moderator_two_status}', maxLines: 1, minFontSize: 7,),
                          AutoSizeText('Moderator 3: ${item.moderator_three_status}', maxLines: 1, minFontSize: 7,),
                        ]
                      )
                    ),
                  ]
                ),
                SizedBox(height: 8),
                AutoSizeText('Ketereangan: ${item.keterangan}', maxLines: 3, minFontSize: 7,),
                user == 1 ? SizedBox(height: 10) :
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () async {
                        form['status_mod'] = 'REJECT';
                        final isReject = await approval(item.id, form);
                        if (isReject.statusCode == 200){
                          _books.removeWhere((data) => data.id == _books[_books.indexOf(item)].id);
                          _books.join(', ');
                          setState(() {
                            _books = _books;
                          });
                        } else {
                          print("error on mark as read");
                          print(isReject);
                        }
                      },
                      color: Colors.red,
                      child: const Text('REJECT', style: TextStyle(fontSize: 14)),
                    ),

                    SizedBox(width: 5),
                    RaisedButton(
                      onPressed: () async {
                        form['status_mod'] = 'APPROVE';
                        final isApprove = await approval(item.id, form);
                        if (isApprove.statusCode == 200){
                          _books.removeWhere((data) => data.id == _books[_books.indexOf(item)].id);
                          _books.join(', ');
                          setState(() {
                            _books = _books;
                          });
                        } else {
                          print("error on mark as read");
                          print(isApprove);
                        }
                      },
                      color: Colors.green,
                      child: const Text('APPROVE', style: TextStyle(fontSize: 14, color: Colors.white)),
                    ),
                  ],
                ),
              ]
            )
          ),
          isExpanded: true,
        );
      }).toList(),
    )
    );
  }
}

// stores ExpansionPanel state information
class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
    this.id, this.admin, 
    this.lkn, 
    this.penangkapan, 
    this.tersangka, 
    this.barang_bukti, 
    this.tanggal_status, 
    this.waktu_status, 
    this.jumlah, 
    this.satuan, 
    this.keterangan, 
    this.status, 
    this.approve_status, 
    this.moderator_one_status, 
    this.moderator_two_status, 
    this.moderator_three_status
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
  int id;
  String admin;
  String lkn;
  String penangkapan;
  String tersangka;
  String barang_bukti;
  String tanggal_status;
  String waktu_status;
  String jumlah;
  String satuan;
  String keterangan;
  String status;
  String approve_status;
  String moderator_one_status;
  String moderator_two_status;
  String moderator_three_status;
}

class StatusApproval {
  int id;
  String admin;
  String lkn;
  String penangkapan;
  String tersangka;
  String barang_bukti;
  String tanggal_status;
  String waktu_status;
  String jumlah;
  String satuan;
  String keterangan;
  String status;
  String approve_status;
  String moderator_one_status;
  String moderator_two_status;
  String moderator_three_status;
  bool isExpanded;

  StatusApproval({this.id, this.admin, this.lkn, this.penangkapan, this.tersangka, this.barang_bukti, 
  this.tanggal_status, this.waktu_status, this.jumlah, this.satuan, this.keterangan, this.status, this.approve_status, 
  this.moderator_one_status, this.moderator_two_status, this.moderator_three_status, this.isExpanded});

  factory StatusApproval.fromJson(Map<String, dynamic> parsedJson) {
    return StatusApproval(
      id: parsedJson["id"],
      admin: parsedJson["admin"] as String,
      lkn: parsedJson["LKN"] as String,
      penangkapan: parsedJson["penangkapan"] as String,
      tersangka: parsedJson["tersangka"] as String,
      barang_bukti: parsedJson["barang_bukti"] as String,
      tanggal_status: parsedJson["tanggal_status"] as String,
      waktu_status: parsedJson["waktu_status"] as String,
      jumlah: parsedJson["jumlah"] as String,
      satuan: parsedJson["satuan"] as String,
      keterangan: parsedJson["keterangan"] as String,
      status: parsedJson["status"] as String,
      approve_status: parsedJson["approve_status"] as String,
      moderator_one_status: parsedJson["moderator_one_status"] as String,
      moderator_two_status: parsedJson["moderator_two_status"] as String,
      moderator_three_status: parsedJson["moderator_three_status"] as String,
      isExpanded: false
    );
  }
}

List<StatusApproval> loadApprovals(String jsonString){
  final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
  return parsed.map<StatusApproval>((json) => StatusApproval.fromJson(json)).toList();
}

List<Item> generateItems(List data) {
  return List.generate(data.length, (int index) {
    return Item(
      headerValue: '${data[index].admin}',
      expandedValue: '${data[index].lkn}',
      id: data[index].id,
      admin: '${data[index].admin}',
      lkn: '${data[index].lkn}',
      penangkapan: '${data[index].penangkapan}',
      tersangka: '${data[index].tersangka}',
      barang_bukti: '${data[index].barang_bukti}',
      tanggal_status: '${data[index].tanggal_status}',
      waktu_status: '${data[index].waktu_status}',
      jumlah: '${data[index].jumlah}',
      satuan: '${data[index].satuan}',
      keterangan: '${data[index].keterangan}',
      status: '${data[index].status}',
      approve_status: '${data[index].approve_status}',
      moderator_one_status: '${data[index].moderator_one_status}',
      moderator_two_status: '${data[index].moderator_two_status}',
      moderator_three_status: '${data[index].moderator_three_status}',
    );
  });
}

