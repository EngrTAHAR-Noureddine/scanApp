import 'dart:io';
import 'package:scanapp/view_models/providers/home.dart';
import 'package:scanapp/views/home.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;
import 'package:flutter/material.dart';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scanapp/data/database.dart';
import 'package:scanapp/models/database_models/inventories.dart';
import 'package:scanapp/models/database_models/inventory_lines.dart';
import 'package:scanapp/models/variables_define/colors.dart';


class ExportProvider extends ChangeNotifier{
  static ExportProvider? _instance;
  ExportProvider._();
  factory ExportProvider() => _instance ??=ExportProvider._();

  String filePath = "/";

  Future<bool> _requestPermission(Permission per) async{

    if(await per.isGranted){
      return true;
    }else {
      var result = await per.request();
      if(result == PermissionStatus.granted){ return true; }else {return false;}
    }

  }

  Future<bool> saveInFile(List<InventoryLine> inventoryLines,String fileName)async{ // notnull
    /* variables  */
    fileName = fileName + '.xlsx';
    String newPath ="";
    File file;
    bool isFinish = false;

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
                    final xlsio.Workbook workbook = xlsio.Workbook();
                    final xlsio.Worksheet sheet = workbook.worksheets[0];

                        int row =1;
                        final List<Object> firstLine = ['id',
                          'Id_inventory',
                          'Id_Produit',
                          'Id_Emplacement',
                          'Id_productLot',
                          'quantity',
                          'quantitySystem',
                          'difference',
                          'quality'];
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
                        filePath = file.path;
                    isFinish = true;
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
return isFinish;
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

  Future<bool> getInventoryLines(int? id)async{
    bool bol = false;
    List<InventoryLine>? list = await DBProvider.db.getAllInventoryLines(id);
    String name = 'inventory '+id.toString()+"_"+DateTime.now().year.toString()+DateTime.now().month.toString()+DateTime.now().day.toString()+"T"+DateTime.now().hour.toString()+DateTime.now().minute.toString();


    if(list!=null){
     bol =  await saveInFile(list ,name );
      //processSaving(context,list ,name);
    }
  return bol;
  }


  Widget processSaving(context,int? id){

    String meg ="Exporter.....";

    return Scaffold(
      backgroundColor: ColorsOf().backGround(),
      body: FutureBuilder(
          future: getInventoryLines(id),
          builder: (context, snapshot) {
            print(snapshot);

            if (snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data != null) {


              String res =  (snapshot.data == true)?"Success":"Failed";
             // Navigator.pop(context);
              return whenFinishProcess(context, res);

            }else if(snapshot.hasError){

              String res = "Failed";
             // Navigator.pop(context);
              return whenFinishProcess(context, res);
            }

            return Container(
              color: ColorsOf().backGround(),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                color: Colors.transparent,
                width: 200,
                height: 200,
                child: Column(
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 50,
                        child: CircularProgressIndicator(color:ColorsOf().primaryBackGround()  ,backgroundColor: Colors.transparent,)
                    ),
                    SizedBox(height: 20,),
                    Text(meg, style: TextStyle(fontSize: 16 , color: ColorsOf().primaryBackGround(),),)
                  ],
                ),

              ),
            );
          }
      ),
    );
  }

  Widget whenFinishProcess(context,isSuccess){
    String msg = (isSuccess == "Success")? "le processus est terminé avec succès":"le processus a échoué";
    Color aColor =  (isSuccess == "Success")? ColorsOf().finisheItem():ColorsOf().deleteItem();
    Color textColor = (isSuccess == "Success")? ColorsOf().borderContainer():ColorsOf().backGround();

    String msg2 = (isSuccess == "Success")?"Afiicher le fichier ! ":"Retournez à la page d'accueil";

    return Scaffold(

      backgroundColor: ColorsOf().backGround(),
      body: Container(
        color: ColorsOf().backGround(),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          width: 200,
          height: 200,
          child: Column(
            children: [

              Text(msg, style: TextStyle(fontSize: 16 ,fontWeight: FontWeight.bold, color: ColorsOf().primaryBackGround(),),),
              SizedBox(height: 50,),
              MaterialButton(
                height: 50,
                minWidth: 200,
                color: aColor ,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(0),
                child: Text(msg2 ,style: TextStyle(color:textColor ),),


                onPressed: (){
                  if(isSuccess == "Success"){
                    OpenFile.open(filePath);

                  }
                      else{
                        HomeProvider().changeSelecter(0, context, "/inventoryList");
                        Navigator.pop(context);
                      }


                },


              ),

            ],
          ),

        ),
      ),
    );
  }


}
