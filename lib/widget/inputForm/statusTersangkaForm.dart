import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../../services/request.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:andro/widget/inputForm/model/tersangka.dart';
import 'dart:convert';
class statusTersangkaForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Status Tersangka';

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

  final List rekamJejakList = ['Masuk', 'Keluar'];
  final List statusPenahananList = ['Di Amankan', 'Di tahan', 'TAT', 'Selesai'];
  String tanggal = "Atur Tanggal";
  String waktu = "Atur Waktu";
  var form = {
    'tersangka_id': '12',
    'status_penahanan': 'Di Amankan',
    'rekam_jejak': 'Masuk',
    'tanggal': '',
    'waktu': '',
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
                    form['tersangka_id'] = item.id.toString();
                  });
                },
                itemBuilder: (context, item){
                  // ui for autocomplete
                  return rowTersangka(item);
                },
              ),
              DropdownButtonFormField(
                onSaved: (val) => print(val),
                value: form['status_penahanan'],
                items: statusPenahananList.map<DropdownMenuItem>(
                  (val) {
                    return DropdownMenuItem(
                      child: Text(val.toString()),
                      value: val.toString(),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  setState(() {
                    form['status_penahanan'] = val.toString();
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Status Penahanan',
                  icon: Icon(Icons.assignment_turned_in),
                ),
              ),
              DropdownButtonFormField(
                onSaved: (val) => print(val),
                value: form['rekam_jejak'],
                items: rekamJejakList.map<DropdownMenuItem>(
                  (val) {
                    return DropdownMenuItem(
                      child: Text(val.toString()),
                      value: val.toString(),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  setState(() {
                    form['rekam_jejak'] = val.toString();
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Rekam Jejak',
                  icon: Icon(Icons.assignment_turned_in),
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
                    tanggal = '${date.day}-${date.month}-${date.year}';
                    setState(() {
                      form['tanggal'] = tanggal;
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
                                  " $tanggal",
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
                  DatePicker.showTimePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true, onConfirm: (time) {
                    waktu = '${time.hour}:${time.minute}:${time.second}';
                    setState(() {
                      form['waktu'] = waktu;
                    });
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                  setState(() {});
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
                                  Icons.access_time,
                                  size: 18.0,
                                  color: Colors.blue,
                                ),
                                Text(
                                  " $waktu",
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
                  tskStatus(null, form).then((response) async {
                     if (response.containsKey('id')){
                      final snackBar = SnackBar(content: Text('Status Tersangka Berhasil Disimpan'));
                      Scaffold.of(context).showSnackBar(snackBar);
                    } else {
                      final snackBar = SnackBar(content: Text('Gagal Menyimpan Status Tersangka'));
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