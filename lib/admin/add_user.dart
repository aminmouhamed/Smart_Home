import 'package:flutter/material.dart';
import 'package:smarthome/pages/config.dart';

import 'package:smarthome/pages/home/home_page.dart';
import 'package:smarthome/pages/login/templets/button.dart';
import 'package:smarthome/admin/temlets/login_forms.dart';
import 'package:smarthome/pages/login/templets/logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class AddUser extends StatefulWidget {
  AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();
  TextEditingController UserName = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool _saving = false;
  bool isSwitched = false;

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModalProgressHUD(
            inAsyncCall: _saving,
            child: ListView(children: [
              SizedBox(
                height: Height! * 0.1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
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
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            "User Informations",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 0, left: 20, right: 20),
                          child: Container(
                            child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextInput(
                                      ktype: TextInputType.emailAddress,
                                      Error: "Please Enter your User Name",
                                      i_controller: UserName,
                                      text: "User Name",
                                      icon: Icons.person,
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        child: TextInput(
                                          ktype: TextInputType.emailAddress,
                                          Error: "Please Enter your email",
                                          i_controller: Email,
                                          text: "Email",
                                          icon: Icons.email,
                                        )),
                                    TextInput(
                                      Error: "Please Enter password !",
                                      i_controller: Password,
                                      text: "Password",
                                      icon: Icons.lock,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            "Admin",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          Switch(
                                            activeColor: Colors.black,
                                            value: isSwitched,
                                            onChanged: (value) {
                                              setState(() {
                                                isSwitched = value;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        )
                      ],
                    )),
              ),
            ])));
  }
}
