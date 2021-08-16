import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier{

  static final MainProvider _singleton = MainProvider._internal();
  factory MainProvider() {
    return _singleton;
  }
  MainProvider._internal();



}




