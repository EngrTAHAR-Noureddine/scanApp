import 'package:flutter/material.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/views/import_new_file.dart';
import 'package:scanapp/views/inventories_list.dart';
import 'package:scanapp/views/list_of_items.dart';
import 'package:scanapp/views/onGoingList.dart';
import 'package:scanapp/views/repport.dart';

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

  void changeSelecter(int num, context, path){
    this.numOfSelecter = num;
    Navigator.popAndPushNamed(context, path);
    notifyListeners();
  }

  Widget changeSelecterActivity(int num){
    // put numselected
    List<dynamic> listWidgets = [InventoryList(),ImportNewerFile(),OnGoingLists(),ListItems(),Repport()];
    return listWidgets[num];
  }


  void setState(){
    notifyListeners();
  }



}
