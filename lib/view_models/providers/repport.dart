import 'package:flutter/material.dart';

class RepportProvider extends ChangeNotifier{

  static final RepportProvider _singleton = RepportProvider._internal();
  factory RepportProvider() {
    return _singleton;
  }
  RepportProvider._internal();



}
