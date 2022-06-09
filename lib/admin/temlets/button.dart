/*
that file contain all the component for creat a butefful button 

*/
import 'package:flutter/material.dart';
import 'package:smarthome/pages/config.dart';

/*
class buttons extends StatefulWidget {
  buttons({Key? key}) : super(key: key);

  @override
  State<buttons> createState() => _buttonsState();
}

class _buttonsState extends State<buttons> {
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Height! * 0.2,
      child: Center(
          //heightFactor: 0.2 * Height!,
          //color: Colors.black,
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          button(
            function: () {},
            TEXT: "Login",
          ),
          IconButton(
            iconSize: 54,
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              color: primerycolor,
            ),
            color: SecendaryColor,
          )
        ],
      )),
    );
  }
}
*/
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
