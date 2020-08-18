import 'package:andro/widget/editForm/model/penangkapan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../../services/request.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'dart:io';

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
  GlobalKey<AutoCompleteTextFieldState<Penangkapan>> key = new GlobalKey();
  TextEditingController _spJangkapController = TextEditingController();

  static List<Penangkapan> penangkapans = new List<Penangkapan>();
  bool loading = true;
  void getPenangkapans() async {
    try {
      final response = await suggestionList('PNKP');
      if(response.statusCode == 200){
        penangkapans = loadPenangkapans(response.body);
        setState(() {
          loading = false;
        });
        print('penangkapan: ${penangkapans.length}');
      } else {
        print("Error getting penangkapan list");
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      print("Error getting penangkapan list");
    }
  }

  static List<Penangkapan> loadPenangkapans(String jsonString){
    print(jsonString);
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Penangkapan>((json) => Penangkapan.fromJson(json)).toList();
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
    getPenangkapans();
    print(penangkapans.length);
    print(penangkapans);
    super.initState();
  }
  Widget row(Penangkapan penangkapan){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
          child: Text(penangkapan.penangkapan,
            style: TextStyle(fontSize: 15))),
      ]
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
              loading ? CircularProgressIndicator() :
              searchTextField = AutoCompleteTextField<Penangkapan>(
                key: key,
                clearOnSubmit: false,
                suggestions: penangkapans,
                decoration: InputDecoration(
                  labelText: 'No. Penangkapan',
                  icon: Icon(Icons.assignment_turned_in),
                ),
                itemFilter: (item, query){
                  return item.penangkapan.toLowerCase().startsWith(query.toLowerCase());
                },
                itemSorter: (a, b){
                  return a.penangkapan.compareTo(b.penangkapan);
                },
                itemSubmitted: (item){
                   penangkapanSingleData(item.id).then((response) async {
                     if (response.containsKey('id')){
                        setState(() {
                          form['no_penangkapan'] = response['no_penangkapan'];
                          form['tanggal_penangkapan'] = response['tanggal_penangkapan'];
                          form['masa_berakhir_penangkapan'] = response['masa_berakhir_penangkapan'] ?? '';
                          form['dokumen_penangkapan'] = response['dokumen_penangkapan'] ?? '';
                          form['sp_jangkap'] = response['sp_jangkap'] ?? '';
                          form['tanggal_sp_jangkap'] = response['tanggal_sp_jangkap'] ?? '';
                          form['masa_berakhir_sp_jangkap'] = response['masa_berakhir_sp_jangkap'] ?? '';
                          form['dokumen_sp_jangkap'] = response['dokumen_sp_jangkap'] ?? '';
                        });
                        tanggal_sp_jangkap = response['tanggal_sp_jangkap'] ?? 'Belum diatur';
                        masa_berakhir_penangkapan = response['masa_berakhir_penangkapan'] ?? 'Belum diatur';
                        masa_berakhir_sp_jangkap = response['masa_berakhir_sp_jangkap'] ?? 'Belum diatur';
                        tgl_dimulai = response['tanggal_penangkapan'] ?? 'Belum diatur';
                        _spJangkapController.text = response['sp_jangkap'] ?? '';
                     } else {
                      final snackBar = SnackBar(content: Text('Data Gagal Ditemukan'));
                      Scaffold.of(context).showSnackBar(snackBar);
                    }
                  });
                  setState(() {
                    searchTextField.textField.controller.text = item.penangkapan;
                    form['id'] = item.id.toString();
                  });
                },
                itemBuilder: (context, item){
                  // ui for autocomplete
                  return row(item);
                },
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
              Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: ' FilePath : ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: form['dokumen_penangkapan'], style: TextStyle(fontStyle: FontStyle.italic)),
                  ],
                ),
              ),
              TextFormField(
                controller: _spJangkapController,
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
                      form['masa_berakhir_sp_jangkap'] = masa_berakhir_sp_jangkap;
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
              Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: ' FilePath : ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: form['dokumen_sp_jangkap'], style: TextStyle(fontStyle: FontStyle.italic)),
                  ],
                ),
              ),
              RaisedButton(
                child: Text('Submit'),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () async {
                  if (form['id']==null) {
                    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Tolong pilih penangkapan')));
                  }
                  if (await File(form['dokumen_penangkapan']).exists()){
                    print('is a file');
                  } else {
                    form.remove('dokumen_penangkapan');
                  }
                  if (await File(form['dokumen_sp_jangkap']).exists()){
                    print('is a file');
                  } else {
                    form.remove('dokumen_sp_jangkap');
                  }
                  print(form);
                  pnkp(int.parse(form['id']), form).then((response) async {
                    if (response.containsKey('id')){
                      final snackBar = SnackBar(content: Text('Penangkapan Disimpan'));
                      Scaffold.of(context).showSnackBar(snackBar);
                    } else {
                      final snackBar = SnackBar(content: Text('Berkas Penangkapan Sudah Ada'));
                      Scaffold.of(context).showSnackBar(snackBar);
                    }
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