import 'package:andro/widget/inputForm/model/lkn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../../services/request.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:mime/mime.dart';
import 'dart:convert';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class spkapForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'SPKAP FORM';

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
  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<Lkn>> key = new GlobalKey();
  static List<Lkn> lkns = new List<Lkn>();
  void getLkns() async {
    try {
      final response = await lknList();
      if(response.statusCode == 200){
        lkns = loadLkns(response.body);
        print('lkns: ${lkns.length}');
      } else {
        print("Error getting lkn list");
      }
    } catch (e) {
      print("Error getting lkn list");
    }
  }

  static List<Lkn> loadLkns(String jsonString){
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Lkn>((json) => Lkn.fromJson(json)).toList();
  }
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  String selectedOption;
  final List optionList = ['Penangkapan', 'Penangkapan 2', 'Penangkapan 3'];
  String tgl_dimulai = "Belum diatur";
  String masa_berakhir_penangkapan = "Belum diatur";
  String tanggal_sp_jangkap = "Belum diatur";
  String masa_berakhir_sp_jangkap = "Belum diatur";
  var form = {
    'no_lkn': '',
    'no_penangkapan': '',
    'tanggal_penangkapan': '',
    'masa_berakhir_penangkapan': '',
    'dokumen_penangkapan': '',
    'sp_jangkap': '',
    'tanggal_sp_jangkap': '',
    'masa_berakhir_sp_jangkap': '',
    'dokumen_sp_jangkap': '',
  };
  @override
  void initState() {
    getLkns();
    super.initState();
  }
  Widget row(Lkn lkn){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(lkn.lkn, style: TextStyle(fontSize: 16-.0),)
      ],
    );
  }
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
              searchTextField = AutoCompleteTextField<Lkn>(
                key: key,
                clearOnSubmit: false,
                suggestions: lkns,
                decoration: InputDecoration(
                  labelText: 'No. LKN',
                  icon: Icon(Icons.assignment_turned_in),
                ),
                itemFilter: (item, query){
                  return item.lkn.toLowerCase().startsWith(query.toLowerCase());
                },
                itemSorter: (a, b){
                  return a.lkn.compareTo(b.lkn);
                },
                itemSubmitted: (item){
                  setState(() {
                    searchTextField.textField.controller.text = item.lkn;
                    form['no_lkn'] = item.id.toString();
                  });
                },
                itemBuilder: (context, item){
                  // ui for autocomplete
                  return row(item);
                },
              ),
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    form['no_lkn'] = val.toString();
                  });
                },
                decoration: InputDecoration(
                  labelText: 'No. LKN',
                  icon: Icon(Icons.assignment_turned_in),
                ),
              ),
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    form['no_penangkapan'] = val.toString();
                  });
                },
                decoration: InputDecoration(
                  labelText: 'No. Penangkapan',
                  icon: Icon(Icons.assignment_turned_in),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(text: 'Tanggal Penangkapan', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
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
                      maxTime: DateTime(2040, 12, 31), onConfirm: (date) {
                    tgl_dimulai = '${date.day}-${date.month}-${date.year}';
                    setState(() {
                      form['tanggal_penangkapan'] = tgl_dimulai;
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
                                  " $tgl_dimulai",
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(text: 'Masa Berakhir Penangkapan', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
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
                      maxTime: DateTime(2040, 12, 31), onConfirm: (date) {
                    masa_berakhir_penangkapan = '${date.day}-${date.month}-${date.year}';
                    setState(() {
                      form['masa_berakhir_penangkapan'] = masa_berakhir_penangkapan;
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
                                  " $masa_berakhir_penangkapan",
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(text: 'Dokumen Penangkapan', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              RaisedButton(
                child: Text('Pilih dokumen'),
                onPressed: () async {
                  // File file = await FilePicker.getFile();
                  String filePath = await FilePicker.getFilePath(type: FileType.any);
                  // String mimeStr = lookupMimeType(filePath);
                  // var fileType = mimeStr.split('/');
                  // print('file type ${fileType[1]}');
                   setState(() {
                    form['dokumen_penangkapan'] = filePath;
                   });
                   print('ini dokumen penangkapan');
                   print(form['dokumen_penangkapan']);
              }),
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    form['sp_jangkap'] = val.toString();
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Sp. Jangkap',
                  icon: Icon(Icons.assignment_turned_in),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(text: 'Tanggal SP. Jangkap', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
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
                      maxTime: DateTime(2040, 12, 31), onConfirm: (date) {
                    tanggal_sp_jangkap = '${date.day}-${date.month}-${date.year}';
                    setState(() {
                      form['tanggal_sp_jangkap'] = tanggal_sp_jangkap;
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
                                  " $tanggal_sp_jangkap",
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(text: 'Masa Berakhir SP.Jangkap', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
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
                      maxTime: DateTime(2040, 12, 31), onConfirm: (date) {
                    masa_berakhir_sp_jangkap = '${date.day}-${date.month}-${date.year}';
                    setState(() {
                      form['masa_berakhir_sp_jangkap'] = tanggal_sp_jangkap;
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
                                  " $masa_berakhir_sp_jangkap",
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(text: 'Dokumen SP.Jangkap', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              RaisedButton(
                child: Text('Pilih dokumen'),
                onPressed: () async {
                  // File file = await FilePicker.getFile();
                  String filePath = await FilePicker.getFilePath(type: FileType.any);
                  // String mimeStr = lookupMimeType(filePath);
                  // var fileType = mimeStr.split('/');
                  // print('file type ${fileType[1]}');
                  setState(() {
                    form['dokumen_sp_jangkap'] = filePath;
                  });
                  print('ini dokumen_sp_jangkap');
                  print(form['dokumen_sp_jangkap']);
                  //  setState(() {
                  //   form['dokumen_sp_jangkap'] = file;
                  //  });
              }),
              RaisedButton(
                child: Text('Submit'),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () async {
                  pnkp(null, form).then((response) async {
                    print('response');
                    print(response);
                  });
                },
              )
            ]
          ),
        )
      ),
    );
  }
}