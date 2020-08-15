import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


final storage = new FlutterSecureStorage();

String baseUrl = 'http://178.128.80.233:8000/';

Future<String> getToken() async {
    String token = await storage.read(key: 'token');
    if (token == null){
      token = '';
    }
    return token;
  }

Future<bool> login(String username, String password) async {
  bool status;
  await http.post('${baseUrl}get-token/token-auth/', headers: {
    'Accept': 'application/json'
  }, body: {
    "username": username,
    "password": password
  }).then((response) async {
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
  return Future.value(status);
}

Future<Map> verifyToken() async {
  String token = await getToken();
  Map result = {
    "isVerified": false,
    "data": null
  };
  await http.post('${baseUrl}get-token/token-verify/', headers: {
    'Accept': 'application/json',
  }, body: {
    "token": token
  }).then((response) async {
    if (response.statusCode == 200){
      result['data'] = json.decode(response.body);
      result['isVerified'] = true;
    } else {
      result['data'] = json.decode(response.body);
      result['isVerified'] = false;
    }
  });
  
  return Future.value(result);
}

Future<Map> lkn(int lknId, var input) async {
  String token = await getToken();
  Map content;
  if (lknId==null && input!=null) {
    await http.post('${baseUrl}mobile-api/lkn/', headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: input).then((response) async {
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
  } else if (lknId==null) {
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
  } else
  {
    await http.get('${baseUrl}api/lkn-detail/$lknId', headers: {
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
  }
  
  return Future.value(content);
}

Future<Map> pnkp(int pnkpId, var input) async {
  String token = await getToken();
  Map content;
  if (pnkpId==null && input!=null)
  {
    Map<String, String> headers = { 'Authorization':'Bearer $token'};
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}mobile-api/penangkapan/'));
    request.headers.addAll(headers);

    if (["", null].contains(input['dokumen_penangkapan'])) {
      print('dokumen_penangkapan kosong');
    } else {
      request.files.add(
        await http.MultipartFile.fromPath('dokumen_penangkapan', input['dokumen_penangkapan'])
      );
    }

    if (["", null].contains(input['dokumen_sp_jangkap'])) {
      print('dokumen_sp_jangkap kosong');
    } else {
      request.files.add(
        await http.MultipartFile.fromPath('dokumen_sp_jangkap', input['dokumen_sp_jangkap'])
      );
    }

    request.fields['no_lkn'] = input['no_lkn'];
    request.fields['no_penangkapan'] = input['no_penangkapan'];
    request.fields['tanggal_penangkapan'] = input['tanggal_penangkapan'];
    request.fields['masa_berakhir_penangkapan'] = input['masa_berakhir_penangkapan'];
    request.fields['sp_jangkap'] = input['sp_jangkap'];
    request.fields['tanggal_sp_jangkap'] = input['tanggal_sp_jangkap'];
    request.fields['masa_berakhir_sp_jangkap'] = input['masa_berakhir_sp_jangkap'];

    await request.send().then((result) async {
      await http.Response.fromStream(result)
          .then((response) async {
        if (response.statusCode == 201)
        {
          content = json.decode(response.body);
          print("content");
          print(content);
        } else {
          print(response.statusCode);
          content = json.decode(response.body);
        }
      });
    }).catchError((err) => print('error : '+err.toString()))
        .whenComplete(()
    {});
  } 
  else if (pnkpId==null) 
  {
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
  }
  else
  {
    await http.get('${baseUrl}mobile-api/penangkapan/$pnkpId', headers: {
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
  }

  return Future.value(content);
}

Future<Map> bb(int bbId, var input) async {
  String token = await getToken();
  Map content;
  if (bbId==null && input!=null)
  {
    Map<String, String> headers = { 'Authorization':'Bearer $token'};
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}mobile-api/barangbukti/'));
    request.headers.addAll(headers);

    if (["", null].contains(input['sp_sita_doc'])) {
      print('sp_sita_doc kosong');
    } else {
      request.files.add(
        await http.MultipartFile.fromPath('sp_sita_doc', input['sp_sita_doc'])
      );
    }

    if (["", null].contains(input['tap_sita_doc'])) {
      print('tap_sita_doc kosong');
    } else {
      request.files.add(
        await http.MultipartFile.fromPath('tap_sita_doc', input['tap_sita_doc'])
      );
    }
    
    if (["", null].contains(input['tap_status_doc'])) {
      print('sp_sita_doc tap_status_doc');
    } else {
      request.files.add(
        await http.MultipartFile.fromPath('tap_status_doc', input['tap_status_doc'])
      );
    }
    
    if (["", null].contains(input['nomor_lab_doc'])) {
      print('nomor_lab_doc kosong');
    } else {
      request.files.add(
        await http.MultipartFile.fromPath('nomor_lab_doc', input['nomor_lab_doc'])
      );
    }

    request.fields['milik_tersangka_id'] = input['milik_tersangka_id'];
    request.fields['nama_barang'] = input['nama_barang'];
    request.fields['sp_sita'] = input['sp_sita'];
    request.fields['tap_sita'] = input['tap_sita'];
    request.fields['tap_status'] = input['tap_status'];
    request.fields['nomor_lab'] = input['nomor_lab'];
    request.fields['jenis_barang'] = input['jenis_barang'];
    
    await request.send().then((result) async {
      await http.Response.fromStream(result)
          .then((response) async {
        if (response.statusCode == 201)
        {
          content = json.decode(response.body);
          print("content");
          print(content);
        } else {
          print(response.statusCode);
          content = json.decode(response.body);
        }
      });
    }).catchError((err) => print('error : '+err.toString()))
        .whenComplete(()
    {});
  }
  else if (bbId!=null && input!=null)
  {

  }
  else if (bbId==null)
  {
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
  }
  else
  {
    await http.get('${baseUrl}mobile-api/barangbukti/$bbId', headers: {
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
  }
  
  return Future.value(content);
}

Future<Map> bbStatus(int bbId, var input) async {
  String token = await getToken();
  Map content;
  await http.post('${baseUrl}api/bb-status/', headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
  }, body: input).then((response) async {
    print('error');
    print(response);
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

Future<Map> tsk(int tskId, var input) async {
  String token = await getToken();
  Map content;
  if (tskId==null && input!=null)
  {
    Map<String, String> headers = { 'Authorization':'Bearer $token'};
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}mobile-api/tersangka/'));
    request.headers.addAll(headers);

    if (["", null].contains(input['foto'])) {
      print('foto kosong');
    } else {
      request.files.add(
        await http.MultipartFile.fromPath('foto', input['foto'])
      );
    }

    request.fields['no_penangkapan_id'] = input['no_penangkapan_id'];
    request.fields['nama_tersangka'] = input['nama_tersangka'];
    request.fields['umur'] = input['umur'];
    request.fields['jenis_kelamin'] = input['jenis_kelamin'];
    
    await request.send().then((result) async {
      await http.Response.fromStream(result)
          .then((response) async {
        if (response.statusCode == 201)
        {
          content = json.decode(response.body);
          print("content");
          print(content);
        } else {
          print(response.statusCode);
          content = json.decode(response.body);
        }
      });
    }).catchError((err) => print('error : '+err.toString()))
        .whenComplete(()
    {});
  }
  else if (tskId!=null && input!=null)
  {

  }
  else if (tskId==null)
  {
    await http.get('${baseUrl}mobile-api/tersangka/', headers: {
      'Accept': 'application/json',
      'Authorization':'Bearer $token'
    }).then((response) async {
      print(response.statusCode);
      if (response.statusCode == 200){
        content = json.decode(response.body);
      } else {
        content = json.decode(response.body);
      }
    });
  }
  else
  {
    await http.get('${baseUrl}mobile-api/tersangka/$tskId', headers: {
      'Accept': 'application/json',
      'Authorization':'Bearer $token'
    }).then((response) async {
      print(response.statusCode);
      if (response.statusCode == 200){
        content = json.decode(response.body);
      } else {
        content = json.decode(response.body);
      }
    });
  }
  
  return Future.value(content);
}

Future<Map> tskProses(int tskId, var input) async {
  String token = await getToken();
  Map content;
  if (tskId==null && input!=null)
  {
    Map<String, String> headers = { 'Authorization':'Bearer $token'};
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}api/tsk-proses/'));
    request.headers.addAll(headers);

    if (["", null].contains(input['sp_han_doc'])) {
      print('sp han doc kosong');
    } else {
      request.files.add(
        await http.MultipartFile.fromPath('sp_han_doc', input['sp_han_doc'])
      );
    }

    if (["", null].contains(input['tap_han_doc'])) {
      print('tap han doc kosong');
    } else {
      request.files.add(
        await http.MultipartFile.fromPath('tap_han_doc', input['tap_han_doc'])
      );
    }

    if (["", null].contains(input['surat_perpanjangan_han_doc'])) {
      print('surat_perpanjangan_han_doc kosong');
    } else {
      request.files.add(
        await http.MultipartFile.fromPath('surat_perpanjangan_han_doc', input['surat_perpanjangan_han_doc'])
      );
    }

    request.fields['proses_tersangka'] = input['proses_tersangka'];
    request.fields['keterangan'] = input['keterangan'];
    request.fields['jenis_proses'] = input['jenis_proses'].toString();
    request.fields['tanggal_mulai_proses'] = input['tanggal_mulai_proses'];
    request.fields['tanggal_akhir_proses'] = input['tanggal_akhir_proses'];
    request.fields['sp_han'] = input['sp_han'];
    request.fields['tap_han'] = input['tap_han'];
    request.fields['surat_perpanjangan_han'] = input['surat_perpanjangan_han'];

    
    await request.send().then((result) async {
      await http.Response.fromStream(result)
          .then((response) async {
        if (response.statusCode == 201)
        {
          content = json.decode(response.body);
          print("content");
          print(content);
        } else {
          print(response.statusCode);
          content = json.decode(response.body);
          print("content");
          print(content);
        }
      });
    }).catchError((err) => print('error : '+err.toString()))
        .whenComplete(()
    {});
  }
  return Future.value(content);
}

Future<Map> tskStatus(int tskId, var input) async {
  String token = await getToken();
  Map content;
  if (tskId==null && input!=null) {
    await http.post('${baseUrl}api/tsk-status/', headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: input).then((response) async {
      print(response.statusCode);
      if (response.statusCode == 201){
        content = json.decode(response.body);
      } else {
        content = json.decode(response.body);
      }
    });
  } else if (tskId!=null && input!=null) {
    //do put request
  }

  return Future.value(content);
}

suggestionList(String target) async {
  String token = await getToken();
  String url = '${baseUrl}api/lkn/';
  if (target == 'TSK') {
    url = '${baseUrl}api/tersangka/';
  } else if (target == 'PNKP') {
    url = '${baseUrl}api/pnkp/';
  } else if (target == 'BB'){
    url = '${baseUrl}api/bb-edit/';
  }
  var content;

  await http.get(url, headers: {
    'Accept': 'application/json',
    'Authorization':'Bearer $token'
  }).then((response) async {
    print('give response');
    print(response.statusCode);
    if (response.statusCode == 200){
      content = response;
    } else {
      content = response;
    }
  });
  print('content');
  print(content);
  return content;
}