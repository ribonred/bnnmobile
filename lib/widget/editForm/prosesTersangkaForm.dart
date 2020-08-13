import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../../services/request.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:async';
import 'dart:io';

class prosesTersangkaForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Proses Tersangka';

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
  final List optionList = ['Penyidik', 'Kejati', 'Pengadilan 1', 'Pengadilan 2'];
  String tanggal_mulai_proses = "Atur Tanggal Mulai Proses";
  String tanggal_akhir_proses = "Atur Tanggal Akhir Proses";
  var form = {
    'proses_tersangka': '12',
    'jenis_proses': 1,
    'tap_han': '',
    'tap_han_doc': '',
    'surat_perpanjangan_han': '',
    'surat_perpanjangan_han_doc': '',
    'sp_han': '',
    'sp_han_doc': '',
    'tanggal_mulai_proses': '',
    'tanggal_akhir_proses': '',
    'keterangan': '',
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
                    form['proses_tersangka'] = val.toString();
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Nama Tersangka',
                  icon: Icon(Icons.assignment_turned_in),
                ),
              ),
              DropdownButtonFormField(
                onSaved: (val) => print(val),
                value: form['jenis_proses'],
                items: optionList.map<DropdownMenuItem>(
                  (val) {
                    return DropdownMenuItem(
                      child: Text(val.toString()),
                      value: optionList.indexOf(val.toString()) + 1,
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  setState(() {
                    form['jenis_proses'] = val;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Jenis Proses',
                  icon: Icon(Icons.assignment_turned_in),
                ),
              ),
              if(form['jenis_proses'] == 2 || form['jenis_proses'] == 3)
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    form['tap_han'] = val.toString();
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Tap Han',
                  icon: Icon(Icons.assignment_turned_in),
                ),
              ),
              if(form['jenis_proses'] == 2 || form['jenis_proses'] == 3)
              RaisedButton(
                child: Text('Upload Tap Han Doc'),
                onPressed: () async {
                  // File file = await FilePicker.getFile();
                  String filePath = await FilePicker.getFilePath(type: FileType.any);

                  setState(() {
                    form['tap_han_doc'] = filePath;
                  });
              }),
              if(form['jenis_proses'] == 4)
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    form['surat_perpanjangan_han'] = val.toString();
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Surat Perpanjangan Han',
                  icon: Icon(Icons.assignment_turned_in),
                ),
              ),
              if(form['jenis_proses'] == 4)
              RaisedButton(
                child: Text('Upload Surat Perpanjangan Han Doc'),
                onPressed: () async {
                  // File file = await FilePicker.getFile();
                  String filePath = await FilePicker.getFilePath(type: FileType.any);
                  setState(() {
                    form['surat_perpanjangan_han_doc'] = filePath;
                  });
              }),
              if(form['jenis_proses'] == 1)
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    form['sp_han'] = val.toString();
                  });
                },
                decoration: InputDecoration(
                  labelText: 'SP Han',
                  icon: Icon(Icons.assignment_turned_in),
                ),
              ),
              if(form['jenis_proses'] == 1)
              RaisedButton(
                child: Text('Upload SP Han Doc'),
                onPressed: () async {
                  // File file = await FilePicker.getFile();
                  String filePath = await FilePicker.getFilePath(type: FileType.any);
                  setState(() {
                    form['sp_han_doc'] = filePath;
                  });
              }),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true,
                      minTime: DateTime(2000, 1, 1),
                      maxTime: DateTime(2050, 12, 31), onConfirm: (date) {
                    print('confirm $date');
                    tanggal_mulai_proses = '${date.day}-${date.month}-${date.year}';
                    setState(() {
                      form['tanggal_mulai_proses'] = tanggal_mulai_proses;
                    });
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.date_range,
                                  size: 18.0,
                                  color: Colors.blue,
                                ),
                                Text(
                                  " $tanggal_mulai_proses",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "Ubah",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true,
                      minTime: DateTime(2000, 1, 1),
                      maxTime: DateTime(2050, 12, 31), onConfirm: (date) {
                    print('confirm $date');
                    tanggal_akhir_proses = '${date.day}-${date.month}-${date.year}';
                    setState(() {
                      form['tanggal_akhir_proses'] = tanggal_akhir_proses;
                    });
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.date_range,
                                  size: 18.0,
                                  color: Colors.blue,
                                ),
                                Text(
                                  " $tanggal_akhir_proses",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "Ubah",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    form['keterangan'] = val.toString();
                  });
                },
                maxLines: 8,
                decoration: InputDecoration(
                  labelText: 'Keterangan',
                  icon: Icon(Icons.assignment_turned_in),
                ),
              ),
              RaisedButton(
                child: Text('Submit'),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () async {
                  print(form);
                },
              ),
            ]
          ),
        )
      ),
    );
  }
}