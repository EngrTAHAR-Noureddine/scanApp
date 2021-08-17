import 'package:flutter/material.dart';
import 'package:scanapp/models/variables_define/colors.dart';

class HomeProvider extends ChangeNotifier{

  static final HomeProvider _singleton = HomeProvider._internal();
  factory HomeProvider() {
    return _singleton;
  }
  HomeProvider._internal();
  int numOfSelecter = 0;

  bool bigger = false;
  TextEditingController searchItem = new TextEditingController();

  void onPressedButton(){
    bigger = !bigger;
    notifyListeners();
  }

  Color colorBox(int num){

    return (num == numOfSelecter)?ColorsOf().profilField():ColorsOf().primaryBackGround();
  }
  Color colorText(int num){

    return (num == numOfSelecter)?ColorsOf().primaryBackGround():ColorsOf().containerThings();
  }

  void changeSelecter(int num){
    this.numOfSelecter = num;
    notifyListeners();
  }

  void setState(){
    notifyListeners();
  }



}
