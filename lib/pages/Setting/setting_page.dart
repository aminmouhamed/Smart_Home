import 'dart:convert';
import 'dart:ui';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:smarthome/pages/config.dart';
import 'package:smarthome/pages/login/templets/button.dart';

class Setting extends StatefulWidget {
  Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  late String ssid;
  late String password;
  late String o;
  Socket? socket;
  Future<bool> esp32_config() async {
    try {
      // function to config wifi of isp32
      socket = await Socket.connect("192.168.4.1", 8080);

      /// connect to esp32 tcp server

      socket!.listen((onData) async {
        print(String.fromCharCodes(onData).trim());
        if (String.fromCharCodes(onData).trim() == 'h') {
          socket!.add(utf8.encode(ssid));
        }
        if (String.fromCharCodes(onData).trim() == 'o') {
          socket!.add(utf8.encode(password));
          await Future.delayed(Duration(seconds: 5));
          socket!.close();
          return;
        }
      });
      //await Future.delayed(Duration(seconds: 1));
      //socket!.add(utf8.encode(password));

    } catch (e) {
      //await Future.delayed(Duration(seconds: 5));
      //socket!.close();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
          backgroundColor: therdColor,
        ),
        body: Column(
          children: [
            SizedBox(
              height: Height! * 0.05,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  Container(
                    //height: Height / 2,
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
                        color: therdColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        )),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "Config Wifi of Esp 32",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          child: Column(
                            children: [
                              TextField(
                                onChanged: (value) {
                                  ssid = value;
                                },
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                    hintText: "SSID",
                                    filled: true,
                                    fillColor: fieldColor,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(80)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: primerycolor),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(80)))),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextField(
                                onChanged: (value) {
                                  password = value;
                                },
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                    hintText: "Password",
                                    filled: true,
                                    fillColor: fieldColor,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(80)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: primerycolor),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(80)))),
                              ),
                            ],
                          ),
                        ),
                      ),
                      button(
                          TEXT: "Config",
                          function: () async {
                            if (await esp32_config()) {
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.LEFTSLIDE,
                                headerAnimationLoop: false,
                                dialogType: DialogType.SUCCES,
                                showCloseIcon: true,
                                title: 'Succes',
                                desc: 'Esp 32 is configired ',
                                btnOkOnPress: () {
                                  Navigator.of(context).pushNamed("login");
                                },
                                btnOkIcon: Icons.check_circle,
                                onDissmissCallback: (type) {
                                  debugPrint(
                                      'Dialog Dissmiss from callback $type');
                                },
                              ).show();
                            } else {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.ERROR,
                                animType: AnimType.RIGHSLIDE,
                                headerAnimationLoop: true,
                                title: 'Error',
                                desc: 'Esp not connected ! .',
                                btnOkOnPress: () {},
                                btnOkIcon: Icons.cancel,
                                btnOkColor: Colors.red,
                              )..show();
                            }
                          }),
                      SizedBox(
                        height: 20,
                      )
                    ]),
                  )
                ],
              ),
            ))
          ],
        ));
  }
}
