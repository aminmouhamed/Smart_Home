/*
that file contain all the componet to create costem form feild
*/
import 'package:flutter/material.dart';
import 'package:smarthome/pages/config.dart';

/*

class Textform extends StatefulWidget {
  @override
  State<Textform> createState() => _TextformState();
}

class _TextformState extends State<Textform> {
  final TextEditingController Email ;
  final TextEditingController Password ;
  final GlobalKey<FormState> _form ;
  @override
  void initState() {
    // TODO: implement initState
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        child: Form(
            key: _form,
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: TextInput(
                      Validator: (val) {
                        if (val!.isEmpty) {
                          return "please Enter Email !";
                        }
                      },
                      i_controller: Email,
                      text: "Email",
                      icon: Icons.email,
                    )),
                TextInput(
                  Validator: (val) {if (val!.isEmpty) {
                          return "please Enter password !";
                        }},
                  i_controller: Password,
                  text: "Password",
                  icon: Icons.lock,
                ),
              ],
            )),
      ),
    );
  }
}

*/
class TextInput extends StatelessWidget {
  const TextInput({
    Key? key,
    required this.text,
    required this.icon,
    required this.i_controller,
    required this.Error,
    this.obs: false,
    this.ktype: TextInputType.text,
  }) : super(key: key);
  final bool obs;
  final String text;
  final IconData icon;
  final TextEditingController i_controller;
  final String Error;
  final TextInputType ktype;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
          keyboardType: ktype,
          obscureText: obs,
          validator: (val) {
            if (val!.isEmpty) {
              return Error;
            }
          },
          controller: i_controller,
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: primerycolor,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(30),
              ),
              prefixIcon: Icon(
                icon,
                color: Colors.black,
              ),
              hintText: text,
              hintStyle:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w200),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30)))),
    );
  }
}
