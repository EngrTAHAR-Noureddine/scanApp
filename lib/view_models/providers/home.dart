import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier{

  static final HomeProvider _singleton = HomeProvider._internal();
  factory HomeProvider() {
    return _singleton;
  }
  HomeProvider._internal();

  bool bigger = false;
  TextEditingController searchItem = new TextEditingController();

  void onPressedButton(){
    bigger = !bigger;
    notifyListeners();
  }

}
