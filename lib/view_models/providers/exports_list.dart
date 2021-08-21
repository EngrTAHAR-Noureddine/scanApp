import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scanapp/data/database.dart';
import 'package:scanapp/models/database_models/inventories.dart';
import 'package:scanapp/models/database_models/inventory_lines.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class ExportProvider extends ChangeNotifier{
  static ExportProvider? _instance;
  ExportProvider._();
  factory ExportProvider() => _instance ??=ExportProvider._();

  Future<bool> _requestPermission(Permission per) async{

    if(await per.isGranted){
      return true;
    }else {
      var result = await per.request();
      if(result == PermissionStatus.granted){ return true; }else {return false;}
    }

  }

  Future<void> saveInFile(List<InventoryLine> inventoryLines,String fileName)async{ // notnull
    /* variables  */
    fileName = fileName + '.xlsx';
    String newPath ="";
    File file;

    /* instructors  */

    Directory? directory;
    try{
      /// get the directory of FecomIt folder  *********************************************************
      if(Platform.isAndroid){  /* Android  */
        if(await _requestPermission(Permission.storage)){
          directory = await getExternalStorageDirectory();
          if(directory!=null){
            print(directory.path);

            List<String> folders = directory.path.split("/");
            for(int x=1; x<folders.length;x++){
              String folder = folders[x];
              if(folder != "Android"){
                newPath += "/"+folder;
              }else break;
            }
            newPath = newPath+"/FecomIt";
            directory = Directory(newPath);


                newPath = newPath +"/"+fileName;
                file = File(newPath)..createSync(recursive: true);

                if((await file.exists())==true){

                  /* write here */

                  try {
                    final Workbook workbook = Workbook();
                    final Worksheet sheet = workbook.worksheets[0];

                        int row =0;
                        final List<Object> firstLine = ["id", "Id_inventory", "Id_Produit", "Id_Emplacement","Id_productLot","quantity","quantitySystem","difference","quality"];
                        sheet.importList(firstLine, row, 1, false);

                        inventoryLines.forEach((element) {
                          row++;
                          final List<Object> lineRow = [element.id??"-----",
                                                          element.inventoryId??"-----",
                                                          element.productId??"-----",
                                                          element.emplacementId??"-----",
                                                          element.productLotId??"-----",
                                                          element.quantity??"-----",
                                                          element.quantitySystem??"-----",
                                                          element.difference??"-----",
                                                          element.quality??"-----"];
                          sheet.importList(lineRow, row, 1, false);
                        });
                        final List<int> bytes = workbook.saveAsStream();
                        await file.writeAsBytes(bytes, flush: true);
                        workbook.dispose();
                        OpenFile.open(file.path);

                      } catch (e) {
                        print(e);
                      }

                }else {
                 // throw "Android11";
                }


          }


        }//else throw "permission";
      }else print("the platform is not ios");
    }catch(e){ print("catch error : "+e.toString());}

  }

  Future<List<Inventory>> getAllInventory()async{
    List<Inventory>? list = await DBProvider.db.getAllInventories();
    List<Inventory> anotherList = <Inventory>[];

    if(list != null){

      list.forEach((element) {
        if(element.status != "begin"){
          anotherList.add(element);
        }
      });
    }else anotherList = [];
    return (anotherList.isNotEmpty)?anotherList:[];
  }

  Future<void> getInventoryLines(int? id)async{

    List<InventoryLine>? list = await DBProvider.db.getAllInventoryLines(id);
    String name = 'inventory'+id.toString()+"_"+DateTime.now().toString();


    if(list!=null){
      await saveInFile(list ,name );
    }

  }


}
