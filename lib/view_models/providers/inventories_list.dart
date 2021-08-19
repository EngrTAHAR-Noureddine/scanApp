import 'package:flutter/material.dart';
import 'package:scanapp/models/variables_define/colors.dart';

class InventoryListProvider extends ChangeNotifier{

  static InventoryListProvider? _instance;
  InventoryListProvider._();
  factory InventoryListProvider() => _instance ??=InventoryListProvider._();


  Widget iconLoeading(String state){
    switch(state){
      case "finished": return Icon(Icons.check_circle, color: ColorsOf().finisheItem(),); break;
      case "ongoing": return Icon(Icons.circle, color: ColorsOf().onGoingItem(),); break;
      default : return Icon(Icons.circle, color: ColorsOf().backGround(),); break;

    }
  }

}
