import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ColorsOf{
  static final ColorsOf _singleton = ColorsOf._internal();
  factory ColorsOf() {return _singleton;}
  ColorsOf._internal();


  bool darkMode; // false ==> light , true ==> dark

  void mode(context){
    var brightness = MediaQuery.of(context).platformBrightness;
    darkMode = brightness == Brightness.dark;
  }
  Color primaryForGround(){
    return (darkMode)?Color(0xFFFF9F0A): Color(0xFFFF9500);
  }
  Color primaryBackGround(){
    return (darkMode)?Color(0xFFFF9F0A): Color(0xFF242426);
  }
  Color deleteItem(){
    return (darkMode)?Color(0xFFFF6961): Color(0xFFD70015);
  }
  Color onGoingItem(){
    return (darkMode)?Color(0xFF004267):Color(0xFF64D2FF);
  }
  Color finisheItem(){
    return (darkMode)?Color(0xFF25502A): Color(0xFF30DB5B);
  }
  Color backGround(){
    return (darkMode)?Color(0xFF242426):Color(0xFFEBEBF0);
  }
  Color profilField(){
    return (darkMode)?Color(0xFF363638):Color(0xFFFF9500);
  }
  Color importField(){
    return (darkMode)?Color(0xFFAEAEB2):Color(0xFF545456);
  }
  Color containerThings(){
    return (darkMode)?Color(0xFF242426):Color(0xFFFF9500);
  }
  Color borderContainer(){
    return (darkMode)?Color(0xFFEBEBF0):Color(0xFF242426);
  }





  Widget logoLogIn(){
    return (darkMode)?SvgPicture.asset("assets/images/logo_dark.svg", semanticsLabel: 'Logo'):SvgPicture.asset("assets/images/logo_light.svg", semanticsLabel: 'Logo',);
  }

}