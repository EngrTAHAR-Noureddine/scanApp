import 'package:flutter/material.dart';

class OnGoingListProvider extends ChangeNotifier{

  static final OnGoingListProvider _singleton = OnGoingListProvider._internal();
  factory OnGoingListProvider() {
    return _singleton;
  }
  OnGoingListProvider._internal();



}
