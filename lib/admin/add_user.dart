import 'package:flutter/material.dart';
import 'package:smarthome/pages/config.dart';

import 'package:smarthome/pages/home/home_page.dart';
import 'package:smarthome/admin/temlets/button.dart';
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
  late UserCredential _user;
  final _fstore = FirebaseFirestore.instance;
  bool _saving = false;
  bool _isAdmin = false;
  List<bool> _RoomsP = [true, true, true, true, true, true];

  addUser() async {
    try {
      _user = await _auth.createUserWithEmailAndPassword(
          email: Email.text, password: Password.text);

      if (_user != null) {
        _fstore.collection("users").doc(_user.user!.uid).set({
          "admin": _isAdmin,
          "name": UserName.text,
          "rooms": _RoomsP,
        });
      }
      AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.SUCCES,
        showCloseIcon: true,
        title: 'Succes',
        desc: 'user id add !. ',
        btnOkOnPress: () {
          debugPrint('OnClcik');
        },
        btnOkIcon: Icons.check_circle,
        onDissmissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        },
      ).show();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.RIGHSLIDE,
            headerAnimationLoop: true,
            title: 'Error',
            desc: "email already in use ! .",
            btnOkOnPress: () {},
            btnOkIcon: Icons.cancel,
            btnOkColor: Colors.red,
          ).show();
          break;

        case "invalid-email":
          AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.RIGHSLIDE,
            headerAnimationLoop: true,
            title: 'Error',
            desc: "invalid email ! .",
            btnOkOnPress: () {},
            btnOkIcon: Icons.cancel,
            btnOkColor: Colors.red,
          ).show();
          break;

        case "operation-not-allowed":
          AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.RIGHSLIDE,
            headerAnimationLoop: true,
            title: 'Error',
            desc: "operation not allowed ! .",
            btnOkOnPress: () {},
            btnOkIcon: Icons.cancel,
            btnOkColor: Colors.red,
          ).show();
          break;

        case "weak-password":
          AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.RIGHSLIDE,
            headerAnimationLoop: true,
            title: 'Error',
            desc: "weak password ! .",
            btnOkOnPress: () {},
            btnOkIcon: Icons.cancel,
            btnOkColor: Colors.red,
          ).show();
          break;
      }
    }
  }

  Widget room_switsh(String Rname, bool val) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            Rname,
            style: TextStyle(fontSize: 20),
          ),
          Switch(
            activeColor: Colors.black,
            value: val,
            onChanged: (value) {
              setState(() {
                val = value;
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModalProgressHUD(
            inAsyncCall: _saving,
            child: ListView(children: [
              SizedBox(
                height: Height! * 0.01,
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
                                      Error: "Please check user informations !",
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
                                            value: _isAdmin,
                                            onChanged: (value) {
                                              setState(() {
                                                _isAdmin = value;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: Height! * 0.01,
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
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "User Prermisiont",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Bedroom",
                              style: TextStyle(fontSize: 20),
                            ),
                            Switch(
                              activeColor: Colors.black,
                              value: _RoomsP[0],
                              onChanged: (value) {
                                setState(() {
                                  _RoomsP[0] = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Living Room",
                              style: TextStyle(fontSize: 20),
                            ),
                            Switch(
                              activeColor: Colors.black,
                              value: _RoomsP[1],
                              onChanged: (value) {
                                setState(() {
                                  _RoomsP[1] = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "kitchen",
                              style: TextStyle(fontSize: 20),
                            ),
                            Switch(
                              activeColor: Colors.black,
                              value: _RoomsP[2],
                              onChanged: (value) {
                                setState(() {
                                  _RoomsP[2] = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Bath Room",
                              style: TextStyle(fontSize: 20),
                            ),
                            Switch(
                              activeColor: Colors.black,
                              value: _RoomsP[3],
                              onChanged: (value) {
                                setState(() {
                                  _RoomsP[3] = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Dinning Room",
                              style: TextStyle(fontSize: 20),
                            ),
                            Switch(
                              activeColor: Colors.black,
                              value: _RoomsP[4],
                              onChanged: (value) {
                                setState(() {
                                  _RoomsP[4] = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Office",
                              style: TextStyle(fontSize: 20),
                            ),
                            Switch(
                              activeColor: Colors.black,
                              value: _RoomsP[5],
                              onChanged: (value) {
                                setState(() {
                                  _RoomsP[5] = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ]),
                  )),
              button(
                  TEXT: "submit",
                  function: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _saving = true;
                      });

                      addUser();

                      setState(() {
                        _saving = false;
                      });
                    }
                  })
            ])));
  }
}
