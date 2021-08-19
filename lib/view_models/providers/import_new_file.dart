import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:scanapp/data/database.dart';
import 'package:scanapp/models/database_models/Companies.dart';
import 'package:scanapp/models/database_models/emplacements.dart';
import 'package:scanapp/models/database_models/inventories.dart';
import 'package:scanapp/models/database_models/product_categories.dart';
import 'package:scanapp/models/database_models/product_lots.dart';
import 'package:scanapp/models/database_models/products.dart';
import 'package:scanapp/models/database_models/sites.dart';
import 'package:scanapp/models/database_models/stock_entrepots.dart';
import 'package:scanapp/models/database_models/stock_systems.dart';
import 'package:scanapp/models/database_models/user.dart';
import 'package:scanapp/models/variables_define/colors.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

class ImportNewFileProvider extends ChangeNotifier{
  static ImportNewFileProvider? _instance;
  ImportNewFileProvider._();
  factory ImportNewFileProvider() => _instance ??=ImportNewFileProvider._();

  late File file;

  Future<void> pickFileExcel(context)async{


      try{
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['xlsx'],
        );

        if(result != null) {
          file  = File(result.files.first.path??"");
          print(file.path);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => processSaving(context,"import"), //Nedjm(),//
            ),
          );


        }
      }catch(e){throw "aucun fichier ";}



  }

  Future<void> showDialogToImportFile(BuildContext context,String text) async {

    String title = (text=="new")?"Importer nouveau Fichier":"Mettre à jour le fichier";

    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return   Center(
            child: SingleChildScrollView(

              child: AlertDialog(
                backgroundColor:ColorsOf().primaryBackGround(),

                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                content: Text("Importer Fichier", style: TextStyle(color: ColorsOf().containerThings(),fontSize:14,),),
                title: Text(title,style: TextStyle(color: ColorsOf().containerThings() ),),
                actions: <Widget>[

                  MaterialButton(
                    color:ColorsOf().containerThings() ,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: EdgeInsets.all(0),
                    child: Text("Importer" ,style: TextStyle(color: ColorsOf().primaryBackGround()),),


                    onPressed: ()=>pickFileExcel(context),


                  ),


                  MaterialButton(
                    color:ColorsOf().containerThings() ,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: EdgeInsets.all(0),
                    child: Text("Importer" ,style: TextStyle(color: ColorsOf().primaryBackGround()),),

                    onPressed: (){},

                  ),


                  MaterialButton(
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


  Widget processSaving(context,text){

    String meg = (text == "import")?"Importer Fichier.....":"Mettre à jour.....";

    return Scaffold(
      backgroundColor: ColorsOf().backGround(),
      body: FutureBuilder(
        future: saveInDataBase(),
        builder: (context, snapshot) {
          print(snapshot);

          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data != null) {
           String res =  (snapshot.data == true)?"Success":"Failed";
            return whenFinishProcess(context, res);
          }

          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              width: 200,
              height: 200,
              child: Column(
                children: [
                  CircleAvatar(
                      backgroundColor: ColorsOf().backGround(),
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

  Widget whenFinishProcess(context,text){
    String msg = (text == "Success")? "le processus est terminé avec succès":"le processus a échoué";
    Color aColor =  (text == "Success")? ColorsOf().finisheItem():ColorsOf().deleteItem();


    return Scaffold(
      backgroundColor: ColorsOf().backGround(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          width: 200,
          height: 200,
          child: Column(
            children: [

              Text(msg, style: TextStyle(fontSize: 16 , color: aColor,),),
              SizedBox(height: 20,),
              MaterialButton(
                color:ColorsOf().containerThings() ,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                padding: EdgeInsets.all(0),
                child: Text("Retournez à la page d'accueil" ,style: TextStyle(color: ColorsOf().primaryBackGround()),),


                onPressed: ()async{

                  print("This Emplacement ================= ");
                  print((await DBProvider.db.getAllSites()));
                },


              ),

            ],
          ),

        ),
      ),
    );
  }



/*

  Future<bool> _requestPermission(Permission per) async{

    if(await per.isGranted){
      return true;
    }else {
      var result = await per.request();
      if(result == PermissionStatus.granted){ return true; }else {return false;}
    }

  }
  
  */

  Future<bool> saveInDataBase()async{
    
    var excel ;
    List<String> filesName = ["Site","Company","Entrepot","Emplacement","StockSystem","Product","Lot","Category",];
   
    //bool loading = false;
    List<String> listing = ["Empty","Empty","Empty","Empty","Empty","Empty","Empty","Empty"];
    int totalStockSys =0;


    await DBProvider.db.clearAllTables()
        .then((value) async{
              Inventory? invIncomplete = (await DBProvider.db.getIncompleteInventory());
              if(invIncomplete != null) {
                await DBProvider.db.clearIncompleteInventory(invIncomplete);
              }

              try{
                if((await this.file.exists())==true){


                  var bytes = this.file.readAsBytesSync();



                  if(bytes!=null){
                     excel = SpreadsheetDecoder.decodeBytes(bytes, update: true);
                    if(excel!=null){
                      /*  Site */
                      if(excel.tables.keys.contains(filesName[0])){
                        List<dynamic> firstSite;
                        firstSite = excel.tables[filesName[0]].rows.first;

                        for (var row in excel.tables[filesName[0]].rows) {

                           if(!row.contains("id")){
                             print(row);
                             print(row[firstSite.indexOf("nom")]);
                            Site site;
                            site = new Site(
                                id: int.parse(row[firstSite.indexOf("id")].toString()),
                                nom:(firstSite.indexOf("nom")<0 )?null: row[firstSite.indexOf("nom")]
                            );

                          //  await DBProvider.db.checkSite(site);

                          if((await DBProvider.db.checkSite(site)) == null){

                              await DBProvider.db.newSite(site);

                            }

                          }
                        }
                      }
/*
                      /* Company */
                      if(excel.tables.keys.contains(filesName[1])){

                        List<dynamic> firstCompany;
                        firstCompany = excel.tables[filesName[1]].rows.first;
                        for (var row in excel.tables[filesName[1]].rows) {

                          if(!row.contains("id")){
                            Company company;
                            company = new Company(

                              nom: (firstCompany.indexOf("nom")<0)?null:row[firstCompany.indexOf("nom")],

                              siteId: (firstCompany.indexOf("site_id")<0)?null:int.parse(row[firstCompany.indexOf("site_id")]),

                              logo: (firstCompany.indexOf("logo")<0)?null:row[firstCompany.indexOf("logo")],

                            );
                            await DBProvider.db.checkCompany(company);
                            /*
                            if((await DBProvider.db.checkCompany(company)) == null){
                              await DBProvider.db.newCompany(company);
                            }*/



                          }
                        }

                      }

                      /* Entrepot */
                      if(excel.tables.keys.contains(filesName[2])){

                        List<dynamic> firstStock;
                        firstStock = excel.tables[filesName[2]].rows.first;

                        for (var row in excel.tables[filesName[2]].rows) {

                          if(!row.contains("id")){
                            StockEntrepot stockEntrepot;
                            stockEntrepot = new StockEntrepot(
                              directionType: (firstStock.indexOf("DirectionType")<0)?null:row[firstStock.indexOf("DirectionType")],
                              companyId: (firstStock.indexOf("CompanyId")<0)?null:int.parse(row[firstStock.indexOf("CompanyId")]) ,
                              directionId:  (firstStock.indexOf("DirectionId")<0)?null:int.parse(row[firstStock.indexOf("DirectionId")]),
                              nom:  (firstStock.indexOf("nom")<0)?null:row[firstStock.indexOf("nom")],
                            );
                            await DBProvider.db.checkStockEntrepot(stockEntrepot);
                            /*if((await DBProvider.db.checkStockEntrepot(stockEntrepot)) == null){
                              await  DBProvider.db.newStockEntrepot(stockEntrepot);
                            }*/

                          }
                        }

                      }

                      /* Emplacement */
                      if(excel.tables.keys.contains(filesName[3])){

                        List<dynamic> firstEmplacement;
                        firstEmplacement = excel.tables[filesName[3]].rows.first;

                        for (var row in excel.tables[filesName[3]].rows) {

                          if(!row.contains("id")){
                            Emplacement emplacement = new Emplacement(

                              nom: (firstEmplacement.indexOf("nom")<0)?null:row[firstEmplacement.indexOf("nom")],
                              entrepotId: (firstEmplacement.indexOf("enterpot-id")<0)?null:int.parse(row[firstEmplacement.indexOf("enterpot-id")]),
                              barCodeEmp: (firstEmplacement.indexOf("barcodeemp")<0)?null:row[firstEmplacement.indexOf("barcodeemp")],

                            );
                            await DBProvider.db.checkEmplacement(emplacement);
                            /*
                            if((await DBProvider.db.checkEmplacement(emplacement)) == null){
                              await DBProvider.db.newEmplacement(emplacement);
                            }*/

                          }
                        }

                      }

                      /* StockSys */
                      if(excel.tables.keys.contains(filesName[4])){

                        List<dynamic> firstStockSys;
                        firstStockSys = excel.tables[filesName[4]].rows.first;

                        for (var row in excel.tables[filesName[4]].rows) {

                          if(!row.contains("id")){

                            StockSystem stockSystem = new StockSystem(
                              emplacementId:(firstStockSys.indexOf("EmplacmentId")<0)?null:int.parse(row[firstStockSys.indexOf("EmplacmentId")]),
                              productId:(firstStockSys.indexOf("ProductId")<0)?null:int.parse(row[firstStockSys.indexOf("ProductId")]),
                              productLotId:(firstStockSys.indexOf("ProductLotId")<0)?null:int.parse(row[firstStockSys.indexOf("ProductLotId")]),
                              quantity:(firstStockSys.indexOf("Quantity")<0)?null:int.parse(row[firstStockSys.indexOf("Quantity")]),
                            );
                            await DBProvider.db.checkStockSystem(stockSystem);
                            /*
                            if((await DBProvider.db.checkStockSystem(stockSystem)) == null){
                              await DBProvider.db.newStockSystem(stockSystem);
                            }*/

                          }
                        }

                      }

                      /* Product */
                      if(excel.tables.keys.contains(filesName[5])){

                        List<dynamic> firstProduct;
                        firstProduct = excel.tables[filesName[5]].rows.first;

                        for (var row in excel.tables[filesName[5]].rows) {


                          if(!row.contains("id")){

                            Product product = new Product(
                              productCode:(firstProduct.indexOf("code")<0)?null:row[firstProduct.indexOf("code")],
                              nom:(firstProduct.indexOf("nom")<0)?null:row[firstProduct.indexOf("nom")],
                              categoryId:(firstProduct.indexOf("categoryId")<0)?null:row[firstProduct.indexOf("categoryId")],
                              gestionLot:(firstProduct.indexOf("gestionLot")<0)?null:row[firstProduct.indexOf("gestionLot")],
                              productType:(firstProduct.indexOf("producttype")<0)?null:row[firstProduct.indexOf("producttype")],
                            );
                            await DBProvider.db.checkProduct(product);
                            /*
                            if((await DBProvider.db.checkProduct(product)) == null){
                              await  DBProvider.db.newProduct(product);
                            }*/

                          }
                        }

                      }

                      /* ProductLot */
                      if(excel.tables.keys.contains(filesName[6])){

                        List<dynamic> firstProductLot;
                        firstProductLot = excel.tables[filesName[6]].rows.first;

                        for (var row in excel.tables[filesName[6]].rows) {


                          if(!row.contains("id")){

                            ProductLot productLot = new ProductLot(
                              immatriculation:(firstProductLot.indexOf("immatriculation")<0)?null:row[firstProductLot.indexOf("immatriculation")],
                              numSerie:(firstProductLot.indexOf("num_serie")<0)?null:row[firstProductLot.indexOf("num_serie")],
                              numLot:(firstProductLot.indexOf("num_lot")<0)?null:row[firstProductLot.indexOf("num_lot")],
                              productId:(firstProductLot.indexOf("product_id")<0)?null:row[firstProductLot.indexOf("product_id")],
                            );
                            await DBProvider.db.checkProductLot(productLot);
                            /*
                            if((await DBProvider.db.checkProductLot(productLot)) == null ){
                              await DBProvider.db.newProductLot(productLot);
                            }*/

                          }
                        }

                      }

                      /* Product category  */
                      if(excel.tables.keys.contains(filesName[7])){

                        List<dynamic> firstProductCategory;
                        firstProductCategory = excel.tables[filesName[7]].rows.first;

                        for (var row in excel.tables[filesName[7]].rows) {

                          if(!row.contains("id")){

                            ProductCategory productCategory = new ProductCategory(
                              categoryName:(firstProductCategory.indexOf("nom")<0)?null:row[firstProductCategory.indexOf("nom")],
                              categoryCode: (firstProductCategory.indexOf("code")<0)?null:row[firstProductCategory.indexOf("code")],
                              parentId: (firstProductCategory.indexOf("parentId")<0)?null:int.parse(row[firstProductCategory.indexOf("parentId")]),
                              parentPath:(firstProductCategory.indexOf("parentPath")<0)?null:row[firstProductCategory.indexOf("parentPath")],
                            );
                            await DBProvider.db.checkProductCategory(productCategory);
                            /*
                            if((await DBProvider.db.checkProductCategory(productCategory)) == null){
                              await  DBProvider.db.newProductCategory(productCategory);
                            }*/

                          }
                        }

                      }
*/
                    }




                  }

                }else{ throw "we haven't a file";}
/*
                /* check site  */
                if((await DBProvider.db.getAllSites()).isNotEmpty){listing[0] = "Done";} else listing[0] = "Empty";

                /* check company  */
                if((await DBProvider.db.getAllCompanies()).isNotEmpty){listing[1] = "Done";} else listing[1] = "Empty";

                /* check entrepot */
                if((await DBProvider.db.getAllStockEntrepots()).isNotEmpty){listing[2] = "Done";} else listing[2] = "Empty";

                /* stock system  */
                if((await DBProvider.db.getAllStockSystems()).isNotEmpty){
                  listing[4] = "Done";
                  totalStockSys = (await DBProvider.db.getAllStockSystems()).length;
                  await DBProvider.db.saveStocksOfEmplacement();


                }else{listing[4] = "Empty"; totalStockSys = 0;}

                /*Emplacement */
                if((await DBProvider.db.getAllEmplacements()).isNotEmpty){listing[3] = "Done";} else listing[3] = "Empty";

                /* products  */
                if((await DBProvider.db.getAllProducts()).isNotEmpty){listing[5] = "Done";} else listing[5] = "Empty";

                /* product category  */
                if((await DBProvider.db.getAllProductCategories()).isNotEmpty){listing[7] = "Done";} else listing[7] = "Empty";
                /* product lot  */
                if((await DBProvider.db.getAllProductLots()).isNotEmpty){
                  listing[7] = "Done";
                  await  DBProvider.db.newInventory(new Inventory(
                      closeDate: DateTime(2000, 1, 1).toIso8601String(),
                      openingDate: DateTime.now().toIso8601String()
                  ));

                  return true;

                }else{ listing[6] = "Empty"; throw "il n'y a pas des lots"; }

*/
              }catch(e){ throw "catch error : "+e.toString(); }




               })
        .catchError((err)=>throw err);
/*
await DBProvider.db.updateUser(new User(
  allStocks: totalStockSys,
  sitesTable: listing[0],
  companyTable: listing[1],
  stockEnterpriseTable: listing[2],
  bureauxTable: listing[3],
  stockSystemTable: listing[4],
  produitsTable: listing[5],
  productLotsTable: listing[6],
  categoriesTable: listing[7],

));
*/
  return ((await DBProvider.db.getAllSites()).isNotEmpty)?true:false;

  }




}
