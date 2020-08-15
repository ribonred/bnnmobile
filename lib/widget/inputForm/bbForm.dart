import 'package:andro/widget/inputForm/model/tersangka.dart';
import 'package:flutter/material.dart';
import 'package:andro/widget/inputForm/model/lkn.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import '../../services/request.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';

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
  AutoCompleteTextField searchTextFieldTersangka;

  GlobalKey<AutoCompleteTextFieldState<Tersangka>> keys = new GlobalKey();

  static List<Lkn> lkns = new List<Lkn>();
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

  final List optionList = ['narkotika', 'non narkotika'];
  String _date = "Not set";
  String _time = "Not set";
  var form = {
    'milik_tersangka_id': '12',
    'nama_barang': '',
    'sp_sita': '',
    'sp_sita_doc': '',
    'tap_sita': '',
    'tap_sita_doc': '',
    'tap_status': '',
    'tap_status_doc': '',
    'nomor_lab': '',
    'nomor_lab_doc': '',
    'jenis_barang': 'narkotika',
  };

  // rest of our code
   @override
  void initState() {
    getTersangka();
    print(lkns);
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
                    form['milik_tersangka_id'] = item.id.toString();
                  });
                },
                itemBuilder: (context, item){
                  // ui for autocomplete
                  return rowTersangka(item);
                },
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
                  // File file = await FilePicker.getFile();
                  String filePath = await FilePicker.getFilePath(type: FileType.any);
                  setState(() {
                    form['sp_sita_doc'] = filePath;
                  });
              }),
              Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: ' FilePath : ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: form['sp_sita_doc'], style: TextStyle(fontStyle: FontStyle.italic)),
                  ],
                ),
              ),
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
                  // File file = await FilePicker.getFile();
                  String filePath = await FilePicker.getFilePath(type: FileType.any);
                  setState(() {
                    form['tap_sita_doc'] = filePath;
                  });
              }),
              Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: ' FilePath : ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: form['tap_sita_doc'], style: TextStyle(fontStyle: FontStyle.italic)),
                  ],
                ),
              ),
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
                  // File file = await FilePicker.getFile();
                  String filePath = await FilePicker.getFilePath(type: FileType.any);
                  setState(() {
                    form['tap_status_doc'] = filePath;
                  });
              }),
              if (form['jenis_barang'] == 'narkotika')
              Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: ' FilePath : ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: form['tap_status_doc'], style: TextStyle(fontStyle: FontStyle.italic)),
                  ],
                ),
              ),
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
                  // File file = await FilePicker.getFile();
                  String filePath = await FilePicker.getFilePath(type: FileType.any);
                  setState(() {
                    form['nomor_lab_doc'] = filePath;
                  });
              }),
              if (form['jenis_barang'] == 'narkotika')
              Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: ' FilePath : ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: form['nomor_lab_doc'], style: TextStyle(fontStyle: FontStyle.italic)),
                  ],
                ),
              ),
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
                  bb(null, form).then((response) async {
                     if (response.containsKey('id')){
                      final snackBar = SnackBar(content: Text('Barang Bukti Berhasil Disimpan'));
                      Scaffold.of(context).showSnackBar(snackBar);
                    } else {
                      final snackBar = SnackBar(content: Text('Gagal Menyimpan Barang Bukti'));
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