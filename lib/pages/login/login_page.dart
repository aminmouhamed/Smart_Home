/*

that file contain all the component the creat a beutufful login page 

*/
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:smarthome/pages/config.dart';
import 'package:smarthome/pages/home/home_page.dart';
import 'package:smarthome/pages/login/templets/button.dart';
import 'package:smarthome/pages/login/templets/login_forms.dart';
import 'package:smarthome/pages/login/templets/logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LogIn extends StatefulWidget {
  // creat class login extends StatefulWidget
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _fstore = FirebaseFirestore.instance;
  late UserCredential _userCredential;

  bool _saving = false;
  set_hestory(String UserName) {
    // to send login hestory
    _fstore.collection("h_users").add({
      "user_name": UserName,
      "time": DateTime.now(),
    });
  }

  isadmin() {
    // to chek if user is admin or not
    _fstore
        .collection("users")
        .doc(_userCredential.user!.uid)
        .get()
        .then((DocumentSnapshot Snapshot) {
      final data = Snapshot.data() as Map<dynamic, dynamic>;
      setState(() {
        ADMIN = data["admin"];
        set_hestory(data["name"]);
        if (ADMIN) {
          Navigator.of(context).pushReplacementNamed("admin");
        } else {
          Navigator.of(context).pushReplacementNamed("home");
        }
      });
    });
  }

  /// design
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModalProgressHUD(
      inAsyncCall: _saving,
      child: ListView(children: [
        Container(
          height: 0.8 * Height!,
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
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60))),
          child: LayoutBuilder(builder: (context, constrain) {
            double containerWidht = constrain.maxWidth;
            double containerHeight = constrain.maxHeight;

            if (Width! > Height!) {
              double containerWidht = constrain.maxHeight;
              double containerHeight = constrain.maxWidth;
            }

            return Column(
              children: [
                SizedBox(
                  height: containerHeight * (1 / 8),
                ),
                logo(containerHeight),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                                padding:
                                    EdgeInsets.symmetric(vertical: HW! * 10),
                                child: TextInput(
                                  ktype: TextInputType.emailAddress,
                                  Error: "Please Enter your email",
                                  i_controller: Email,
                                  text: "Email",
                                  icon: Icons.email,
                                )),
                            TextInput(
                              obs: true,
                              Error: "Please Enter password !",
                              i_controller: Password,
                              text: "Password",
                              icon: Icons.lock,
                            ),
                          ],
                        )),
                  ),
                )
              ],
            );
          }),
        ),
        Container(
          height: Height! * 0.15,
          child: Center(
              //heightFactor: 0.2 * Height!,
              //color: Colors.black,
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              button(
                function: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _saving = true;
                    });
                    try {
                      _userCredential = await _auth.signInWithEmailAndPassword(
                          email: Email.text, password: Password.text);
                      isadmin();
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.ERROR,
                          animType: AnimType.RIGHSLIDE,
                          headerAnimationLoop: true,
                          title: 'Error',
                          desc: 'No user found for that email.',
                          btnOkOnPress: () {},
                          btnOkIcon: Icons.cancel,
                          btnOkColor: Colors.red,
                        ).show();
                      } else if (e.code == 'wrong-password') {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.ERROR,
                          animType: AnimType.RIGHSLIDE,
                          headerAnimationLoop: true,
                          title: 'Error',
                          desc: 'Wrong password provided for that user.',
                          btnOkOnPress: () {},
                          btnOkIcon: Icons.cancel,
                          btnOkColor: Colors.red,
                        ).show();
                      } else if (e.code == "invalid-email") {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.ERROR,
                          animType: AnimType.RIGHSLIDE,
                          headerAnimationLoop: true,
                          title: 'Error',
                          desc: 'invalid email !.',
                          btnOkOnPress: () {},
                          btnOkIcon: Icons.cancel,
                          btnOkColor: Colors.red,
                        ).show();
                      } else {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.ERROR,
                          animType: AnimType.RIGHSLIDE,
                          headerAnimationLoop: true,
                          title: 'Error',
                          desc: 'No Internet !.',
                          btnOkOnPress: () {},
                          btnOkIcon: Icons.cancel,
                          btnOkColor: Colors.red,
                        ).show();
                      }
                    }
                  }
                  setState(() {
                    _saving = false;
                  });
                },
                TEXT: "Login",
              ),
              IconButton(
                iconSize: HW! * 30,
                onPressed: () {
                  Navigator.of(context).pushNamed("setting");
                },
                icon: Icon(
                  Icons.settings,
                  color: primerycolor,
                ),
                color: SecendaryColor,
              )
            ],
          )),
        )
      ]),
    ));
  }
}
