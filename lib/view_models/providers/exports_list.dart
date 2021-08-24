import 'dart:io';
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
        if(await _requestPermission(Permission.manageExternalStorage)){
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
                try{
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

                }catch(e){print("here error : "+e.toString());}

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

  Future<void> dialogProcess(context,int? id)async{
    String meg ="Exporter.....";
    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return   WillPopScope(
            onWillPop: ()async{
              return false;
            },
            child: FutureBuilder(
                future:  getInventoryLines(id),
                builder: (context, snapshot) {
                  print(snapshot);

                  if (snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data != null) {
                    String titleDialog =  (snapshot.data == true)?"Succès":"Échoué";
                    IconData icon = (snapshot.data == true)?Icons.check_circle_rounded:Icons.cancel_rounded;
                    Color backColor =  (snapshot.data == true)? ColorsOf().finisheItem():ColorsOf().deleteItem();
                    Color textColor = ColorsOf().borderContainer();
                    String message = (snapshot.data == true)? "le processus est terminé avec succès ":"le processus a échoué";

                    return Center(
                      child: SingleChildScrollView(
                        child: AlertDialog(
                          backgroundColor:ColorsOf().backGround(),
                          elevation: 1,
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          content: Row(
                            children: [
                              Icon(icon , color: backColor,size: 30,),
                              SizedBox(width: 20,),
                              Container(
                                width: 200,
                                height: 50,
                                child: RichText(
                                    text: TextSpan(children: [

                                      TextSpan(text:message,
                                        style: TextStyle(color : textColor ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                      ),

                                      TextSpan(text:(snapshot.data == true)?"("+filePath+" ) ":"",
                                        style: TextStyle(color : textColor ,fontSize: 14 ,fontWeight: FontWeight.bold),
                                      ),

                                    ])
                                ),
                              ),
                            ],
                          ),
                          title: Text(titleDialog,style: TextStyle(color: textColor ),),
                          actions: <Widget>[
                            (snapshot.data == true)?  MaterialButton(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              highlightElevation: 0,
                              elevation: 0,
                              focusElevation: 0,
                              hoverElevation: 0,
                              color:ColorsOf().onGoingItem() ,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  side: BorderSide(color:ColorsOf().onGoingItem(),width: 1,style: BorderStyle.solid)
                              ),
                              padding: EdgeInsets.all(0),
                              child: Text("Aller à" ,style: TextStyle(color: ColorsOf().borderContainer(),fontWeight: FontWeight.normal),),

                              onPressed: () {
                                OpenFile.open(filePath);
                              }


                            ) : Container(),
                            MaterialButton(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              highlightElevation: 0,
                              elevation: 0,
                              focusElevation: 0,
                              hoverElevation: 0,
                              child: Text('Annuler',style:TextStyle(color: ColorsOf().importField() )),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ),
                    );

                    // return whenFinishProcess(context, res);
                  }else if(snapshot.connectionState == ConnectionState.done && snapshot.hasError && snapshot.error != null){
                    String titleDialog ="Échoué";

                    Color backColor = ColorsOf().deleteItem();
                    Color textColor = ColorsOf().borderContainer();
                    String message ="le processus a échoué";
                    return Center(
                      child: SingleChildScrollView(
                        child: AlertDialog(
                          backgroundColor:ColorsOf().backGround(),
                          elevation: 1,
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          content: Row(
                            children: [
                              Icon(Icons.cancel_rounded, size: 30,color: backColor,),
                              SizedBox(width: 20,),
                              Text(message, style: TextStyle(color: textColor,fontSize:14,),),
                            ],
                          ),
                          title: Text(titleDialog,style: TextStyle(color: textColor ),),
                          actions: <Widget>[

                            MaterialButton(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              highlightElevation: 0,
                              elevation: 0,
                              focusElevation: 0,
                              hoverElevation: 0,
                              child: Text('Annuler',style:TextStyle(color: ColorsOf().importField() )),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                    //return whenFinishProcess(context, res);
                  }
                  return Center(
                    child: SingleChildScrollView(

                      child: AlertDialog(
                        backgroundColor:ColorsOf().backGround(),
                        elevation: 1,
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        content: Row(
                          children: [
                            Expanded(child: Container(
                                padding: EdgeInsets.all(5),
                                child: CircularProgressIndicator(color:ColorsOf().primaryBackGround(),))),
                            SizedBox(width: 10,),
                            Expanded(
                                flex: 3,
                                child: Container(
                                  child: Text(meg, style: TextStyle(color: ColorsOf().primaryBackGround(),fontSize:14,),),
                                )),

                          ],
                        ),
                        //Text("Voulez-vous vraiment "+title.toLowerCase()+" ?", style: TextStyle(color: ColorsOf().containerThings(),fontSize:14,),),
                        title: Text("Exporter Fichier",style: TextStyle(color: ColorsOf().primaryBackGround() ),),

                      ),
                    ),
                  );
                }
            ),
          );

        });
  }



}
