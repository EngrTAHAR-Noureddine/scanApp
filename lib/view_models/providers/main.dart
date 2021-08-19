import 'package:flutter/material.dart';
import 'package:scanapp/models/database_models/user.dart';

class MainProvider extends ChangeNotifier{


  static MainProvider? _instance;
  MainProvider._();
  factory MainProvider() => _instance ??=MainProvider._();

  User? user;
  saveUser(User? user){
    this.user = user;
  }

}




