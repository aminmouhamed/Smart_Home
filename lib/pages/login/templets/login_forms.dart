/*
that file contain all the componet to create costem form feild
*/
import 'package:flutter/material.dart';
import 'package:smarthome/pages/config.dart';

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
      child: Container(
        height: Height! / 11,
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
                  color: primerycolor,
                ),
                hintText: text,
                hintStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
                fillColor: fieldColor,
                filled: true,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30)))),
      ),
    );
  }
}
