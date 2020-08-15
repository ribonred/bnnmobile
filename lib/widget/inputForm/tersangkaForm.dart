import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import '../../services/request.dart';
import 'package:file_picker/file_picker.dart';
import 'package:andro/widget/inputForm/model/penangkapan.dart';
import 'package:mime/mime.dart';
import 'dart:convert';
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
  AutoCompleteTextField searchTextFieldPenangkapan;

  GlobalKey<AutoCompleteTextFieldState<Penangkapan>> keys = new GlobalKey();

  static List<Penangkapan> penangkapans = new List<Penangkapan>();

  final _formKey = GlobalKey<FormState>();
  
  String selectedOption;
  bool loading = true;
  void getPenangkapan() async {
    try {
      final response = await suggestionList('PNKP');
      if(response.statusCode == 200){
        penangkapans = loadPenangkapan(response.body);
        setState(() {
          loading = false;
        });
      } else {
        print("Error getting penangkapan list");
      }
    } catch (e) {
      print(e);
      setState(() {
        loading = false;
      });
      print("Error getting tersangka list");
    }
  }

  static List<Penangkapan> loadPenangkapan(String jsonString){
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Penangkapan>((json) => Penangkapan.fromJson(json)).toList();
  }

  final List optionList = ['laki-laki', 'perempuan'];
  var form = {
    'no_penangkapan_id': '',
    'nama_tersangka': '',
    'umur': '',
    'jenis_kelamin': 'laki-laki',
    'foto': '',
  };
  // rest of our code
   @override
  void initState() {
    getPenangkapan();
    print(penangkapans);
    super.initState();
  }
   Widget rowPenangkapan(Penangkapan pnkp){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
          child: Text('${pnkp.penangkapan} (${pnkp.id})',
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
              searchTextFieldPenangkapan = AutoCompleteTextField<Penangkapan>(
                key: keys,
                clearOnSubmit: false,
                suggestions: penangkapans,
                decoration: InputDecoration(
                  labelText: 'SP KAP',
                  icon: Icon(Icons.assignment_turned_in),
                ),
                itemFilter: (item, query){
                  return item.penangkapan.toLowerCase().startsWith(query.toLowerCase());
                },
                itemSorter: (a, b){
                  return a.penangkapan.compareTo(b.penangkapan);
                },
                itemSubmitted: (item){
                  setState(() {
                    searchTextFieldPenangkapan.textField.controller.text = item.penangkapan;
                    form['no_penangkapan_id'] = item.id.toString();
                  });
                },
                itemBuilder: (context, item){
                  // ui for autocomplete
                  return rowPenangkapan(item);
                },
              ),
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
               Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: ' FilePath : ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: form['foto'], style: TextStyle(fontStyle: FontStyle.italic)),
                  ],
                ),
              ),
              RaisedButton(
                child: Text('Submit'),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () async {
                  print(form);
                  tsk(null, form).then((response) async {
                     if (response.containsKey('id')){
                      final snackBar = SnackBar(content: Text('Tersangka Berhasil Disimpan'));
                      Scaffold.of(context).showSnackBar(snackBar);
                    } else {
                      final snackBar = SnackBar(content: Text('Gagal Menyimpan Tersangka'));
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