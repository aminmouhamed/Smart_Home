import 'package:flutter/material.dart';
import 'package:smarthome/admin/temlets/button.dart';
import 'package:smarthome/pages/config.dart';
import 'package:smarthome/admin/temlets/RoundedBTN.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class User {
  String UserName = "";
  String UserUID = "";
  List<bool> UserRooms = [false, false, false, false, false, false];
}

class EditUser extends StatefulWidget {
  EditUser({Key? key}) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  List<String> item = [];
  String? value;
  List<dynamic> _RoomsP = [true, true, true, true, true, true];
  bool _saving = false;
  DropdownMenuItem<String> buildMenuItem(String Item) => DropdownMenuItem(
      value: Item,
      child: Text(
        Item,
        style: TextStyle(fontSize: 20, color: Colors.black),
      ));
  GetUsers() {
    setState(() {
      _saving = true;
    });
    item = [];
    FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          // print(doc.id);
          item.add(doc["name"]);
          _saving = false;
        });
      });
      value = item[0];
    });
  }

  UpdateRooms() async {
    try {
      setState(() {
        _saving = true;
      });
      final post = await FirebaseFirestore.instance
          .collection('users')
          .where('name', isEqualTo: value)
          .limit(1)
          .get()
          .then((QuerySnapshot snapshot) {
        //Here we get the document reference and return to the post variable.
        return snapshot.docs[0].reference;
      });

      var batch = FirebaseFirestore.instance.batch();
      //Updates the field value, using post as document reference
      batch.update(post, {'rooms': _RoomsP});
      batch.commit();
      setState(() {
        _saving = false;
      });
      AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.SUCCES,
        showCloseIcon: true,
        title: 'Succes',
        desc: 'user permissions is updated !. ',
        btnOkOnPress: () {},
        btnOkIcon: Icons.check_circle,
        onDissmissCallback: (type) {
          debugPrint('Dialog Dissmiss from callback $type');
        },
      ).show();
    } catch (e) {
      print(e);
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: true,
        title: 'Error',
        desc: 'bad internet !.',
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
      ).show();
      setState(() {
        _saving = false;
      });
    }
  }

  GetUserP() async {
    setState(() {
      _saving = true;
    });
    await FirebaseFirestore.instance
        .collection('users')
        .where('name', isEqualTo: value)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        setState(() {
          _RoomsP = element["rooms"];
          // print(element["rooms"]);
          _saving = false;
        });
      });
    });
  }

  @override
  void initState() {
    GetUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                UpdateRooms();
              },
              icon: Icon(
                Icons.check,
                color: Colors.black87,
              ))
        ],
        shadowColor: Colors.transparent,
        backgroundColor: Colors.grey,
        title: Text(
          "Users Controle Panel ",
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: ListView(children: [
        Column(children: [
          SizedBox(
            height: Height! / 7,
          ),
          Expanded(
            child: ModalProgressHUD(
              inAsyncCall: _saving,
              child: Container(
                child: Column(children: [
                  SizedBox(
                    height: Height! * 0.05,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    width: Width! * 0.5,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black87),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: DropdownButton<String>(
                        isExpanded: true,
                        value: value,
                        items: item.map(buildMenuItem).toList(),
                        onChanged: (val) => setState(() {
                              value = val!;
                              GetUserP();
                            })),
                  ),
                  SizedBox(
                    height: Height! * 0.05,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          //color: Colors.grey,
                          border: Border.all(),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                "User Permission",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                        ),
                      )),
                ]),
              ),
            ),
          )
        ]),
      ]),
    );
  }
}
