import 'package:flutter/material.dart';
import 'package:smarthome/pages/config.dart';

class RoundedBTN extends StatelessWidget {
  const RoundedBTN({
    Key? key,
    required this.onTab,
    required this.width,
    this.icon,
    this.Note,
    this.color,
  }) : super(key: key);
  final VoidCallback onTab;
  final double width;
  final Color? color;
  final IconData? icon;
  final String? Note;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: icon == null ? () {} : onTab,
      child: Container(
        width: width,
        height: width,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color == null ? Colors.white : color!,
            boxShadow: [
              BoxShadow(
                  color: Colors.black38,
                  blurRadius: 5.0,
                  offset: Offset(0.0, 4.0))
            ]),
        child: Center(
          child: icon == null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Note!,
                      style: TextStyle(
                          fontSize: 40,
                          color: primerycolor,
                          fontWeight: FontWeight.bold),
                    ) /*,
                    Text(
                      "c",
                      style: TextStyle(color: primerycolor, fontSize: 25),
                    )*/
                  ],
                )
              : Icon(
                  icon!,
                  color: primerycolor,
                  size: 0.7 * width,
                ),
        ),
      ),
    );
  }
}
