import 'package:flutter/material.dart';
import 'package:smarthome/pages/config.dart';

import 'package:smarthome/admin/temlets/costum_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Admin extends StatefulWidget {
  Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final _auth = FirebaseAuth.instance;

  List<dynamic> rooms = [true, true, true];
  String? username;
  bool _saving = false;

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      // drawer: Drawer(),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () async {
                    await _auth.signOut();
                    Navigator.of(context).pushReplacementNamed("login");
                  },
                  icon: Icon(
                    Icons.logout,
                    size: 40,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("home");
                  },
                  icon: Icon(
                    Icons.home,
                    size: 40,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("setting");
                  },
                  icon: Icon(
                    Icons.settings,
                    size: 40,
                    color: Colors.black,
                  ))
            ],
          ),
        ),
      ),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: Container(
          height: 0.9 * Height!,
          width: Width,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 5.0, // soften the shadow
                  spreadRadius: 0.0, //extend the shadow
                  offset: Offset(
                    0.0, // Move to right 10  horizontally
                    3.0, // Move to bottom 10 Vertically
                  ),
                )
              ],
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(60),
              )),
          child: Container(
            width: Width! * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Admin Panel",
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                ),
                Expanded(
                  child: GridView.count(
                      padding: const EdgeInsets.all(30),
                      primary: false,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0,
                      crossAxisCount: 2,
                      children: [
                        tapbutton(
                          text: "Add User",
                          img: "images/bedroom.png",
                          Width: Width!,
                          visibel: rooms[0],
                          ontab: () {
                            setState(() {
                              ////////
                            });
                            Navigator.pushNamed(context, "adduser");
                          },
                        ),
                        tapbutton(
                          text: "Edit Permission",
                          img: "images/living-room.png",
                          Width: Width!,
                          visibel: rooms[1],
                          ontab: () {
                            // Roomname = "Living Room";
                            Navigator.pushNamed(context, "edituser");
                          },
                        ),
                        tapbutton(
                          text: "Rooms",
                          img: "images/kitchen.png",
                          Width: Width!,
                          visibel: rooms[2],
                          ontab: () {
                            // Roomname = "kitchen";
                            Navigator.pushNamed(context, "home");
                          },
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
