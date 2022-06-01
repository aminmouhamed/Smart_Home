import 'package:flutter/material.dart';
import 'package:smarthome/pages/config.dart';

class tapbutton extends StatelessWidget {
  tapbutton({
    Key? key,
    required this.Width,
    required this.ontab,
    required this.img,
    required this.text,
    required this.visibel,
  }) : super(key: key);
  final bool visibel;
  final String img;
  final String text;
  final double Width;
  final Function ontab;
  Color color = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTapDown: (tab) {
          color = therdColor;
        },
        onTapUp: (detail) {
          color = Colors.white;
        },
        onTap: visibel ? () => ontab() : () {},
        child: Container(
          width: Width * 0.37,
          height: Width * 0.37,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 5.0, // soften the shadow
                  spreadRadius: 0.0, //extend the shadow
                  offset: Offset(
                    1.0, // Move to right 10  horizontally
                    3.0, // Move to bottom 10 Vertically
                  ),
                )
              ],
              color: visibel ? color : Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  child: Image.asset(
                    img,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  text,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Inter"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
