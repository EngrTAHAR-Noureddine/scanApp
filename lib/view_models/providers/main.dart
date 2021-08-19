import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier{


  static MainProvider? _instance;
  MainProvider._();
  factory MainProvider() => _instance ??=MainProvider._();


}




