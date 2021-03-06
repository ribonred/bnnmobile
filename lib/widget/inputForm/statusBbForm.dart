import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../../services/request.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'dart:convert';
import 'package:andro/widget/inputForm/model/barangBukti.dart';

class statusBbForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Status BB Form';

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

  GlobalKey<AutoCompleteTextFieldState<BarangBukti>> keys = new GlobalKey();

  static List<BarangBukti> barangBuktis = new List<BarangBukti>();

  final _formKey = GlobalKey<FormState>();
  
  String selectedOption;
  bool loading = true;
  void getBarangBukti() async {
    try {
      final response = await suggestionList('BB');
      if(response.statusCode == 200){
        barangBuktis = loadBarangBukti(response.body);
        setState(() {
          loading = false;
        });
      } else {
        print("Error getting barang bukti list");
      }
    } catch (e) {
      print(e);
      setState(() {
        loading = false;
      });
      print("Error getting barang bukti list");
    }
  }

  static List<BarangBukti> loadBarangBukti(String jsonString){
    print(jsonString);
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<BarangBukti>((json) => BarangBukti.fromJson(json)).toList();
  }

  final List satuanList = ['gram', 'butir', 'PCS', 'unit'];
  final List statusList = ['Masuk', 'Keluar'];
  String tanggal_status = "Atur Tanggal Status";
  String waktu_status = "Atur Waktu Status";
  var form = {
    'barang_bukti_id': '10',
    'tanggal_status': '',
    'waktu_status': '',
    'jumlah': '',
    'satuan': 'gram',
    'keterangan': '',
    'status': 'Masuk'
  };
  // rest of our code
  @override
  void initState() {
    getBarangBukti();
    super.initState();
  }

   Widget rowBarangBukti(BarangBukti bb){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
          child: Text('${bb.nama} (${bb.id})',
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
               searchTextFieldTersangka = AutoCompleteTextField<BarangBukti>(
                key: keys,
                clearOnSubmit: false,
                suggestions: barangBuktis,
                decoration: InputDecoration(
                  labelText: 'Nama Barang Bukti',
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
                    form['barang_bukti_id'] = item.id.toString();
                  });
                },
                itemBuilder: (context, item){
                  // ui for autocomplete
                  return rowBarangBukti(item);
                },
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
                    tanggal_status = '${date.day}-${date.month}-${date.year}';
                    setState(() {
                      form['tanggal_status'] = tanggal_status;
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
                                  " $tanggal_status",
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
                    print('confirm $time');
                    waktu_status = '${time.hour}:${time.minute}:${time.second}';
                    setState(() {
                      form['waktu_status'] = waktu_status;
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
                                  " $waktu_status",
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
                        "  Change",
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
                    form['jumlah'] = val;
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Jumlah',
                  icon: Icon(Icons.assignment_turned_in),
                ),
              ),
              DropdownButtonFormField(
                onSaved: (val) => print(val),
                value: form['satuan'],
                items: satuanList.map<DropdownMenuItem>(
                  (val) {
                    return DropdownMenuItem(
                      child: Text(val.toString()),
                      value: val.toString(),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  setState(() {
                    form['satuan'] = val.toString();
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Satuan',
                  icon: Icon(Icons.assignment_turned_in),
                ),
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
              DropdownButtonFormField(
                onSaved: (val) => print(val),
                value: form['status'],
                items: statusList.map<DropdownMenuItem>(
                  (val) {
                    return DropdownMenuItem(
                      child: Text(val.toString()),
                      value: val.toString(),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  setState(() {
                    form['status'] = val.toString();
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Status',
                  icon: Icon(Icons.assignment_turned_in),
                ),
              ),
              RaisedButton(
                child: Text('Submit'),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () async {
                   bbStatus(null, form).then((response) async {
                     if (response.containsKey('id')){
                      final snackBar = SnackBar(content: Text('Status Barang Bukti Berhasil Disimpan'));
                      Scaffold.of(context).showSnackBar(snackBar);
                    } else {
                      final snackBar = SnackBar(content: Text('Gagal Menyimpan Status Barang Bukti'));
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