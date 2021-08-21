import 'package:flutter/material.dart';
import 'package:scanapp/data/database.dart';
import 'package:scanapp/models/database_models/inventory_lines.dart';

class OnGoingListProvider extends ChangeNotifier{

  static OnGoingListProvider? _instance;
  OnGoingListProvider._();
  factory OnGoingListProvider() => _instance ??=OnGoingListProvider._();
    int? id;
  setState(){
    notifyListeners();
  }

  Future<List<InventoryLine>> getAllLines()async{
    
    List<InventoryLine>? listLines = await DBProvider.db.getAllInventoryLines(id);
    


    return listLines.isEmpty?[]: listLines;
  }


}
