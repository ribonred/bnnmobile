import 'package:flutter/material.dart';
import './pages/login.page.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import './services/request.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import './pages/menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String token = await storage.read(key: 'plugin');
  if (token == null) {
    await FlutterDownloader.initialize(
        debug: true // optional: set false to disable printing logs to console
        );
    await storage.write(key: 'plugin', value: 'reg');
  }

  Map verify = await verifyToken();
  var status = verify['isVerified'] ?? false;
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: status == true
        ? Dashboard(text: 'Hello', user: verify['data']['user']['role'])
        : LoginPage(),
    debugShowCheckedModeBanner: false,
  ));
}

// class MyApp extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: LoginPage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
