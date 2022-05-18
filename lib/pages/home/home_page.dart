import 'package:flutter/material.dart';
import 'package:smarthome/pages/config.dart';
import 'package:smarthome/pages/home/templets/costum_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _auth = FirebaseAuth.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  @override
  void initState() {
    _fcm.getToken().then((token) {
      FirebaseFirestore.instance.collection("tokens").add({
        "tokens": {
          "token": token,
        },
      });
    });
    super.initState();
  }

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
                    color: primerycolor,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("home");
                  },
                  icon: Icon(
                    Icons.home,
                    size: 40,
                    color: primerycolor,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("setting");
                  },
                  icon: Icon(
                    Icons.settings,
                    size: 40,
                    color: primerycolor,
                  ))
            ],
          ),
        ),
      ),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
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
            color: SecendaryColor,
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
                  "Hello, Karim !",
                  style: TextStyle(fontSize: 25, color: primerycolor),
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
                        text: "Bedroom",
                        img: "images/bedroom.png",
                        Width: Width!,
                        ontab: () {
                          setState(() {
                            Roomname = "Bedroom";
                          });
                          Navigator.pushNamed(context, "room");
                        },
                      ),
                      tapbutton(
                        text: "Living Room",
                        img: "images/living-room.png",
                        Width: Width!,
                        ontab: () {
                          Roomname = "Living Room";
                          Navigator.pushNamed(context, "room");
                        },
                      ),
                      tapbutton(
                        text: "kitchen",
                        img: "images/kitchen.png",
                        Width: Width!,
                        ontab: () {
                          Roomname = "kitchen";
                          Navigator.pushNamed(context, "room");
                        },
                      ),
                      tapbutton(
                        text: "Bath Room",
                        img: "images/toilet.png",
                        Width: Width!,
                        ontab: () {
                          Roomname = "Bath Room";
                          Navigator.pushNamed(context, "room");
                        },
                      ),
                      tapbutton(
                        text: "Dinning Room",
                        img: "images/dinning-table.png",
                        Width: Width!,
                        ontab: () {
                          Roomname = "Dinning Room";
                          Navigator.pushNamed(context, "room");
                        },
                      ),
                      tapbutton(
                        text: "Office",
                        img: "images/workspace.png",
                        Width: Width!,
                        ontab: () {
                          Roomname = "Office";
                          Navigator.pushNamed(context, "room");
                        },
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
