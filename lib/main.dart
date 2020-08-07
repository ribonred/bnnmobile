import 'package:flutter/material.dart';
import './pages/login.page.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import './services/request.dart';
import './pages/menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
    debug: true // optional: set false to disable printing logs to console
  );
  Map verify = await verifyToken(); 
  var status = verify['isVerified'] ?? false;
  print('verify');
  print(verify);
  print(status);
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: status == true ? Dashboard(text: 'Hello') : LoginPage(),
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