import 'package:flutter/material.dart';
import 'package:smarthome/pages/config.dart';
import 'package:smarthome/admin/temlets/RoundedBTN.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  List colors = [Colors.black87, null];
  double btnwidth = 60;
  List items = [1, 2];
  int currentPage = 0;
  final Pcontroller = PageController();
  List<String> item = [];
  String? value;
  List<dynamic> _RoomsP = [true, true, true, true, true, true];
  DropdownMenuItem<String> buildMenuItem(String Item) => DropdownMenuItem(
      value: Item,
      child: Text(
        Item,
        style: TextStyle(fontSize: 20, color: Colors.black),
      ));
  GetUsers() {
    item = [];
    FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          item.add((doc["name"]));
        });
      });
    });
  }

  UpdateRooms() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('name', isEqualTo: value);
  }

  GetUserP() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('name', isEqualTo: value)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        setState(() {
          _RoomsP = element["rooms"];
          print(element["rooms"]);
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
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        title: Text(
          "Users Controle Panel ",
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: Column(children: [
        SizedBox(
          height: Height! / 7,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RoundedBTN(
              color: colors[0],
              onTab: () {
                setState(() {
                  // Pcontroller.animateToPage(0,duration: Duration(seconds: 1), curve: Curves.ease);
                  Pcontroller.jumpToPage(0);
                });
              },
              width: btnwidth,
              icon: Icons.edit_outlined,
            ),
            RoundedBTN(
              color: colors[1],
              onTab: () {
                setState(() {
                  // Pcontroller.animateToPage(1, duration: Duration(seconds: 1), curve: Curves.ease);
                  Pcontroller.jumpToPage(1);
                });
              },
              width: btnwidth,
              icon: Icons.delete_outline_rounded,
            ),
          ],
        ),
        Expanded(
          child: PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (i) {
              setState(() {
                currentPage = i;
                colors = [null, null];
                colors[i] = Colors.black87;
              });
            },
            controller: Pcontroller,
            itemCount: items.length,
            itemBuilder: (context, i) {
              if (i == 0) {
                return Container(
                  child: Column(children: [
                    SizedBox(
                      height: Height! * 0.05,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                    MainAxisAlignment.spaceAround,
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
                                    MainAxisAlignment.spaceAround,
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
                                    MainAxisAlignment.spaceAround,
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
                                    MainAxisAlignment.spaceAround,
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
                                    MainAxisAlignment.spaceAround,
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
                  ]),
                );
              } else {
                return Container();
              }
            },
          ),
        )
      ]),
    );
  }
}
