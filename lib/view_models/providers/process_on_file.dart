import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scanapp/data/database.dart';
import 'package:scanapp/models/database_models/company.dart';
import 'package:scanapp/models/database_models/emplacements.dart';
import 'package:scanapp/models/database_models/inventories.dart';
import 'package:scanapp/models/database_models/product_category.dart';
import 'package:scanapp/models/database_models/product_lots.dart';
import 'package:scanapp/models/database_models/products.dart';
import 'package:scanapp/models/database_models/site.dart';
import 'package:scanapp/models/database_models/stock_entre_pot.dart';
import 'package:scanapp/models/database_models/stock_systems.dart';
import 'package:scanapp/models/database_models/user.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:scanapp/view_models/providers/home.dart';
import 'package:scanapp/view_models/providers/main.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

 Future<dynamic> readFile(File file)async{
  return file.readAsBytesSync();
}





class ProcessFileProvider extends ChangeNotifier{
  static ProcessFileProvider? _instance;
  ProcessFileProvider._();
  factory ProcessFileProvider() => _instance ??=ProcessFileProvider._();

  late File file;

  Future<void> pickFileExcel(context , bool updating)async{
      try{
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['xlsx'],
        );

        if(result != null) {
          file  = File(result.files.first.path??"");
          print(file.path);

          Navigator.pop(context);
          await dialogProcess(context,(updating)?"update":"import");
        }
      }catch(e){throw "aucun fichier ";}



  }

  //"Renouveler"
  //import - update - reset
  Future<void> showDialogToProcess(BuildContext context,String process) async {
    await MainProvider().getUser();
    Inventory? inv = await DBProvider.db.getIncompleteInventory();
    String title;

      if(MainProvider().user!.productLotsTable != "Empty"){
        title = (process=="import")?"Importer":(process == "reset")?"Réinitialiser":"Mettre à jour";
      }else{
        title = "Importer";
      }

    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return  Center(
            child: SingleChildScrollView(

              child: AlertDialog(
                backgroundColor:ColorsOf().primaryBackGround(),
                elevation: 1,
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                content: Text("Voulez-vous vraiment "+title.toLowerCase()+" ?", style: TextStyle(color: ColorsOf().containerThings(),fontSize:14,),),
                title: Text(title,style: TextStyle(color: ColorsOf().containerThings() ),),
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

                    color:ColorsOf().containerThings() ,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: EdgeInsets.all(0),
                    child: Text(title,style: TextStyle(color: ColorsOf().primaryBackGround()),),


                    onPressed:(process != "reset")?()=>pickFileExcel(context,(title != "Importer")?true:false):()=>resetInventory(context),


                  ),

                  ((title == "Importer")&&(inv == null)&&(MainProvider().user!.productLotsTable != "Empty"))?
                  MaterialButton(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    highlightElevation: 0,
                    elevation: 0,
                    focusElevation: 0,
                    hoverElevation: 0,
                    color:Colors.transparent ,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                      side: BorderSide(color:ColorsOf().containerThings(),width: 1,style: BorderStyle.solid)
                    ),
                    padding: EdgeInsets.all(0),
                    child: Text("Renouveler" ,style: TextStyle(color: ColorsOf().containerThings(),fontWeight: FontWeight.normal),),

                    onPressed: ()=>renewWork(context),

                  )
                  : SizedBox(width: 50,),


                  MaterialButton(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    highlightElevation: 0,
                    elevation: 0,
                    focusElevation: 0,
                    hoverElevation: 0,
                    child: Text('Cancel',style:TextStyle(color: ColorsOf().containerThings() )),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );

        });


  }


  Future<void> dialogProcess(context,process)async{
    String meg = (process == "import")?"Importer Fichier.....":"Mettre à jour.....";
     return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return   WillPopScope(
                onWillPop: ()async{
                  return false;
                },
            child: FutureBuilder(
                future: (process == "import")?importInDataBase():updateDataBase(),
                builder: (context, snapshot) {
                  print(snapshot);

                  if (snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data != null) {
                    String titleDialog =  (snapshot.data == true)?"Success":"Failed";
                    Color backColor =  (snapshot.data == true)? ColorsOf().finisheItem():ColorsOf().deleteItem();
                    Color textColor = (snapshot.data == true)? ColorsOf().borderContainer():ColorsOf().backGround();
                    String message = (snapshot.data == true)? "le processus est terminé avec succès":"le processus a échoué";

                      return Center(
                        child: SingleChildScrollView(
                          child: AlertDialog(
                            backgroundColor:backColor,
                            elevation: 1,
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            content: Text(message, style: TextStyle(color: textColor,fontSize:14,),),
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

                   // return whenFinishProcess(context, res);
                  }else if(snapshot.connectionState == ConnectionState.done && snapshot.hasError && snapshot.error != null){
                    String titleDialog ="Failed";
                    Color backColor = ColorsOf().deleteItem();
                    Color textColor = ColorsOf().backGround();
                    String message ="le processus a échoué";
                    return Center(
                      child: SingleChildScrollView(
                        child: AlertDialog(
                          backgroundColor:backColor,
                          elevation: 1,
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          content: Text(message, style: TextStyle(color: textColor,fontSize:14,),),
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
                      title: Text(process,style: TextStyle(color: ColorsOf().primaryBackGround() ),),

                    ),
                  ),
                );
              }
            ),
          );

        });
  }



  Future<void> backgroundFunction(bool isImporting)async {

    List<String> filesName = [
      "information",
      "Emplacement",
      "StockSystem",
      "Product",
      "Lot",

      "Site",
      "Company",
      "Entrepot",
      "Category"
    ];

    List<List<String>> columnSheet = [
      ["logo","nom_entreprise","num_telephone","adresse"],
      ["id","nom","enterpot-id","barcodeemp"],
      ["id","EmplacmentId","ProductId","ProductLotId","Quantity"],
      ["id","code","nom","categoryId","gestionLot","producttype"],
      ["id","immatriculation","num_serie","num_lot","product_id"],

      ["id","nom"],
      ["id","nom","logo","site_id"],
      ["id","nom","DirectionType","CompanyId","DirectionId"],
      ["id","nom","code","parentPath","parentId"],

    ];


    User? myUser = await DBProvider.db.getUser(1);



    var bytes = await compute(readFile,this.file);
    var excel;


    if (bytes != null) {
      excel = SpreadsheetDecoder.decodeBytes(bytes, update: true);
      if (excel != null) {

        /* User Info */
        if (excel.tables.keys.contains(filesName[0])) {
          List<dynamic> firstRow;
          firstRow = excel.tables[filesName[0]].rows.first;

          for (var row in excel.tables[filesName[0]].rows) {
            print(row);
            if (!row.contains(columnSheet[0][0])) {

              try{
                if(myUser!=null){

                  myUser.logoImage = (firstRow.indexOf(columnSheet[0][0]) < 0) ? null : (row[firstRow.indexOf(columnSheet[0][0])] != null) ? base64.decode(row[firstRow.indexOf(columnSheet[0][0])].toString()) : null;
                  myUser.logoName = (firstRow.indexOf(columnSheet[0][1]) < 0) ? null : (row[firstRow.indexOf(columnSheet[0][1])] != null) ? row[firstRow.indexOf(columnSheet[0][1])].toString().replaceAll(RegExp('[\',\"]'), "''") : null;

                  myUser.phoneEnterprise = (firstRow.indexOf(columnSheet[0][2]) < 0) ?
                  null : (row[firstRow.indexOf(columnSheet[0][2])] != null) ?
                  row[firstRow.indexOf(columnSheet[0][2])].toString().replaceAll(RegExp('[\',\"]'), "''") : null;

                  myUser.addressEnterprise = (firstRow.indexOf(columnSheet[0][3]) < 0) ?
                  null : (row[firstRow.indexOf(columnSheet[0][3])] != null) ?
                  row[firstRow.indexOf(columnSheet[0][3])].toString().replaceAll(RegExp('[\',\"]'), "''") : null;

                  }


              }catch(e){

              }
                  if(myUser!=null){
                        myUser.logoName = (firstRow.indexOf(columnSheet[0][1]) < 0) ? null : (row[firstRow.indexOf(columnSheet[0][1])] != null) ? row[firstRow.indexOf(columnSheet[0][1])].toString().replaceAll(RegExp('[\',\"]'), "''") : null;

                        myUser.phoneEnterprise = (firstRow.indexOf(columnSheet[0][2]) < 0) ?
                        null : (row[firstRow.indexOf(columnSheet[0][2])] != null) ?
                        row[firstRow.indexOf(columnSheet[0][2])].toString().replaceAll(RegExp('[\',\"]'), "''") : null;

                        myUser.addressEnterprise = (firstRow.indexOf(columnSheet[0][3]) < 0) ?
                        null : (row[firstRow.indexOf(columnSheet[0][3])] != null) ?
                        row[firstRow.indexOf(columnSheet[0][3])].toString().replaceAll(RegExp('[\',\"]'), "''") : null;
                        print(myUser.logoName);
                        await DBProvider.db.updateUser(myUser);
                  }


              User? userr = await DBProvider.db.getUser(1);
                print(userr?.logoName);
              }

            }
          }
        }

        /* Emplacement */
        if (excel.tables.keys.contains(filesName[1])) {
          List<dynamic> firstEmplacement;
          firstEmplacement = excel.tables[filesName[1]].rows.first;

          for (var row in excel.tables[filesName[1]].rows) {
            print(row);
            if (!row.contains(columnSheet[1][0])) {
              Emplacement emplacement = new Emplacement(
                id: (firstEmplacement.indexOf(columnSheet[1][0]) < 0)
                    ? null
                    : row[firstEmplacement.indexOf(columnSheet[1][0])],
                nom: (firstEmplacement.indexOf(columnSheet[1][1]) < 0)
                    ? null
                    : (row[firstEmplacement.indexOf(columnSheet[1][1])] != null)
                    ? row[firstEmplacement.indexOf(columnSheet[1][1])]
                    .toString()
                    .replaceAll(RegExp('[\',\"]'), "''")
                    : null,

                entrepotId: (firstEmplacement.indexOf(columnSheet[1][2]) < 0)
                    ? null
                    : row[firstEmplacement.indexOf(columnSheet[1][2])],

                barCodeEmp: (firstEmplacement.indexOf(columnSheet[1][3]) < 0)
                    ? null
                    : (row[firstEmplacement.indexOf(columnSheet[1][3])] != null)
                    ? row[firstEmplacement.indexOf(columnSheet[1][3])]
                    .toString()
                    .replaceAll(RegExp('[\',\"]'), "''")
                    : null,

              );
              //await DBProvider.db.checkEmplacement(emplacement);
              if(isImporting == true ){
                await DBProvider.db.newEmplacement(emplacement);
              }else{
                if ((await DBProvider.db.checkEmplacement(emplacement)) == null) {
                  await DBProvider.db.newEmplacement(emplacement);
                }
              }

            }
          }
        }

        /* StockSys */
        if (excel.tables.keys.contains(filesName[2])) {
          List<dynamic> firstStockSys;
          firstStockSys = excel.tables[filesName[2]].rows.first;

          for (var row in excel.tables[filesName[2]].rows) {
            print(row);
            if (!row.contains(columnSheet[2][0])) {
              StockSystem stockSystem = new StockSystem(
                id: (firstStockSys.indexOf(columnSheet[2][0]) < 0) ? null : row[firstStockSys.indexOf(columnSheet[2][0])],

                emplacementId: (firstStockSys.indexOf(columnSheet[2][1]) < 0) ? null : row[firstStockSys.indexOf(columnSheet[2][1])],

                productId: (firstStockSys.indexOf(columnSheet[2][2]) < 0) ? null : row[firstStockSys.indexOf(columnSheet[2][2])],

                productLotId: (firstStockSys.indexOf(columnSheet[2][3]) < 0)
                    ? null
                    : row[firstStockSys.indexOf(columnSheet[2][3])],

                quantity: (firstStockSys.indexOf(columnSheet[2][4]) < 0)
                    ? null
                    : row[firstStockSys.indexOf(columnSheet[2][4])],
              );
              // await DBProvider.db.checkStockSystem(stockSystem);
              if(isImporting == true ){
                await DBProvider.db.newStockSystem(stockSystem);
              }else{
                if ((await DBProvider.db.checkStockSystem(stockSystem)) == null) {
                  await DBProvider.db.newStockSystem(stockSystem);
                }
              }

            }
          }
        }

        /* Product */
        if (excel.tables.keys.contains(filesName[3])) {
          List<dynamic> firstProduct;
          firstProduct = excel.tables[filesName[3]].rows.first;

          for (var row in excel.tables[filesName[3]].rows) {
            print(row);
            if (!row.contains(columnSheet[3][0])) {
              Product product = new Product(

                id: (firstProduct.indexOf(columnSheet[3][0]) < 0) ? null : row[firstProduct.indexOf(columnSheet[3][0])],

                productCode: (firstProduct.indexOf(columnSheet[3][1]) < 0)
                    ? null
                    : (row[firstProduct.indexOf(columnSheet[3][1])] != null)
                    ? row[firstProduct.indexOf(columnSheet[3][1])].toString().replaceAll(
                    RegExp('[\',\"]'), "''")
                    : null,

                nom: (firstProduct.indexOf(columnSheet[3][2]) < 0) ? null : (row[firstProduct.indexOf(columnSheet[3][2])] != null)
                    ? row[firstProduct.indexOf(columnSheet[3][2])].replaceAll("'", "''")
                    : null,

                categoryId: (firstProduct.indexOf(columnSheet[3][3]) < 0)
                    ? null
                    : row[firstProduct.indexOf(columnSheet[3][3])],

                gestionLot: (firstProduct.indexOf(columnSheet[3][4]) < 0)
                    ? null
                    : (row[firstProduct.indexOf(columnSheet[3][4])] != null)
                    ? row[firstProduct.indexOf(columnSheet[3][4])]
                    .toString()
                    .replaceAll(RegExp('[\',\"]'), "''")
                    : null,
                productType: (firstProduct.indexOf(columnSheet[3][5]) < 0)
                    ? null
                    : (row[firstProduct.indexOf(columnSheet[3][5])] != null)
                    ? row[firstProduct.indexOf(columnSheet[3][5])]
                    .toString()
                    .replaceAll(RegExp('[\',\"]'), "''")
                    : null,
              );
              //await DBProvider.db.checkProduct(product);
              if(isImporting == true ){
                await DBProvider.db.newProduct(product);
              }{
                if ((await DBProvider.db.checkProduct(product)) == null) {
                  await DBProvider.db.newProduct(product);
                }
              }

            }
          }
        }

        /* ProductLot */
        if (excel.tables.keys.contains(filesName[4])) {
          List<dynamic> firstProductLot;
          firstProductLot = excel.tables[filesName[4]].rows.first;

          for (var row in excel.tables[filesName[4]].rows) {
            print(row);

            if (!row.contains(columnSheet[4][0])) {
              ProductLot productLot = new ProductLot(
                id: (firstProductLot.indexOf(columnSheet[4][0]) < 0)
                    ? null
                    : row[firstProductLot.indexOf(columnSheet[4][0])],

                immatriculation: (firstProductLot.indexOf(columnSheet[4][1]) <
                    0) ? null : (row[firstProductLot.indexOf(
                    columnSheet[4][1])] != null) ? row[firstProductLot.indexOf(
                    columnSheet[4][1])].toString().replaceAll(
                    RegExp('[\',\"]'), "''") : null,

                numSerie: (firstProductLot.indexOf(columnSheet[4][2]) < 0)
                    ? null
                    : (row[firstProductLot.indexOf(columnSheet[4][2])] != null)
                    ? row[firstProductLot.indexOf(columnSheet[4][2])]
                    .toString()
                    .replaceAll(RegExp('[\',\"]'), "''")
                    : null,

                numLot: (firstProductLot.indexOf(columnSheet[4][3]) < 0)
                    ? null
                    : (row[firstProductLot.indexOf(columnSheet[4][3])] != null)
                    ? row[firstProductLot.indexOf(columnSheet[4][3])]
                    .toString()
                    .replaceAll(RegExp('[\',\"]'), "''")
                    : null,

                productId: (firstProductLot.indexOf(columnSheet[4][4]) < 0)
                    ? null
                    : row[firstProductLot.indexOf(columnSheet[4][4])],
              );
              //await DBProvider.db.checkProductLot(productLot);
              if(isImporting == true ){
                await DBProvider.db.newProductLot(productLot);
              }else{
                if ((await DBProvider.db.checkProductLot(productLot)) == null) {
                  await DBProvider.db.newProductLot(productLot);
                }
              }

            }
          }
        }

        /*Site */
        if (excel.tables.keys.contains(filesName[5])) {
        List<dynamic> firstProductLot;
        firstProductLot = excel.tables[filesName[5]].rows.first;

        for (var row in excel.tables[filesName[5]].rows) {
          print(row);

          if (!row.contains(columnSheet[5][0])) {
            Site site = new Site(
              id: (firstProductLot.indexOf(columnSheet[5][0]) < 0)
                  ? null
                  : row[firstProductLot.indexOf(columnSheet[5][0])],

              nom: (firstProductLot.indexOf(columnSheet[5][1]) < 0) ? null : (row[firstProductLot.indexOf(
                  columnSheet[5][1])] != null) ? row[firstProductLot.indexOf(
                  columnSheet[5][1])].toString().replaceAll(
                  RegExp('[\',\"]'), "''") : null,

            );
            //await DBProvider.db.checkProductLot(productLot);
            if(isImporting == true ){
              await DBProvider.db.newSite(site);
            }else{
              if ((await DBProvider.db.checkSite(site)) == null) {
                await DBProvider.db.newSite(site);
              }
            }

          }
        }
      }

        /* Company */
        if (excel.tables.keys.contains(filesName[6])) {
          List<dynamic> firstProductLot;
          firstProductLot = excel.tables[filesName[6]].rows.first;

          for (var row in excel.tables[filesName[6]].rows) {
            print(row);

            if (!row.contains(columnSheet[6][0])) {
              Company company = new Company(
                id: (firstProductLot.indexOf(columnSheet[6][0]) < 0)
                    ? null
                    : row[firstProductLot.indexOf(columnSheet[6][0])],

                nom: (firstProductLot.indexOf(columnSheet[6][1]) <
                    0) ? null : (row[firstProductLot.indexOf(
                    columnSheet[6][1])] != null) ? row[firstProductLot.indexOf(
                    columnSheet[6][1])].toString().replaceAll(
                    RegExp('[\',\"]'), "''") : null,

                logo: (firstProductLot.indexOf(columnSheet[6][2]) < 0)
                    ? null
                    : (row[firstProductLot.indexOf(columnSheet[6][2])] != null)
                    ? row[firstProductLot.indexOf(columnSheet[6][2])]
                    .toString()
                    .replaceAll(RegExp('[\',\"]'), "''")
                    : null,

                siteId:(firstProductLot.indexOf(columnSheet[6][3]) < 0)
                    ? null
                    : row[firstProductLot.indexOf(columnSheet[6][3])],
              );
              //await DBProvider.db.checkProductLot(productLot);
              if(isImporting == true ){
                await DBProvider.db.newCompany(company);
              }else{
                if ((await DBProvider.db.checkCompany(company)) == null) {
                  await DBProvider.db.newCompany(company);
                }
              }

            }
          }
        }

        /* StockEntrepot */
        if (excel.tables.keys.contains(filesName[7])) {
          List<dynamic> firstProductLot;
          firstProductLot = excel.tables[filesName[7]].rows.first;

          for (var row in excel.tables[filesName[7]].rows) {
            print(row);

            if (!row.contains(columnSheet[7][0])) {
              StockEntrepot stockEntrPot = new StockEntrepot(
                id: (firstProductLot.indexOf(columnSheet[7][0]) < 0)
                    ? null
                    : row[firstProductLot.indexOf(columnSheet[7][0])],

                nom: (firstProductLot.indexOf(columnSheet[7][1]) <
                    0) ? null : (row[firstProductLot.indexOf(
                    columnSheet[7][1])] != null) ? row[firstProductLot.indexOf(
                    columnSheet[7][1])].toString().replaceAll(
                    RegExp('[\',\"]'), "''") : null,

                directionType:(firstProductLot.indexOf(columnSheet[7][2]) < 0)
                    ? null
                    : (row[firstProductLot.indexOf(columnSheet[7][2])] != null)
                    ? row[firstProductLot.indexOf(columnSheet[7][2])]
                    .toString()
                    .replaceAll(RegExp('[\',\"]'), "''")
                    : null,

                companyId: (firstProductLot.indexOf(columnSheet[7][3]) < 0)
                    ? null
                    : row[firstProductLot.indexOf(columnSheet[7][3])],

                directionId: (firstProductLot.indexOf(columnSheet[7][4]) < 0)
                    ? null
                    : row[firstProductLot.indexOf(columnSheet[7][4])],
              );
              //await DBProvider.db.checkProductLot(productLot);
              if(isImporting == true ){
                await DBProvider.db.newStockEntrepot(stockEntrPot);
              }else{
                if ((await DBProvider.db.checkStockEntrepot(stockEntrPot)) == null) {
                  await DBProvider.db.newStockEntrepot(stockEntrPot);
                }
              }

            }
          }
        }

        /* ProductCategory */
        if (excel.tables.keys.contains(filesName[8])) {
          List<dynamic> firstProductLot;
          firstProductLot = excel.tables[filesName[8]].rows.first;

          for (var row in excel.tables[filesName[8]].rows) {
            print(row);

            if (!row.contains(columnSheet[8][0])) {
              ProductCategory categoryProduct = new ProductCategory(
                id: (firstProductLot.indexOf(columnSheet[8][0]) < 0)
                    ? null
                    : row[firstProductLot.indexOf(columnSheet[8][0])],

                categoryName: (firstProductLot.indexOf(columnSheet[8][1]) <
                    0) ? null : (row[firstProductLot.indexOf(
                    columnSheet[8][1])] != null) ? row[firstProductLot.indexOf(
                    columnSheet[8][1])].toString().replaceAll(
                    RegExp('[\',\"]'), "''") : null,

                categoryCode:(firstProductLot.indexOf(columnSheet[8][2]) < 0)
                    ? null
                    : (row[firstProductLot.indexOf(columnSheet[8][2])] != null)
                    ? row[firstProductLot.indexOf(columnSheet[8][2])]
                    .toString()
                    .replaceAll(RegExp('[\',\"]'), "''")
                    : null,

                parentPath: (firstProductLot.indexOf(columnSheet[8][3]) < 0)
                    ? null
                    : (row[firstProductLot.indexOf(columnSheet[8][3])] != null)
                    ? row[firstProductLot.indexOf(columnSheet[8][3])]
                    .toString()
                    .replaceAll(RegExp('[\',\"]'), "''")
                    : null,

                parentId: (firstProductLot.indexOf(columnSheet[8][4]) < 0)
                    ? null
                    : row[firstProductLot.indexOf(columnSheet[8][4])],
              );
              //await DBProvider.db.checkProductLot(productLot);
              if(isImporting == true ){
                await DBProvider.db.newProductCategory(categoryProduct);
              }else{
                if ((await DBProvider.db.checkProductCategory(categoryProduct)) == null) {
                  await DBProvider.db.newProductCategory(categoryProduct);
                }
              }

            }
          }
        }


    }
    }

  Future<bool> importInDataBase()async{

    String? lotTable = "Empty";
    List<String> tables =["Empty","Empty","Empty","Empty","Empty"];

    int totalProductLots =0;


    await DBProvider.db.clearAllTables()
        .then((value) async{
              Inventory? invIncomplete = (await DBProvider.db.getIncompleteInventory());
              if(invIncomplete != null) {
                await DBProvider.db.clearInventoryWithLines(invIncomplete);
              }

              try{
                if((await this.file.exists())==true){

                  await backgroundFunction(true);

                }else{ throw "we haven't a file";}




                /* stock system  */

                  await DBProvider.db.saveStocksOfEmplacement();

                  /* Site */
                if((await DBProvider.db.getAllSites()).isNotEmpty)tables[0] = "Done";

                /* Company */
                if((await DBProvider.db.getAllCompanies()).isNotEmpty)tables[1] = "Done";

                /* StockEntrepot */
                if((await DBProvider.db.getAllStockEntrepots()).isNotEmpty)tables[2] = "Done";

                /* Emplacement */
                if((await DBProvider.db.getAllEmplacements()).isNotEmpty)tables[3] = "Done";

                /* StockSys */
                if((await DBProvider.db.getAllStockSystems()).isNotEmpty)tables[4] = "Done";



                /* product lot  */
                if((await DBProvider.db.getAllProductLots()).isNotEmpty){

                  lotTable = "Done";

                  totalProductLots = (await DBProvider.db.getAllProductLots()).length;

                  DateTime dateTime =  DateTime(2000,1,1);
                  String oldDate = dateTime.toIso8601String();

                  await  DBProvider.db.newInventory(new Inventory(
                      closeDate: oldDate,
                      openingDate: DateTime.now().toIso8601String(),
                      status:"begin"
                  ));



                }else{ lotTable = "Empty"; totalProductLots = 0; throw "il n'y a pas des lots"; }


              }catch(e){ throw "catch error : "+e.toString(); }




               })
        .catchError((err)=>throw err);

User? user = await DBProvider.db.getUser(1);
    if(user!=null){
      user.allProductLots = totalProductLots;
        user.productLotsTable = lotTable;
        user.siteTable = tables[0];
        user.companyTable = tables[1];
        user.entrePotTable = tables[2];
        user.emplacementTable = tables[3];
        user.stockSysTable = tables[4];
      await DBProvider.db.updateUser(user );
    }



    await MainProvider().getUser();

  return ((await DBProvider.db.getAllProductLots()).isNotEmpty)?true:false;

  }

  Future<bool> updateDataBase()async{
    String lotTable = "Empty";
    List<String> tables =["Empty","Empty","Empty","Empty","Empty"];

    int totalProductLots =0;

    try{

      if((await this.file.exists())==true){

        await backgroundFunction(false);

      }else{ throw "we haven't a file";}


        await DBProvider.db.saveStocksOfEmplacement();


      /* Site */
      if((await DBProvider.db.getAllSites()).isNotEmpty)tables[0] = "Done";

      /* Company */
      if((await DBProvider.db.getAllCompanies()).isNotEmpty)tables[1] = "Done";

      /* StockEntrepot */
      if((await DBProvider.db.getAllStockEntrepots()).isNotEmpty)tables[2] = "Done";

      /* Emplacement */
      if((await DBProvider.db.getAllEmplacements()).isNotEmpty)tables[3] = "Done";

      /* StockSys */
      if((await DBProvider.db.getAllStockSystems()).isNotEmpty)tables[4] = "Done";


      /* product lot  */
      if((await DBProvider.db.getAllProductLots()).isNotEmpty){
        totalProductLots = (await DBProvider.db.getAllProductLots()).length;
        lotTable = "Done";

      }else{ lotTable = "Empty"; totalProductLots = 0; throw "il n'y a pas des lots"; }


    }catch(e){ throw "catch error : "+e.toString(); }


    User? user = await DBProvider.db.getUser(1);
    if(user!=null){
      user.allProductLots = totalProductLots;
      user.productLotsTable = lotTable;
        user.siteTable = tables[0];
        user.companyTable = tables[1];
        user.entrePotTable = tables[2];
        user.emplacementTable = tables[3];
        user.stockSysTable = tables[4];
      await DBProvider.db.updateUser(user );
    }

    await MainProvider().getUser();
    return ((await DBProvider.db.getAllProductLots()).isNotEmpty)?true:false;
  }

  Future<void> renewWork(context)async{
    DateTime dateTime =  DateTime(2000,1,1);
    String oldDate = dateTime.toIso8601String();
    Inventory inv = new Inventory(status: "begin", closeDate: oldDate, openingDate: DateTime.now().toIso8601String());
    await DBProvider.db.newInventory(inv);
    HomeProvider().changeSelecter(0, context, "/inventoryList");
    Navigator.pop(context);
    HomeProvider().setState();
    //Navigator.pushNamed(context, "/home");
    //notifyListeners();

    
    
  }
  
  Future<void> resetInventory(context)async{
    
    Inventory? inv = await DBProvider.db.getIncompleteInventory();
    if(inv != null){
      await DBProvider.db.resetInventory(inv);
      // print(DateTime.tryParse(inv.openingDate??DateTime.now().toIso8601String()));
      //  print(inv.status);
    }
    HomeProvider().changeSelecter(0, context, "/inventoryList");
    Navigator.pop(context);
    HomeProvider().setState();
    //Navigator.pushNamed(context, "/home");
    //notifyListeners();
  }



}
