import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../../services/request.dart';
import 'package:andro/widget/inputForm/model/lkn.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'dart:convert';

class LKNForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form LKN';

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
  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<Lkn>> key = new GlobalKey();
  static List<Lkn> lkns = new List<Lkn>();
  TextEditingController _noLKNController = TextEditingController();

  bool loading = true;
  void getLkns() async {
    try {
      final response = await suggestionList(null);
      if(response.statusCode == 200){
        lkns = loadLkns(response.body);
        setState(() {
          loading = false;
        });
        print('lkns: ${lkns.length}');
      } else {
        print("Error getting lkn list");
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      print("Error getting lkn list");
    }
  }

  static List<Lkn> loadLkns(String jsonString){
    print(jsonString);
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Lkn>((json) => Lkn.fromJson(json)).toList();
  }
  final _formKey = GlobalKey<FormState>();
  String _date = "Belum Diatur";
  var form = {
    'LKN': '',
    'tgl_dibuat': '',
  };

  // rest of our code
   @override
  void initState() {
    getLkns();
    super.initState();
  }

   Widget row(Lkn lkn){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
          child: Text('${lkn.lkn}',
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
              searchTextField = AutoCompleteTextField<Lkn>(
                key: key,
                clearOnSubmit: false,
                suggestions: lkns,
                decoration: InputDecoration(
                  labelText: 'Pilih No.LKN',
                  icon: Icon(Icons.assignment_turned_in),
                ),
                itemFilter: (item, query){
                  return item.lkn.toLowerCase().startsWith(query.toLowerCase());
                },
                itemSorter: (a, b){
                  return a.lkn.compareTo(b.lkn);
                },
                itemSubmitted: (item) async {
                  lknSingleData(item.id).then((response) async {
                     if (response.containsKey('id')){
                        setState(() {
                          form['LKN'] = response['LKN'] ?? '';
                          form['tgl_dibuat'] = (response['tgl_dibuat'] ?? ''.toString());
                        });
                        print(response['tgl_dibuat']);
                        _noLKNController.text = response['LKN'] ?? '';
                        _date = (response['tgl_dibuat'] ?? 'Belum diatur'.toString());
                        print(response);
                     } else {
                      final snackBar = SnackBar(content: Text('Data Gagal Ditemukan'));
                      Scaffold.of(context).showSnackBar(snackBar);
                    }
                  });
                  setState(() {
                    searchTextField.textField.controller.text = item.lkn;
                    form['id'] = item.id.toString();
                  });
                },
                itemBuilder: (context, item){
                  // ui for autocomplete
                  return row(item);
                },
              ),
              TextFormField(
                controller: _noLKNController,
                onChanged: (val) {
                  setState(() {
                    form['LKN'] = val.toString();
                  });
                },
                decoration: InputDecoration(
                  labelText: 'No. LKN',
                  icon: Icon(Icons.assignment_turned_in),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(text: 'Tanggal Dibuat', style: TextStyle(fontWeight: FontWeight.bold)),
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
                    print('confirm $date');
                    _date = '${date.day}-${date.month}-${date.year}';
                    setState(() {
                      form['tgl_dibuat'] = _date;
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
                                  " $_date",
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
                child: Text('Submit'),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () async {
                print(form);
                print(form['id']);
                if(form['id']==null){
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Tolong pilih LKN')));
                  return;
                }
                lkn(int.parse(form['id']), form).then((response){
                  if (response.containsKey('id')){
                    final snackBar = SnackBar(content: Text('LKN Disimpan'));
                    Scaffold.of(context).showSnackBar(snackBar);
                  } else {
                    final snackBar = SnackBar(content: Text('Berkas LKN Sudah Ada'));
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