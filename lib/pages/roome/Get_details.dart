import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Get_details extends StatefulWidget {
  Get_details({Key? key}) : super(key: key);

  @override
  State<Get_details> createState() => _Get_detailsState();
}

class _Get_detailsState extends State<Get_details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("details page"),
      ),
    );
  }
}
