import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:scanapp/data/database.dart';
import 'package:scanapp/models/database_models/user.dart';
import 'package:scanapp/models/variables_define/colors.dart';

class MainProvider extends ChangeNotifier{


  static MainProvider? _instance;
  MainProvider._();
  factory MainProvider() => _instance ??=MainProvider._();

  User? user;
  ThemeMode themeMode = ThemeMode.system;

  saveUser(User? user){
    this.user = user;
  }

  Future<User?> getUser()async{
    user = await DBProvider.db.getUser(1);
    if(user!=null) ColorsOf().mode(isDark: (user!.isDark == "dark"));

    return user;
  }
  Future<void> setAppMode(value)async{
    user = await DBProvider.db.getUser(1);
    if(user != null){
      user!.isDark =(value)?"dark":"light";
      ColorsOf().mode(isDark: value);
      //themeMode=(user!.isDark=="dark")?ThemeMode.dark:ThemeMode.light;
      await DBProvider.db.updateUser(user!);

    }
    notifyListeners();
  }

  Future<void> createUser()async{
    user = await DBProvider.db.getUser(1);
    if(user!=null) ColorsOf().mode(isDark: (user!.isDark == "dark"));
  }

  Future<void> updateUser(String password, bool isAdmin)async{
      user = await DBProvider.db.getUser(1) ;
      if(user != null){
        if(isAdmin){
                user!.adminPassword = password;
                    }else{
                      user!.userPasswordActually = password;
                    }

        await DBProvider.db.updateUser(user!);            
      }
      
  }

}




