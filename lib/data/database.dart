import 'dart:io';


import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scanapp/models/database_models/Companies.dart';
import 'package:scanapp/models/database_models/counter_stocks_in_emplacement.dart';
import 'package:scanapp/models/database_models/emplacements.dart';
import 'package:scanapp/models/database_models/inventories.dart';
import 'package:scanapp/models/database_models/inventory_lines.dart';
import 'package:scanapp/models/database_models/product_categories.dart';
import 'package:scanapp/models/database_models/product_lots.dart';
import 'package:scanapp/models/database_models/products.dart';
import 'package:scanapp/models/database_models/sites.dart';
import 'package:scanapp/models/database_models/stock_entrepots.dart';
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
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "scanApp.db");
    return await openDatabase(path, version: 1,
        onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE User ("
              "id INTEGER PRIMARY KEY,"
              "allStocks INTEGER,"
              "logoName TEXT,"
              "logoImage TEXT,"

              "phoneEnterprise TEXT,"
              "addressEnterprise TEXT,"
              "adminPassword TEXT,"

              "userPasswordReset TEXT,"
              "userPasswordActually TEXT,"
              "stateUser TEXT,"
              "sitesTable TEXT,"

              "companyTable TEXT,"
              "stockEnterpriseTable TEXT,"
              "stockSystemTable TEXT,"
              "bureauxTable TEXT,"

              "produitsTable TEXT,"
              "categoriesTable TEXT,"
              "productLotsTable TEXT"
              ")");
          await db.insert("User", {
            "id":1,
            "allStocks":0,
            "logoName":"Empty",
            "logoImage":"Empty",
            "phoneEnterprise":"Empty",

            "addressEnterprise":"Empty",
            "adminPassword":"123456",
            "userPasswordReset":"123456",

            "userPasswordActually":"123456",
            "stateUser":"Client",
            "sitesTable":"Empty",
            "companyTable":"Empty",

            "stockEnterpriseTable":"Empty",
            "stockSystemTable":"Empty",
            "bureauxTable":"Empty",

            "produitsTable":"Empty",
            "categoriesTable":"Empty",
            "productLotsTable":"Empty",

          });


          await db.execute("CREATE TABLE Site ("
              "id INTEGER PRIMARY KEY,"
              "nom TEXT"
              ")");
          await db.execute("CREATE TABLE Company ("
              "id INTEGER PRIMARY KEY,"
              "nom TEXT,"
              "siteId INTEGER,"
              "logo TEXT"
              ")");
          await db.execute("CREATE TABLE StockEntrepot ("
              "id INTEGER PRIMARY KEY,"
              "nom TEXT,"
              "companyId INTEGER,"
              "directionType TEXT,"
              "directionId INTEGER"
              ")");
          await db.execute("CREATE TABLE StockSystem ("
              "id INTEGER PRIMARY KEY,"
              "productId INTEGER,"
              "productLotId INTEGER,"
              "emplacementId INTEGER,"
              "quantity INTEGER"
              ")");
          await db.execute("CREATE TABLE Emplacement ("
              "id INTEGER PRIMARY KEY,"
              "nom TEXT,"
              "entrepotId INTEGER,"
              "barCodeEmp TEXT"
              ")");
          await db.execute("CREATE TABLE Product ("
              "id INTEGER PRIMARY KEY,"
              "nom TEXT,"
              "productCode TEXT,"
              "categoryId INTEGER,"
              "gestionLot TEXT,"
              "productType TEXT"
              ")");
          await db.execute("CREATE TABLE ProductCategory ("
              "id INTEGER PRIMARY KEY,"
              "categoryName TEXT,"
              "categoryCode TEXT,"
              "parentId INTEGER,"
              "parentPath TEXT"
              ")");
          await db.execute("CREATE TABLE ProductLot ("
              "id INTEGER PRIMARY KEY,"
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
  /* Insert */
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
  newProductCategory(ProductCategory newProductCategory) async {
    final db = await database;
    var res = await db.insert("ProductCategory", newProductCategory.toMap());
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
  Future<Emplacement?> getEmplacement(int id) async {
    final db = await database;
    var res =await  db.query("Emplacement", where: "id = ?", whereArgs: [id]);
    Emplacement? one;
    if(res.isNotEmpty) one = Emplacement.fromMap(res.first);
    return one;
  }
  Future<StockSystem?> getStockSystem(int id) async {
    final db = await database;
    var res =await  db.query("StockSystem", where: "id = ?", whereArgs: [id]);
    StockSystem? one;
    if(res.isNotEmpty) one = StockSystem.fromMap(res.first);
    return one;
  }
  Future<Product?> getProduct(int id) async {
    final db = await database;
    var res =await  db.query("Product", where: "id = ?", whereArgs: [id]);
    Product? one;
    if(res.isNotEmpty) one = Product.fromMap(res.first);
    return one;
  }
  Future<ProductLot?> getProductLot(int id) async {
    final db = await database;
    var res =await  db.query("ProductLot", where: "id = ?", whereArgs: [id]);
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
    var res = await db.rawQuery("SELECT  emplacementId,COUNT(id) FROM StockSystem GROUP BY emplacementId");
    List<StocksCounter> list =
    res.isNotEmpty ? res.map((c) => StocksCounter.fromMap(c)).toList() : [];

    if(list.isNotEmpty){

      for(int i =0 ; i< list.length; i++){

        await db.insert("StocksCounter", list[i].toMap());
      }

    }
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
    var res = await db.rawQuery("SELECT * FROM StockSystem WHERE emplacementId ${myVaribles[0]} and productId ${myVaribles[1]} and quantity ${myVaribles[2]}");

    StockSystem? someth;


      if(res.isNotEmpty) someth = StockSystem.fromMap(res.first);


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
  Future<List<ProductCategory>> getAllProductCategories() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM ProductCategory");
    List<ProductCategory> list =
    res.isNotEmpty ? res.map((c) => ProductCategory.fromMap(c)).toList() : [];
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
    var res = await db.query("InventoryLine", where: "inventoryId = ?", whereArgs: [idInv]);
    List<InventoryLine> list =
    res.isNotEmpty ? res.map((c) => InventoryLine.fromMap(c)).toList() : [];
    return list;
  }

  /*UPdate */
  updateUser(User newUser) async {
    final db = await database;
    var res = await db.update("User", newUser.toMap(),
        where: "id = ?", whereArgs: [newUser.id]);
    return res;
  }
  updateInventory(Inventory inv)async{
    final db = await database;
    var res = await db.update("Inventory", inv.toMap(),
        where: "id = ?", whereArgs: [inv.id]);
    return res;
  }

  Future<void> resetInventory(Inventory inv) async {
    final db = await database;
    inv.openingDate = DateTime.now().toIso8601String();
    inv.closeDate = DateTime(2000,1,1).toIso8601String();
    inv.status = "begin";

    var res = await db.update("Inventory", inv.toMap(),
        where: "id = ?", whereArgs: [inv.id]);

    db.delete("InventoryLine", where: "inventoryId = ?", whereArgs: [inv.id]);

  }

}



/*

//insert new task
  newTask(Task newTask) async {
    final db = await database;
    var res = await db.insert("Task", newTask.toMap());
    return res;
  }

//get all tasks  with category
  Future<List<Task>> getCategory(String category) async {
    final db = await database;
    var res = await db.query("Task", where: "category = ?", whereArgs: [category]);
    List<Task> list =
    res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Map<dynamic, dynamic>>> getCategories() async {
    final db = await database;
    var res = await db.rawQuery("SELECT COUNT(category), category FROM Task GROUP BY category");
    List<Map<dynamic, dynamic>> list =
    res.isNotEmpty ? res.toList() : [];
    return list;
  }

  //get all tasks with search by task name
  Future<List<Task>> getAllSearch(String taskSearch) async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Task WHERE task LIKE '%$taskSearch%'");
    List<Task> list =
    res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
    return list;
  }

//get all tasks
  Future<List<Task>> getAllTask() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Task  ORDER BY status asc");
    //db.query("Task",orderBy: "status asc");
    List<Task> list =
    res.isNotEmpty ? res.map((c) => Task.fromMap(c)).toList() : [];
    return list;
  }
//update task
  updateTask(Task newTask) async {
    final db = await database;
    var res = await db.update("Task", newTask.toMap(),
        where: "id = ?", whereArgs: [newTask.id]);
    return res;
  }

  // delete task
  deleteTask(int id) async {
    final db = await database;
    db.delete("Task", where: "id = ?", whereArgs: [id]);
  }

// delete all
  deleteAll() async {
    final db = await database;
    //db.rawDelete("Delete * from History");
    try{

      await db.transaction((txn) async {
        var batch = txn.batch();
        batch.delete("Task");
        await batch.commit();
      });
    } catch(error){
      throw Exception('DbBase.cleanDatabase: ' + error.toString());
    }
  }


*/

