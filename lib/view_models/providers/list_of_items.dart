import 'package:flutter/material.dart';
import 'package:scanapp/data/database.dart';
import 'package:scanapp/models/database_models/counter_stocks_in_emplacement.dart';
import 'package:scanapp/models/database_models/inventories.dart';
import 'package:scanapp/models/database_models/inventory_lines.dart';
import 'package:scanapp/models/database_models/product_lots.dart';
import 'package:scanapp/models/database_models/stock_systems.dart';
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
  Future<List<ProductLot>> getProductLots({lookingFor,id})async{

    List<ProductLot>? listProduts = <ProductLot>[];
    Inventory? inventory = await DBProvider.db.getIncompleteInventory();
    List<InventoryLine>? inventoryLines;

    if(lookingFor == "stockSys"){


            List<StockSystem> stockSys = await DBProvider.db.getAllStocksByEmplacement(id);
            //StocksCounter? stocksCounter = await DBProvider.db.getTotalFromStockCounter(id);

            if(stockSys.isNotEmpty){

              //listProduts = <ProductLot>[];

              for(int i =0 ; i<stockSys.length;i++){
                  ProductLot? productLot = await DBProvider.db.getProductLot(stockSys[i].productLotId);
                  if(productLot!=null){
                    listProduts.add(productLot);
                  }
              }

            }

    }
    if(listProduts.isEmpty){
      listProduts = await DBProvider.db.getAllProductLots();
    }




    if(inventory != null){
       inventoryLines = await DBProvider.db.getAllInventoryLines(inventory.id!);
       scan = (inventoryLines.isNotEmpty)?inventoryLines.length:0;
    }

    if(inventoryLines != null && listProduts.isNotEmpty){

      if(inventoryLines.isNotEmpty && listProduts.isNotEmpty){

        inventoryLines.forEach((item) {

         if(listProduts!=null) listProduts.removeWhere((element) => element.id == item.productLotId);

        });

      }
    }

    total = (listProduts.isEmpty)?0:listProduts.length;
      return listProduts.isEmpty?[]: listProduts;
  }



}
