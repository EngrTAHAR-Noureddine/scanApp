import 'package:flutter/material.dart';
import 'package:scanapp/models/variables_define/colors.dart';

class InventoryListProvider extends ChangeNotifier{

  static final InventoryListProvider _singleton = InventoryListProvider._internal();
  factory InventoryListProvider() {
    return _singleton;
  }
  InventoryListProvider._internal();


  Widget iconLoeading(String state){
    switch(state){
      case "finished": return Icon(Icons.check_circle, color: ColorsOf().finisheItem(),); break;
      case "ongoing": return Icon(Icons.circle, color: ColorsOf().onGoingItem(),); break;
      default : return Icon(Icons.circle, color: ColorsOf().backGround(),); break;

    }
  }

}
