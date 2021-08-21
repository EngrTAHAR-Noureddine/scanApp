import 'package:flutter/material.dart';
import 'package:scanapp/data/database.dart';
import 'package:scanapp/models/database_models/inventories.dart';
import 'package:scanapp/models/database_models/inventory_lines.dart';
import 'package:scanapp/models/database_models/product_lots.dart';
import 'package:scanapp/view_models/providers/main.dart';


class ListItemsProvider extends ChangeNotifier{

  static ListItemsProvider? _instance;
  ListItemsProvider._();
  factory ListItemsProvider() => _instance ??=ListItemsProvider._();

  String? chain;
  int? total;
  int? scan;
  setState(){
    notifyListeners();
  }
  Future<List<ProductLot>> getProductLots()async{
    Inventory? inventory = await DBProvider.db.getIncompleteInventory();
    List<ProductLot>? listProduts = await DBProvider.db.getAllProductLots();
    total = MainProvider().user!.allProductLots ?? 0;
    List<InventoryLine>? inventoryLines;
    if(inventory != null){
       inventoryLines = await DBProvider.db.getAllInventoryLines(inventory.id!);
      scan = (inventoryLines.isNotEmpty)?inventoryLines.length:0;
    }

    if(inventoryLines != null && listProduts != null){
      if(inventoryLines.isNotEmpty && listProduts.isNotEmpty){

        inventoryLines.forEach((item) {
          listProduts.removeWhere((element) => element.id == item.productLotId);
        });
      }
    }


      return listProduts.isEmpty?[]: listProduts;
  }



}
