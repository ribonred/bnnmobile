import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = new FlutterSecureStorage();

String baseUrl = 'http://178.128.80.233:8000/';

Future<String> getToken() async {
    final token = await storage.read(key: 'token');
    return token;
  }

Future<bool> login(String username, String password) async {
  bool status;
  print('${baseUrl}get-token/token-auth/');
  await http.post('${baseUrl}get-token/token-auth/', headers: {
    'Accept': 'application/json'
  }, body: {
    "username": username,
    "password": password
  }).then((response) async {
    print(response.statusCode);
    if (response.statusCode == 200){
      var content = json.decode(response.body);
      await storage.write(key: 'token', value: content['token']);
      status = true;
      // Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => Dashboard()));
    } else {
      status = false;
    }
  });
  print('status');
  print(status);
  return Future.value(status);
}

Future<Map> lkn(String lknId) async {
  String token = await getToken();
  Map content;
  await http.get('${baseUrl}mobile-api/lkn/', headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  }).then((response) async {
    print(response.statusCode);
    if (response.statusCode == 200){
      content = json.decode(response.body);
      // await storage.write(key: 'token', value: content['token']);
      // Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => Dashboard()));
    } else {
      content = json.decode(response.body);
    }
  });
  return Future.value(content);
}

Future<Map> pnkp(String lknId) async {
  String token = await getToken();
  Map content;
  await http.get('${baseUrl}mobile-api/penangkapan/', headers: {
    'Accept': 'application/json',
    'Authorization':'Bearer $token'
  }).then((response) async {
    print(response.statusCode);
    if (response.statusCode == 200){
      content = json.decode(response.body);
      // await storage.write(key: 'token', value: content['token']);
      // Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => Dashboard()));
    } else {
      content = json.decode(response.body);
    }
  });
  return Future.value(content);
}

Future<Map> bb(String bbId) async {
  String token = await getToken();
  Map content;
  await http.get('${baseUrl}mobile-api/barangbukti/', headers: {
    'Accept': 'application/json',
    'Authorization':'Bearer $token'
  }).then((response) async {
    print(response.statusCode);
    if (response.statusCode == 200){
      content = json.decode(response.body);
      // await storage.write(key: 'token', value: content['token']);
      // Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => Dashboard()));
    } else {
      content = json.decode(response.body);
    }
  });
  return Future.value(content);
}

Future<List> bbStatus(String bbId) async {
  String token = await getToken();
  List content;
  await http.get('${baseUrl}api/bb-status-app/', headers: {
    'Accept': 'application/json',
    'Authorization':'Bearer $token'
  }).then((response) async {
    print(response.statusCode);
    if (response.statusCode == 200){
      content = json.decode(response.body);
      // await storage.write(key: 'token', value: content['token']);
      // Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => Dashboard()));
    } else {
      content = json.decode(response.body);
    }
  });
  return Future.value(content);
}

Future<Map> tsk(String tskId) async {
  String token = await getToken();
  Map content;
  await http.get('${baseUrl}mobile-api/tersangka/', headers: {
    'Accept': 'application/json',
    'Authorization':'Bearer $token'
  }).then((response) async {
    print(response.statusCode);
    if (response.statusCode == 200){
      content = json.decode(response.body);
      // await storage.write(key: 'token', value: content['token']);
      // Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => Dashboard()));
    } else {
      content = json.decode(response.body);
    }
  });
  return Future.value(content);
}

Future<List> tskProses(String tskId) async {
  String token = await getToken();
  List content;
  await http.get('${baseUrl}api/tsk-proses/', headers: {
    'Accept': 'application/json',
    'Authorization':'Bearer $token'
  }).then((response) async {
    print(response.statusCode);
    if (response.statusCode == 200){
      content = json.decode(response.body);
      // await storage.write(key: 'token', value: content['token']);
      // Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => Dashboard()));
    } else {
      content = json.decode(response.body);
    }
  });
  return Future.value(content);
}