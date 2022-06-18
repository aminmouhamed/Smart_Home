import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smarthome/pages/home/home_page.dart';
import 'package:smarthome/pages/login/login_page.dart';

const Color primerycolor = Color(0xff3B5382);
const Color SecendaryColor = Color(0xffDDE2EC);
const Color therdColor = Color(0xff9BBCFF);
const Color fieldColor = Color(0xffDDE2EC);

bool chek = true;
double? Width;
double? Height;
double? HW;
dynamic HOME = Home();
bool ADMIN = false;
late String Roomname;
String? userName;
screen(BuildContext context) {
  Width = MediaQuery.of(context).size.width;
  Height = MediaQuery.of(context).size.height;
  HW = Height! / Width!;
  chek = false;
}
