import 'package:flutter/material.dart';
import './pages/login.page.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import './services/request.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import './pages/menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    await FlutterDownloader.initialize(
    debug: true // optional: set false to disable printing logs to console
  );
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
