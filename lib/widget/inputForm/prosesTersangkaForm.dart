import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:andro/widget/inputForm/model/tersangka.dart';
import '../../services/request.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
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
  AutoCompleteTextField searchTextFieldTersangka;

  GlobalKey<AutoCompleteTextFieldState<Tersangka>> keys = new GlobalKey();

  static List<Tersangka> tersangkas = new List<Tersangka>();

  final _formKey = GlobalKey<FormState>();
  
  String selectedOption;
  bool loading = true;
  void getTersangka() async {
    try {
      final response = await suggestionList('TSK');
      if(response.statusCode == 200){
        tersangkas = loadTersangkas(response.body);
        setState(() {
          loading = false;
        });
      } else {
        print("Error getting tersangka list");
      }
    } catch (e) {
      print(e);
      setState(() {
        loading = false;
      });
      print("Error getting tersangka list");
    }
  }

  static List<Tersangka> loadTersangkas(String jsonString){
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Tersangka>((json) => Tersangka.fromJson(json)).toList();
  }

  final List optionList = ['Penyidik', 'Kejati', 'Pengadilan 1', 'Pengadilan 2'];
  String tanggal_mulai_proses = "Atur Tanggal Mulai Proses";
  String tanggal_akhir_proses = "Atur Tanggal Akhir Proses";
  var form = {
    'proses_tersangka': '',
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
  void initState() {
    getTersangka();
    super.initState();
  }

   Widget rowTersangka(Tersangka lkn){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
          child: Text('${lkn.nama} (${lkn.id})',
            style: TextStyle(fontSize: 15))),
      ]
    );
  }

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
              searchTextFieldTersangka = AutoCompleteTextField<Tersangka>(
                key: keys,
                clearOnSubmit: false,
                suggestions: tersangkas,
                decoration: InputDecoration(
                  labelText: 'Nama Tersangka',
                  icon: Icon(Icons.assignment_turned_in),
                ),
                itemFilter: (item, query){
                  return item.nama.toLowerCase().startsWith(query.toLowerCase());
                },
                itemSorter: (a, b){
                  return a.nama.compareTo(b.nama);
                },
                itemSubmitted: (item){
                  setState(() {
                    searchTextFieldTersangka.textField.controller.text = item.nama;
                    form['proses_tersangka'] = item.id.toString();
                  });
                },
                itemBuilder: (context, item){
                  // ui for autocomplete
                  return rowTersangka(item);
                },
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
                    form['sp_han_doc'] = '';
                    form['sp_han']='';
                    form['tap_han']='';
                    form['surat_perpanjangan_han']='';
                    form['tap_han_doc'] = '';
                    form['surat_perpanjangan_han_doc']='';
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
              if(form['jenis_proses'] == 2 || form['jenis_proses'] == 3)
              Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: ' FilePath : ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: form['tap_han_doc'], style: TextStyle(fontStyle: FontStyle.italic)),
                  ],
                ),
              ),
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
              if(form['jenis_proses'] == 4)
              Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: ' FilePath : ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: form['surat_perpanjangan_han_doc'], style: TextStyle(fontStyle: FontStyle.italic)),
                  ],
                ),
              ),
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
              if(form['jenis_proses'] == 1)
              Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: ' FilePath : ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: form['sp_han_doc'], style: TextStyle(fontStyle: FontStyle.italic)),
                  ],
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
                  tskProses(null, form).then((response) async {
                     if (response.containsKey('id')){
                      final snackBar = SnackBar(content: Text('Proses Tersangka Berhasil Disimpan'));
                      Scaffold.of(context).showSnackBar(snackBar);
                    } else {
                      final snackBar = SnackBar(content: Text('Gagal Menyimpan Proses Tersangka'));
                      Scaffold.of(context).showSnackBar(snackBar);
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