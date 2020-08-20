import 'package:flutter/material.dart';
import 'dart:convert';
import '../services/request.dart';

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
  List approvals = [];
  var form = {
    'status_mod': '',
  };

  void getActivities() async {
    try {
      final response = await approval(null);
      if(response.statusCode == 200){
        print(jsonDecode(response.body));
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
    print(approvals[0].lkn);
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _books[index].isExpanded = !isExpanded;
        });
      },
      children: _books.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
            title: Text(item.expandedValue),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}

// stores ExpansionPanel state information
class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
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
    );
  });
}

