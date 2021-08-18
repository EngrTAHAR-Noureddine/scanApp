import 'dart:io';


import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    // ignore: unnecessary_null_comparison
    if (_database != null)
      return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }


  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "ToDoListDB.db");
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
              "checkingFile TEXT,"
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

            "allStocks":0,
            "logoName":"Empty",
            "logoImage":"Empty",
            "phoneEnterprise":"Empty",

            "addressEnterprise":"Empty",
            "checkingFile":"Empty",
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
        });
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

