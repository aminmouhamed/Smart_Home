import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smarthome/pages/Setting/setting_page.dart';
import 'package:smarthome/pages/config.dart';
import 'package:smarthome/pages/home/home_page.dart';
import 'package:smarthome/pages/login/login_page.dart';
import 'package:flutter/services.dart';
import 'package:smarthome/pages/roome/roome_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(SmartHome());
}

class SmartHome extends StatefulWidget {
  @override
  State<SmartHome> createState() => _SmartHomeState();
}

class _SmartHomeState extends State<SmartHome> {
  @override
  Widget build(BuildContext context) {
    //screen(context);
    return MaterialApp(
      onGenerateTitle: (context) {
        screen(context);
        return "Smart Home";
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "Inter",
          primaryColor: primerycolor,
          backgroundColor: SecendaryColor),
      title: "Smart Home",
      home: FirebaseAuth.instance.currentUser == null ? LogIn() : Home(),
      routes: {
        "login": (context) => LogIn(),
        "home": (context) => Home(),
        "room": (context) => Room(),
        "setting": (context) => Setting(),
      },
    );
  }
}
