import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../../services/request.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:async';
import 'dart:io';

class exampleForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form LKN';

    return MaterialApp(
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
  final List optionList = ['Penangkapan', 'Penangkapan 2', 'Penangkapan 3'];
  String _date = "Not set";
  String _time = "Not set";
  var form = {
    'no_penangkapan': '',
    'no_lkn': '',
    'dropdown': '',
    'textArea': '',
    'tanggal_penangkapan': '',
    'time': ''
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
                    form['no_penangkapan'] = val.toString();
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Text Input Example',
                  icon: Icon(Icons.assignment_turned_in),
                ),
              ),
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    form['no_lkn'] = val;
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Number Text Input Example',
                  icon: Icon(Icons.assignment_turned_in),
                ),
              ),
              DropdownButtonFormField(
                onSaved: (val) => print(val),
                value: selectedOption,
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
                    form['dropdown'] = val.toString();
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Option Example',
                  icon: Icon(Icons.assignment_turned_in),
                ),
              ),
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    form['textArea'] = val.toString();
                  });
                },
                maxLines: 8,
                decoration: InputDecoration(
                  labelText: 'Text Area Example',
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
                      maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
                    print('confirm $date');
                    _date = '${date.day}-${date.month}-${date.year}';
                    setState(() {
                      form['tanggal_penangkapan'] = _date;
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
                    _time = '${time.hour} : ${time.minute} : ${time.second}';
                    setState(() {
                      form['time'] = _time;
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
                                  " $_time",
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
            RaisedButton(
              child: Text('Choose file'),
              onPressed: () async {
                File file = await FilePicker.getFile();
                print('file');
                print(file);
                print('file');
            })
            ]
          ),
        )
      ),
    );
  }
}