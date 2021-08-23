import 'package:flutter/material.dart';

class ShowCompanyProvider extends ChangeNotifier{


  static ShowCompanyProvider? _instance;
  ShowCompanyProvider._();
  factory ShowCompanyProvider() => _instance ??=ShowCompanyProvider._();

  setState(){notifyListeners();}







}




