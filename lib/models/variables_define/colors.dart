import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scanapp/view_models/providers/home.dart';

class ColorsOf{
  static final ColorsOf _singleton = ColorsOf._internal();
  factory ColorsOf() {return _singleton;}
  ColorsOf._internal();


  bool darkMode; // false ==> light , true ==> dark

  void mode(context){
    var brightness = MediaQuery.of(context).platformBrightness;
    darkMode = brightness == Brightness.dark;

  }
  // FF9500 ==> FF9F0A
  Color primaryForGround(){
    return (darkMode)?Color(0xFFFF9F0A): Color(0xFFFF9500);
  }
  // 242426 ==> FF9F0A
  Color primaryBackGround(){
    return (darkMode)?Color(0xFFFF9F0A): Color(0xFF242426);
  }
  // D70015 ==> FF6961
  Color deleteItem(){
    return (darkMode)?Color(0xFFFF6961): Color(0xFFD70015);
  }
  // 64D2FF ==> 004267
  Color onGoingItem(){
    return (darkMode)?Color(0xFF004267):Color(0xFF64D2FF);
  }
  // 30DB5B ==> 25502A
  Color finisheItem(){
    return (darkMode)?Color(0xFF25502A): Color(0xFF30DB5B);
  }
  // EBEBF0 ==> 242426
  Color backGround(){
    return (darkMode)?Color(0xFF242426):Color(0xFFEBEBF0);
  }
  // FF9500 ==> 363638
  Color profilField(){
    return (darkMode)?Color(0xFF363638):Color(0xFFFF9500);
  }
  // 545456 ==> AEAEB2
  Color importField(){
    return (darkMode)?Color(0xFFAEAEB2):Color(0xFF545456);
  }
  // FF9500 ==> 242426
  Color containerThings(){
    return (darkMode)?Color(0xFF242426):Color(0xFFFF9500);
  }
  // 242426 ==> EBEBF0
  Color borderContainer(){
    return (darkMode)?Color(0xFFEBEBF0):Color(0xFF242426);
  }





  Widget logoLogIn(){
    return (darkMode)?SvgPicture.asset("assets/images/logo_dark.svg", semanticsLabel: 'Logo'):SvgPicture.asset("assets/images/logo_light.svg", semanticsLabel: 'Logo',);
  }

}