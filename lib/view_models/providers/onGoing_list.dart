import 'package:flutter/material.dart';
import 'package:scanapp/data/database.dart';
import 'package:scanapp/models/database_models/inventory_lines.dart';
import 'package:scanapp/models/database_models/product_lots.dart';

class OnGoingListProvider extends ChangeNotifier{

  static OnGoingListProvider? _instance;
  OnGoingListProvider._();
  factory OnGoingListProvider() => _instance ??=OnGoingListProvider._();
    int? id;
  setState(){
    notifyListeners();
  }

  Future<List<ProductLot>> getAllLines()async{

    List<ProductLot> productLot = <ProductLot>[];

    List<InventoryLine>? listLines = await DBProvider.db.getAllInventoryLines(id);

    if(listLines.isNotEmpty){
      for(int i =0; i<listLines.length;i++){
        ProductLot? product = await DBProvider.db.getProductLot(listLines[i].productLotId);
        if(product!=null) productLot.add(product);
      }
    }

    return productLot.isEmpty?[]: productLot;
  }


}
