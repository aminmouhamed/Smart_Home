import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Color primerycolor = Color(0xff3B5382);
const Color SecendaryColor = Color(0xffDDE2EC);
const Color therdColor = Color(0xff9BBCFF);
const Color fieldColor = Color(0xffDDE2EC);

bool chek = true;
double? Width;
double? Height;
late String Roomname;
String? userName;
screen(BuildContext context) {
  Width = MediaQuery.of(context).size.width;
  Height = MediaQuery.of(context).size.height;
  chek = false;
}
