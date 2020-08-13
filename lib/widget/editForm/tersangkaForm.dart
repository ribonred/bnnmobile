import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../../services/request.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:mime/mime.dart';

class tersangkaForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Tersangka';

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
  final List optionList = ['laki-laki', 'perempuan'];
  var form = {
    'no_penangkapan_id': '28',
    'nama_tersangka': '',
    'umur': '',
    'jenis_kelamin': 'laki-laki',
    'foto': '',
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
                    form['umur'] = val;
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Umur',
                  icon: Icon(Icons.assignment_turned_in),
                ),
              ),
              DropdownButtonFormField(
                onSaved: (val) => print(val),
                value: form['jenis_kelamin'],
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
                    form['jenis_kelamin'] = val.toString();
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Jenis Kelamin',
                  icon: Icon(Icons.assignment_turned_in),
                ),
              ),
              RaisedButton(
                child: Text('Upload Foto'),
                onPressed: () async {
                  // File file = await FilePicker.getFile();
                  String filePath = await FilePicker.getFilePath(type: FileType.custom, allowedExtensions: ['jpg', 'jpeg', 'png']);
                  print(filePath);
                  if (["", null].contains(filePath)) {
                    print('foto kosong');
                  } else {
                    String mimeStr = lookupMimeType(filePath);
                    var fileType = mimeStr.split('/');
                    print(fileType[1]);
                    if (['jpg', 'jpeg', 'png'].contains(fileType[1])) {
                      setState(() {
                        form['foto'] = filePath;
                      });
                    } else {
                      print('wrong file type');
                      //do alert for wrong type
                    }
                  }
              }),
              RaisedButton(
                child: Text('Submit'),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () async {
                  print(form);
                  tsk(null, form).then((response) async {
                    print('response');
                    print(response);
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