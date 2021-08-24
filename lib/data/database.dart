import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';



import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scanapp/models/database_models/company.dart';
import 'package:scanapp/models/database_models/counter_stocks_in_emplacement.dart';
import 'package:scanapp/models/database_models/emplacements.dart';
import 'package:scanapp/models/database_models/inventories.dart';
import 'package:scanapp/models/database_models/inventory_lines.dart';
import 'package:scanapp/models/database_models/product_category.dart';
import 'package:scanapp/models/database_models/product_lots.dart';
import 'package:scanapp/models/database_models/products.dart';
import 'package:scanapp/models/database_models/site.dart';
import 'package:scanapp/models/database_models/stock_entre_pot.dart';
import 'package:scanapp/models/database_models/stock_systems.dart';
import 'package:scanapp/models/database_models/user.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static Database? _database;

  Future<Database> get database async {
    // ignore: unnecessary_null_comparison
    if (_database != null)
      return _database!;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database!;
  }


  initDB() async {
   String str ="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";
   //final List<int> codeUnits = str.codeUnits;

    final Uint8List unit8List = base64.decode(str);


    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "scanApp.db");
    return await openDatabase(path, version: 1,
        onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE User ("
              "id INTEGER PRIMARY KEY,"
              "allProductLots INTEGER,"
              "logoName TEXT,"
              "logoImage BLOB,"
              "phoneEnterprise TEXT,"
              "addressEnterprise TEXT,"
              "adminPassword TEXT,"
              "userPasswordReset TEXT,"
              "userPasswordActually TEXT,"
              "isDark TEXT,"

              "siteTable TEXT,"
              "companyTable TEXT,"
              "entrePotTable TEXT,"
              "stockSysTable TEXT,"
              "emplacementTable TEXT,"

              "productLotsTable TEXT"
              ")");
          await db.insert("User", {
            "id":1,
            "allProductLots":0,
            "logoName":"Fecom IT",
            "logoImage":unit8List,
            "phoneEnterprise":"023 56 41 40",
            "addressEnterprise":"09, Coopérative El Moustakbel, Birkhadem. Alger, Algérie",
            "adminPassword":"123456",
            "userPasswordReset":"123456",
            "userPasswordActually":"123456",
            "isDark":"light",
            "productLotsTable":"Empty",

            "siteTable":"Empty",
            "companyTable":"Empty",
            "entrePotTable":"Empty",
            "stockSysTable":"Empty",
            "emplacementTable":"Empty",

          });
          await db.execute("CREATE TABLE Site ("
              "id INTEGER,"
              "nom TEXT"
              ")");
          await db.execute("CREATE TABLE Company ("
              "id INTEGER,"
              "nom TEXT,"
              "siteId INTEGER,"
              "logo TEXT"
              ")");
          await db.execute("CREATE TABLE StockEntrepot ("
              "id INTEGER,"
              "nom TEXT,"
              "companyId INTEGER,"
              "directionType TEXT,"
              "directionId INTEGER"
              ")");
          await db.execute("CREATE TABLE ProductCategory ("
              "id INTEGER,"
              "categoryName TEXT,"
              "categoryCode TEXT,"
              "parentId INTEGER,"
              "parentPath TEXT"
              ")");

          await db.execute("CREATE TABLE StockSystem ("
              "id INTEGER,"
              "productId INTEGER,"
              "productLotId INTEGER,"
              "emplacementId INTEGER,"
              "quantity INTEGER"
              ")");
          await db.execute("CREATE TABLE Emplacement ("
              "id INTEGER,"
              "nom TEXT,"
              "entrepotId INTEGER,"
              "barCodeEmp TEXT"
              ")");
          await db.execute("CREATE TABLE Product ("
              "id INTEGER,"
              "nom TEXT,"
              "productCode TEXT,"
              "categoryId INTEGER,"
              "gestionLot TEXT,"
              "productType TEXT"
              ")");

          await db.execute("CREATE TABLE ProductLot ("
              "id INTEGER,"
              "productId INTEGER,"
              "numLot TEXT,"
              "numSerie TEXT,"
              "immatriculation TEXT"
              ")");
          await db.execute("CREATE TABLE Inventory ("
              "id INTEGER PRIMARY KEY,"
              "openingDate TEXT,"
              "status TEXT,"
              "closeDate TEXT"
              ")");
          await db.execute("CREATE TABLE InventoryLine ("
              "id INTEGER PRIMARY KEY,"
              "inventoryId INTEGER,"
              "productId INTEGER,"
              "emplacementId INTEGER,"
              "productLotId INTEGER,"
              "quantity INTEGER,"
              "quantitySystem INTEGER,"
              "difference INTEGER,"
              "quality TEXT"
              ")");
          await db.execute("CREATE TABLE StocksCounter ("
              "emplacementID INTEGER,"
              "number INTEGER"
              ")");
        });
  }

  newSite(Site newSite) async {
    final db = await database;
    var res = await db.insert("Site", newSite.toMap());
    return res;
  }
  newCompany(Company newCompany) async {
    final db = await database;
    var res = await db.insert("Company", newCompany.toMap());
    return res;
  }
  newStockEntrepot(StockEntrepot newStockEntrepot) async {
    final db = await database;
    var res = await db.insert("StockEntrepot", newStockEntrepot.toMap());
    return res;
  }
  newProductCategory(ProductCategory newProductCategory) async {
    final db = await database;
    var res = await db.insert("ProductCategory", newProductCategory.toMap());
    return res;
  }
  newEmplacement(Emplacement newEmplacement) async {
    final db = await database;
    var res = await db.insert("Emplacement", newEmplacement.toMap());
    return res;
  }
  newStockSystem(StockSystem newStockSystem) async {
    final db = await database;
    var res = await db.insert("StockSystem", newStockSystem.toMap());
    return res;
  }
  newProduct(Product newProduct) async {
    final db = await database;
    var res = await db.insert("Product", newProduct.toMap());
    return res;
  }
  newProductLot(ProductLot newProductLot) async {
    final db = await database;
    var res = await db.insert("ProductLot", newProductLot.toMap());
    return res;
  }

  newInventory(Inventory newInventory) async {
    final db = await database;
    var res = await db.insert("Inventory", newInventory.toMap());
    return res;
  }
  newInventoryLine(InventoryLine newInventoryLine) async {
    final db = await database;
    var res = await db.insert("InventoryLine", newInventoryLine.toMap());
    return res;
  }

  /* Delete */
  Future<void> clearStockCounet()async{
    final db = await database;
    //db.rawDelete("Delete * from History");
    try{
      await db.transaction((txn) async {
        var batch = txn.batch();

        batch.delete("StocksCounter");

        await batch.commit();
      });
    } catch(error){
      throw Exception('DbBase.cleanDatabase: ' + error.toString());
    }
  }

  Future<void> clearAllTables() async {
    final db = await database;
    //db.rawDelete("Delete * from History");
    try{
      await db.transaction((txn) async {
        var batch = txn.batch();

        batch.delete("Site");
        batch.delete("Company");
        batch.delete("StockEntrepot");
        batch.delete("StockSystem");
        batch.delete("Emplacement");
        batch.delete("Product");
        batch.delete("ProductCategory");
        batch.delete("ProductLot");
        batch.delete("StocksCounter");

        await batch.commit();
      });
    } catch(error){
      throw Exception('DbBase.cleanDatabase: ' + error.toString());
    }
  }
  Future<void> clearInventoryWithLines(Inventory inv) async {
    final db = await database;

    db.delete("Inventory", where: "id = ?", whereArgs: [inv.id]);
    db.delete("InventoryLine", where: "inventoryId = ?", whereArgs: [inv.id]);

  }

  /*  Get  */
  Future<User?> getUser(int id) async {
    final db = await database;
    var res =await  db.query("User", where: "id = ?", whereArgs: [id]);
    User? user;
    if(res.isNotEmpty) user = User.fromMap(res.first);
    return user;
  }

 Future<Inventory?> getIncompleteInventory() async {
    DateTime dateTime =  DateTime(2000,1,1);
    String oldDate = dateTime.toIso8601String();

    final db = await database;
    Inventory? inv;
    var res =await  db.query("Inventory", where: "closeDate = ?", whereArgs: [oldDate]);
    if(res.isNotEmpty) inv = Inventory.fromMap(res.first);
    return inv;
  }


  Future<Emplacement?> getEmplacement(int? id) async {
    final db = await database;
    var res =(id!=null)? (await  db.query("Emplacement", where: "id = ?", whereArgs: [id])) : (await db.rawQuery("SELECT * FROM Emplacement WHERE id IS null")) ;
    Emplacement? one;
    if(res.isNotEmpty) one = Emplacement.fromMap(res.first);
    return one;
  }
  Future<Site?> getSite(int id) async {
    final db = await database;
    var res =await  db.query("Site", where: "id = ?", whereArgs: [id]);
    Site? site;
    if(res.isNotEmpty) site = Site.fromMap(res.first);
    return site;
  }
  Future<Company?> getCompany(int id) async {
    final db = await database;
    var res =await  db.query("Company", where: "id = ?", whereArgs: [id]);
    Company? company;
    if(res.isNotEmpty) company = Company.fromMap(res.first);
    return company;
  }
  Future<StockEntrepot?> getStockEntrepot(int id) async {
    final db = await database;
    var res =await  db.query("StockEntrepot", where: "id = ?", whereArgs: [id]);
    StockEntrepot? stockEntrepot;
    if(res.isNotEmpty) stockEntrepot = StockEntrepot.fromMap(res.first);
    return stockEntrepot;
  }
  Future<StockSystem?> getStockSystem(int id) async {
    final db = await database;
    var res =await  db.query("StockSystem", where: "id = ?", whereArgs: [id]);
    StockSystem? one;
    if(res.isNotEmpty) one = StockSystem.fromMap(res.first);
    return one;
  }
  Future<Product?> getProduct(int? id) async {
    final db = await database;
    var res = (id!=null)?(await  db.query("Product", where: "id = ?", whereArgs: [id])):(await db.rawQuery("SELECT * FROM Product WHERE id IS null"));
    Product? one;
    if(res.isNotEmpty) one = Product.fromMap(res.first);
    return one;
  }
  Future<ProductLot?> getProductLot(int? id) async {
    final db = await database;
    //var res =await  db.query("ProductLot", where: "id = ?", whereArgs: [id]);
    var res = (id !=null) ?  (await db.rawQuery("SELECT * FROM ProductLot WHERE id = $id")):
    (await db.rawQuery("SELECT * FROM ProductLot WHERE id IS null"));
    ProductLot? one;
    if(res.isNotEmpty) one = ProductLot.fromMap(res.first);
    return one;
  }
  Future<ProductCategory?> getProductCategory(int id) async {
    final db = await database;
    var res =await  db.query("ProductCategory", where: "id = ?", whereArgs: [id]);
    ProductCategory? one;
    if(res.isNotEmpty) one = ProductCategory.fromMap(res.first);
    return one;
  }

  Future<Inventory?> getInventory(int id) async {
    final db = await database;
    var res =await  db.query("Inventory", where: "id = ?", whereArgs: [id]);
    Inventory? one;
    if(res.isNotEmpty) one = Inventory.fromMap(res.first);
    return one;
  }
  Future<InventoryLine?> getInventoryLine(int id) async {
    final db = await database;
    var res =await  db.query("InventoryLine", where: "id = ?", whereArgs: [id]);
    InventoryLine? one;
    if(res.isNotEmpty) one = InventoryLine.fromMap(res.first);
    return one;
  }

  /* Count  */
  Future<List<StocksCounter>> saveStocksOfEmplacement() async {
    final db = await database;
    var res = await db.rawQuery("SELECT  emplacementId , COUNT(id) FROM StockSystem GROUP BY emplacementId");
    List<StocksCounter> list =
    res.isNotEmpty ? res.map((c) => StocksCounter.fromMap(c)).toList() : [];

    if(list.isNotEmpty){

      for(int i =0 ; i< list.length; i++){

        await db.insert("StocksCounter", list[i].toMap());
      }

    }
    return list;
  }


  Future<List<StocksCounter>> getEachEmplacementStocks() async {
    final db = await database;
    var res = await db.rawQuery("SELECT  emplacementId , COUNT(id) FROM InventoryLine GROUP BY emplacementId");
    List<StocksCounter> list =
    res.isNotEmpty ? res.map((c) => StocksCounter.fromMap(c)).toList() : [];
    return list;
  }
  Future<List<StocksCounter>> getSiteFromCompany() async {
    final db = await database;
    var res = await db.rawQuery("SELECT  siteId AS emplacementId , COUNT(id) FROM Company GROUP BY siteId");
    List<StocksCounter> list =
    res.isNotEmpty ? res.map((c) => StocksCounter.fromMap(c)).toList() : [];
    return list;
  }
  Future<List<StocksCounter>> getCompaniesFromDirection() async {
    final db = await database;
    var res = await db.rawQuery("SELECT  companyId AS emplacementId , COUNT(id) FROM StockEntrepot GROUP BY companyId");
    List<StocksCounter> list =
    res.isNotEmpty ? res.map((c) => StocksCounter.fromMap(c)).toList() : [];
    return list;
  }
  Future<List<StocksCounter>> getSerivcesFromEmplacement() async {
    final db = await database;
    var res = await db.rawQuery("SELECT  entrepotId AS emplacementId, COUNT(id) FROM Emplacement GROUP BY entrepotId");
    List<StocksCounter> list =
    res.isNotEmpty ? res.map((c) => StocksCounter.fromMap(c)).toList() : [];
    return list;
  }
  Future<List<StocksCounter>> getEmplFromStockSys() async {
    final db = await database;
    var res = await db.rawQuery("SELECT  emplacementId, COUNT(id) FROM StockSystem GROUP BY emplacementId");
    List<StocksCounter> list =
    res.isNotEmpty ? res.map((c) => StocksCounter.fromMap(c)).toList() : [];
    return list;
  }

  /* get for update database */
  Future<Site?> checkSite(Site check) async {

    final db = await database;
    List<dynamic> myVaribles = [
      (check.nom == null)?"IS null ":"= '${check.nom}'",
    ];
    var res = await db.rawQuery("SELECT * FROM Site WHERE nom ${myVaribles[0]}");

    // var res = await  db.query("Site", where: "nom ${myVaribles[0]} ?", whereArgs: [check.nom]);

    Site? site;
    if((res != null) && (res.isNotEmpty)) {
      site = Site.fromMap(res.first);
    }
    return site;
  }
  Future<Company?> checkCompany(Company check) async {
    final db = await database;


    List<dynamic> myVaribles =[
      (check.nom == null)?"IS null ":"= '${check.nom}'",
      (check.logo == null)?"IS null ":"= '${check.logo}'",
      (check.siteId == null)?"IS null ":"= '${check.siteId}'",
    ];

    var res = await db.rawQuery("SELECT * FROM Company WHERE nom ${myVaribles[0]} and logo ${myVaribles[1]} and siteId ${myVaribles[2]}");

    Company? someth;

    if(res.isNotEmpty) someth = Company.fromMap(res.first);


    return someth;
  }
  Future<StockEntrepot?> checkStockEntrepot(StockEntrepot check) async {
    final db = await database;
    List<dynamic> myVaribles =[
      (check.nom == null)?"IS null ":"= '${check.nom}'",
      (check.companyId == null)?"IS null ":"= '${check.companyId}'",
      (check.directionId == null)?"IS null ":"= '${check.directionId}'",
      (check.directionType == null)?"IS null ":"= '${check.directionType}'",
    ];
    var res = await db.rawQuery("SELECT * FROM StockEntrepot WHERE nom ${myVaribles[0]} and companyId ${myVaribles[1]} and directionId ${myVaribles[2]} and directionType ${myVaribles[3]}");



    StockEntrepot? someth;

    if(res.isNotEmpty) someth = StockEntrepot.fromMap(res.first);


    return someth;
  }
  Future<Emplacement?> checkEmplacement(Emplacement check) async {
    final db = await database;
    List<dynamic> myVaribles =[
      (check.nom == null)?"IS null ":"= '${check.nom}'",
      (check.barCodeEmp == null)?"IS null ":"= '${check.barCodeEmp}'",
      (check.entrepotId == null)?"IS null ":"= '${check.entrepotId}'",
    ];
    var res = await db.rawQuery("SELECT * FROM Emplacement WHERE nom ${myVaribles[0]} and barCodeEmp ${myVaribles[1]} and entrepotId ${myVaribles[2]}");

    Emplacement? someth;

      if(res.isNotEmpty) someth = Emplacement.fromMap(res.first);


    return someth;
  }
  Future<StockSystem?> checkStockSystem(StockSystem check) async {
    final db = await database;
    List<dynamic> myVaribles =[
      (check.emplacementId == null)?"IS null ":"= '${check.emplacementId}'",
      (check.productId == null)?"IS null ":"= '${check.productId}'",
      (check.productLotId == null)?"IS null ":"= '${check.productLotId}'",
      (check.quantity == null)?"IS null ":"= '${check.quantity}'",
    ];
    var res = await db.rawQuery("SELECT * FROM StockSystem WHERE emplacementId ${myVaribles[0]} and productId ${myVaribles[1]} and productLotId ${myVaribles[2]} and quantity ${myVaribles[3]}");

    StockSystem? someth;


      if(res.isNotEmpty) someth = StockSystem.fromMap(res.first);


    return someth;
  }
  Future<ProductCategory?> checkProductCategory(ProductCategory check) async {
    final db = await database;
    List<dynamic> myVaribles =[
      (check.categoryCode == null)?"IS null ":"= '${check.categoryCode}'",
      (check.categoryName == null)?"IS null ":"= '${check.categoryName}'",
      (check.parentId == null)?"IS null ":"= '${check.parentId}'",
      (check.parentPath == null)?"IS null ":"= '${check.parentPath}'",
    ];
    var res = await db.rawQuery("SELECT * FROM ProductCategory WHERE categoryCode ${myVaribles[0]} and categoryName ${myVaribles[1]} and parentId ${myVaribles[2]} and parentPath ${myVaribles[3]}");

    ProductCategory? someth;

    if(res.isNotEmpty) someth = ProductCategory.fromMap(res.first);
    return someth;
  }
  Future<Product?> checkProduct(Product check) async {
    final db = await database;
    List<dynamic> myVaribles =[
      (check.nom == null)?"IS null ":"= '${check.nom}'",
      (check.categoryId == null)?"IS null ":"= '${check.categoryId}'",
      (check.gestionLot == null)?"IS null ":"= '${check.gestionLot}'",
      (check.productCode == null)?"IS null ":"= '${check.productCode}'",
      (check.productType == null)?"IS null ":"= '${check.productType}'",
    ];
    var res = await db.rawQuery("SELECT * FROM Product WHERE nom ${myVaribles[0]} and categoryId ${myVaribles[1]} and gestionLot ${myVaribles[2]} and productCode ${myVaribles[3]} and productType ${myVaribles[4]}");

    Product? someth;


      if(res.isNotEmpty) someth = Product.fromMap(res.first);

    return someth;
  }
  Future<ProductLot?> checkProductLot(ProductLot check) async {
    final db = await database;
    List<dynamic> myVaribles =[
      (check.productId == null)?"IS null ":"= '${check.productId}'",
      (check.immatriculation == null)?"IS null ":"= '${check.immatriculation}'",
      (check.numLot == null)?"IS null ":"= '${check.numLot}'",
      (check.numSerie == null)?"IS null ":"= '${check.numSerie}'",
    ];
    var res = await db.rawQuery("SELECT * FROM ProductLot WHERE productId ${myVaribles[0]} and immatriculation ${myVaribles[1]} and numLot ${myVaribles[2]} and numSerie ${myVaribles[3]}");

    ProductLot? someth;

      if(res.isNotEmpty) someth = ProductLot.fromMap(res.first);

    return someth;
  }


  /* *************************************** */

  /* Get ALL */
  Future<List<Site>> getAllSites() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Site");
    List<Site> list =
    res.isNotEmpty ? res.map((c) => Site.fromMap(c)).toList() : [];
    return list;
  }
  Future<List<Company>> getAllCompanies() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Company");
    List<Company> list =
    res.isNotEmpty ? res.map((c) => Company.fromMap(c)).toList() : [];
    return list;
  }
  Future<List<StockEntrepot>> getAllStockEntrepots() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM StockEntrepot");
    List<StockEntrepot> list =
    res.isNotEmpty ? res.map((c) => StockEntrepot.fromMap(c)).toList() : [];
    return list;
  }
  Future<List<StockEntrepot>> getAllDirections() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM StockEntrepot WHERE directionId IS null");
    List<StockEntrepot> list =
    res.isNotEmpty ? res.map((c) => StockEntrepot.fromMap(c)).toList() : [];
    return list;
  }
  Future<List<StockEntrepot>> getAllServicesById(int id) async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM StockEntrepot WHERE directionId = $id");
    List<StockEntrepot> list =
    res.isNotEmpty ? res.map((c) => StockEntrepot.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<ProductCategory>> getAllProductCategories() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM ProductCategory");
    List<ProductCategory> list =
    res.isNotEmpty ? res.map((c) => ProductCategory.fromMap(c)).toList() : [];
    return list;
  }
  Future<List<Emplacement>> getAllEmplacements() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Emplacement");
    List<Emplacement> list =
    res.isNotEmpty ? res.map((c) => Emplacement.fromMap(c)).toList() : [];
    return list;
  }
  Future<List<StockSystem>> getAllStockSystems() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM StockSystem");
    List<StockSystem> list =
    res.isNotEmpty ? res.map((c) => StockSystem.fromMap(c)).toList() : [];
    return list;
  }
  Future<List<Product>> getAllProducts() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Product");
    List<Product> list =
    res.isNotEmpty ? res.map((c) => Product.fromMap(c)).toList() : [];
    return list;
  }
  Future<List<ProductLot>> getAllProductLots() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM ProductLot");
    List<ProductLot> list =
    res.isNotEmpty ? res.map((c) => ProductLot.fromMap(c)).toList() : [];
    return list;
  }


  Future<List<Inventory>> getAllInventories() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Inventory");
    List<Inventory> list =
    res.isNotEmpty ? res.map((c) => Inventory.fromMap(c)).toList() : [];
    return list;
  }
  Future<List<InventoryLine>> getAllInventoryLines(int? idInv) async {
    final db = await database;
    var res = (idInv !=null) ? (await db.query("InventoryLine", where: "inventoryId = ?", whereArgs: [idInv]) ) : (await db.rawQuery("SELECT * FROM InventoryLine WHERE inventoryId IS null"));
    List<InventoryLine> list =
    res.isNotEmpty ? res.map((c) => InventoryLine.fromMap(c)).toList() : [];
    return list;
  }



  Future<List<Company>> getAllCompaniesBySite(int? idSite) async {
    final db = await database;
    var res = (idSite !=null) ? (await db.query("Company", where: "siteId = ?", whereArgs: [idSite]) ) :
    (await db.rawQuery("SELECT * FROM Company WHERE siteId IS null"));
    
    List<Company> list = res.isNotEmpty ? res.map((c) => Company.fromMap(c)).toList() : [];
    return list;
  }
  Future<List<StockEntrepot>> getAllDirectionByCompany(int? idCompany) async {
    final db = await database;
    var res = (idCompany !=null) ?  (await db.rawQuery("SELECT * FROM StockEntrepot WHERE companyId = $idCompany and directionId IS null")):
    (await db.rawQuery("SELECT * FROM StockEntrepot WHERE companyId IS null and directionId IS null"));

    List<StockEntrepot> list = res.isNotEmpty ? res.map((c) => StockEntrepot.fromMap(c)).toList() : [];
    return list;
  }
  Future<List<StockEntrepot>> getAllServiceByDirection(int? idDirection) async {
    final db = await database;
    var res = (idDirection !=null) ?  (await db.rawQuery("SELECT * FROM StockEntrepot WHERE directionId = $idDirection")):
    (await db.rawQuery("SELECT * FROM StockEntrepot WHERE directionId IS null"));

    List<StockEntrepot> list = res.isNotEmpty ? res.map((c) => StockEntrepot.fromMap(c)).toList() : [];
    return list;
  }
  Future<List<StockEntrepot>> getAllServicesByCompany(int? idCompany) async {
    final db = await database;
    var res = (idCompany !=null) ?  (await db.rawQuery("SELECT * FROM StockEntrepot WHERE companyId = $idCompany")):
    (await db.rawQuery("SELECT * FROM StockEntrepot WHERE companyId IS null"));

    List<StockEntrepot> list = res.isNotEmpty ? res.map((c) => StockEntrepot.fromMap(c)).toList() : [];
    return list;
  }
  Future<List<Emplacement>> getAllEmplacementByService(int? idService) async {
    final db = await database;
    var res = (idService !=null) ?  (await db.rawQuery("SELECT * FROM Emplacement WHERE entrepotId = $idService")):
    (await db.rawQuery("SELECT * FROM Emplacement WHERE entrepotId IS null"));

    List<Emplacement> list = res.isNotEmpty ? res.map((c) => Emplacement.fromMap(c)).toList() : [];
    return list;
  }
  Future<List<StockSystem>> getAllStocksByEmplacement(int? idEmplacement) async {
    final db = await database;
    var res = (idEmplacement !=null) ?  (await db.rawQuery("SELECT * FROM StockSystem WHERE emplacementId = $idEmplacement")):
    (await db.rawQuery("SELECT * FROM StockSystem WHERE emplacementId IS null"));

    List<StockSystem> list = res.isNotEmpty ? res.map((c) => StockSystem.fromMap(c)).toList() : [];
    return list;
  }



  /*UPdate  **********************************************************************************/
  updateUser(User newUser) async {
    final db = await database;
   var res = await db.update("User", newUser.toMap(), where: "id = ?", whereArgs: [newUser.id]);

    print("== res ==");
    print(res);

    return res;
  }
  updateInventory(Inventory inv)async{
    final db = await database;
    var res = await db.update("Inventory", inv.toMap(),
        where: "id = ?", whereArgs: [inv.id]);
    return res;
  }

  /* reset inventory */
  Future<void> resetInventory(Inventory inv) async {
    final db = await database;
    inv.openingDate = DateTime.now().toIso8601String();
    inv.closeDate = DateTime(2000,1,1).toIso8601String();
    inv.status = "begin";

    db.delete("InventoryLine", where: "inventoryId = ?", whereArgs: [inv.id]);

  }
/* *Search *********************************************************************** */
  Future<List<ProductLot>> getAllSearchs(String? search) async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM ProductLot WHERE numLot LIKE '%$search%'");
    List<ProductLot> list =
    res.isNotEmpty ? res.map((c) => ProductLot.fromMap(c)).toList() : [];
    return list;
  }

  Future<Emplacement?> scanEmplacement(String theScan)async{
    final db = await database;
    var res =await  db.query("Emplacement", where: "barCodeEmp = ?", whereArgs: [theScan]);
    Emplacement? one;
    if(res.isNotEmpty) one = Emplacement.fromMap(res.first);
    return one;
  }

  Future<ProductLot?> scanByBarCode(String barCode)async{
    final db = await database;
    var res =await  db.query("ProductLot", where: "numLot = ?", whereArgs: [barCode]);
    ProductLot? one;
    if(res.isNotEmpty) one = ProductLot.fromMap(res.first);
    return one;
  }

}


