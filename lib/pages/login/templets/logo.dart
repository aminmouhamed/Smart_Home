import 'package:flutter/material.dart';
import 'package:smarthome/pages/config.dart';

class logo extends StatelessWidget {
  logo(this.containerWidth) {}
  final double containerWidth;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        // colum to contein all logo component
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
                width: 0.4 * containerWidth,
                height: 0.4 * containerWidth,
                child: Image.asset(
                  // import logo image from assets file "imeges"
                  "images/smart-home.png",
                  fit: BoxFit.fill, // to fit image in the container
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "SMART ",
                style: TextStyle(
                    color: fieldColor,
                    fontSize: 35,
                    fontWeight: FontWeight.w100),
              ),
              Text(
                "HOME",
                style: TextStyle(
                    color: primerycolor,
                    fontSize: 35,
                    fontWeight: FontWeight.w600),
              )
            ],
          )
        ],
      ),
    );
  }
}
