/*
that file contain all the component for creat a butefful button 

*/
import 'package:flutter/material.dart';
import 'package:smarthome/pages/config.dart';

class button extends StatelessWidget {
  button({Key? key, required this.TEXT, required this.function})
      : super(key: key);
  final String TEXT;

  final Function function;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => function(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Width! / 15, vertical: 10),
          child: Container(
            height: 54,
            width: Width! * 0.5,
            alignment: Alignment.center,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 5.0, // soften the shadow
                spreadRadius: 0.0, //extend the shadow
                offset: Offset(
                  0.0, // Move to right 10  horizontally
                  3.0, // Move to bottom 10 Vertically
                ),
              )
            ], color: Colors.grey, borderRadius: BorderRadius.circular(30)),
            child: Text(
              TEXT == null ? "test" : TEXT,
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
        ));
  }
}
