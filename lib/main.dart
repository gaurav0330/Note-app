import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:googlenoteclone/home.dart';
import 'package:googlenoteclone/login.dart';
import 'package:googlenoteclone/services/login_info.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatefulWidget {


  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  bool isLogIn = false;
  getLoggedInState() async{
    await LocalDataSaver.getLogData().then((value){
      setState(() {
        isLogIn = value.toString() == "null";
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getLoggedInState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Keep Note',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: isLogIn ? Login(): const Home(),
    );
  }
}