import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../../services/request.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:async';
import 'dart:io';

class bbForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Barang Bukti';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  String selectedOption;

  final List optionList = ['narkotika', 'non narkotika'];
  String _date = "Not set";
  String _time = "Not set";
  var form = {
    'nama_tersangka': '',
    'nama_barang': '',
    'sp_sita': '',
    'sp_sita_doc': '',
    'tap_sita': '',
    'tap_sita_doc': '',
    'tap_status': '',
    'tap_status_doc': '',
    'nomor_lab': '',
    'nomor_lab_doc': '',
    'jenis_barang': '',
  };

  // rest of our code
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Container(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    form['nama_tersangka'] = val.toString();
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Nama Tersangka',
                  icon: Icon(Icons.assignment_turned_in),
                ),
              ),
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    form['nama_barang'] = val;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Nama Barang',
                  icon: Icon(Icons.assignment_turned_in),
                ),
              ),
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    form['sp_sita'] = val;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'SP Sita',
                  icon: Icon(Icons.assignment_turned_in),
                ),
              ),
              RaisedButton(
                child: Text('Upload SP Sita Doc'),
                onPressed: () async {
                  File file = await FilePicker.getFile();
                  setState(() {
                    form['sp_sita_doc'] = 'test';
                  });
              }),
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    form['tap_sita'] = val;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Tap Sita',
                  icon: Icon(Icons.assignment_turned_in),
                ),
              ),
              RaisedButton(
                child: Text('Upload Tap Sita Doc'),
                onPressed: () async {
                  File file = await FilePicker.getFile();
                  setState(() {
                    form['tap_sita_doc'] = 'test';
                  });
              }),
              if (form['jenis_barang'] == 'narkotika')
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    form['tap_status'] = val;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Tap Status',
                  icon: Icon(Icons.assignment_turned_in),
                ),
              ),
              if (form['jenis_barang'] == 'narkotika')
              RaisedButton(
                child: Text('Upload Tap Status Doc'),
                onPressed: () async {
                  File file = await FilePicker.getFile();
                  setState(() {
                    form['sp_status_doc'] = 'test';
                  });
              }),
              if (form['jenis_barang'] == 'narkotika')
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    form['nomor_lab'] = val;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Nomor Lab',
                  icon: Icon(Icons.assignment_turned_in),
                ),
              ),
              if (form['jenis_barang'] == 'narkotika')
              RaisedButton(
                child: Text('Nomor Lab Doc'),
                onPressed: () async {
                  File file = await FilePicker.getFile();
                  setState(() {
                    form['nomor_lab_doc'] = 'test';
                  });
              }),
              DropdownButtonFormField(
                onSaved: (val) => print(val),
                value: form['jenis_barang'],
                items: optionList.map<DropdownMenuItem>(
                  (val) {
                    return DropdownMenuItem(
                      child: Text(val.toString()),
                      value: val.toString(),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  setState(() {
                    form['jenis_barang'] = val.toString();
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Jenis Narkoba',
                  icon: Icon(Icons.assignment_turned_in),
                ),
              ),
              RaisedButton(
                child: Text('Submit'),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () async {
                  print(form);
                  pnkp(null, form).then((response){
                    if (response != null){
                      setState(() {
                      print(response);
                        });
                      // print(data);
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => LknView( data: data)));
                    }
                  });
                },
              ),
            ]
          ),
        )
      ),
    );
  }
}