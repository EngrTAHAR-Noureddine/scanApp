import 'package:flutter/material.dart';
import 'package:scanapp/data/database.dart';
import 'package:scanapp/models/database_models/company.dart';
import 'package:scanapp/models/database_models/counter_stocks_in_emplacement.dart';
import 'package:scanapp/models/database_models/emplacements.dart';
import 'package:scanapp/models/database_models/site.dart';
import 'package:scanapp/models/database_models/stock_entre_pot.dart';
import 'package:scanapp/models/database_models/user.dart';
import 'package:scanapp/view_models/providers/main.dart';

class Item{
  String? lookingFor;
  String? nameItem;
  int? idParent;
  Item({this.nameItem,this.lookingFor,this.idParent});
}


class ShowCompanyProvider extends ChangeNotifier{


  static ShowCompanyProvider? _instance;
  ShowCompanyProvider._();
  factory ShowCompanyProvider() => _instance ??=ShowCompanyProvider._();

  String chain = ">";
  String localWidget = "Site";

  setState(){notifyListeners();}

  Future<List<Item>> figureSites(User user)async{
    List<Item> itemSite = <Item>[];
    if(user.siteTable!="Empty"){

      List<Site> sites = await DBProvider.db.getAllSites();
      if(sites.isNotEmpty){
        sites.forEach((element) {
          Item item = new Item(lookingFor: "company",nameItem: element.nom,idParent: element.id);
          itemSite.add(item);
        });
      }
    } else if(user.companyTable != "Empty"){
      // Looking in Company
      /* Search for Site from company Table */
      List<StocksCounter> sites = await DBProvider.db.getSiteFromCompany();

      if(sites.isNotEmpty){
        sites.forEach((element) {
          Item item = new Item(lookingFor: "company",nameItem:"Site "+element.emplacementID.toString(),idParent: element.emplacementID);
          itemSite.add(item);
        });
      }
    }
    localWidget = "Site";
    return itemSite.isNotEmpty?itemSite:[];
  }
  Future<List<Item>> figureCompanies(User user)async{
    List<Item> itemCompany  = <Item>[];
    if(user.companyTable != "Empty"){
      // Looking in Company
        List<Company> companies = await DBProvider.db.getAllCompanies();
        if(companies.isNotEmpty){
          companies.forEach((element) {
            Item item = new Item(lookingFor: "direction",nameItem: element.nom,idParent: element.id);
            itemCompany.add(item);
          });
        }
    }else if(user.entrePotTable != "Empty"){
      //Looking For Direction
      /* Search for Companies from direction Table */
      List<StocksCounter> company = await DBProvider.db.getCompaniesFromDirection();
      if(company.isNotEmpty){
        company.forEach((element) {
          Item item = new Item(lookingFor: "direction",nameItem:"Company "+element.emplacementID.toString(),idParent: element.emplacementID);
          itemCompany.add(item);
        });
      }
    }
    localWidget = "Company";
    return itemCompany.isNotEmpty?itemCompany:[];
  }
  Future<List<Item>> figureDirections(User user)async{
    List<Item> itemDirection  = <Item>[];
    if(user.entrePotTable != "Empty"){
      List<StockEntrepot> direction = await DBProvider.db.getAllStockEntrepots();
      if(direction.isNotEmpty){
        direction.forEach((element) {
          Item item = new Item(lookingFor: "service",nameItem: element.directionType,idParent: element.id);
          itemDirection.add(item);
        });
        localWidget = "Direction";
      }else{
        direction = await DBProvider.db.getAllStockEntrepots();
        if(direction.isNotEmpty){
          direction.forEach((element) {
            Item item = new Item(lookingFor: "emplacement",nameItem: element.directionType,idParent: element.id);
            itemDirection.add(item);
          });
          localWidget = "Service";
        }
      }
    }else if(user.emplacementTable != "Empty"){
        //Looking For emplacement
        // Looking For emplacement
        /* Search for Services from emplacement Table */
        List<StocksCounter> services = await DBProvider.db.getSerivcesFromEmplacement();
        if(services.isNotEmpty){
          services.forEach((element) {
            Item item = new Item(lookingFor: "emplacement",nameItem:"Service "+element.emplacementID.toString(),idParent: element.emplacementID);
            itemDirection.add(item);
          });
          localWidget = "Service";
        }
    }


    return itemDirection.isNotEmpty?itemDirection:[];
  }
  Future<List<Item>> figureEmplacements(User user)async{
    List<Item> itemEmplacement = <Item>[];
    if(user.emplacementTable != "Empty"){
      List<Emplacement> emplacement = await DBProvider.db.getAllEmplacements();
      if(emplacement.isNotEmpty){
        emplacement.forEach((element) {
          Item item = new Item(lookingFor: "stockSys",nameItem: element.nom,idParent: element.id);
          itemEmplacement.add(item);
        });
      }
    }else if(user.stockSysTable != "Empty"){
      //Looking For stock sys
      /* Search for Emplacement from stockSys Table */
      List<StocksCounter> emplacement = await DBProvider.db.getEmplFromStockSys();

      if(emplacement.isNotEmpty){
        emplacement.forEach((element) {
          Item item = new Item(lookingFor: "stockSys",nameItem:"Bureau: "+element.emplacementID.toString(),idParent: element.emplacementID);
          itemEmplacement.add(item);
        });
      }

    }
    localWidget = "Bureau";
    return itemEmplacement.isNotEmpty?itemEmplacement : [];
  }

  Future<List<Item>> fetchCompany(User user, int? id)async{
    List<Item> itemCompany  = <Item>[];
    if(user.companyTable != "Empty"){
          List<Company> companies = await DBProvider.db.getAllCompaniesBySite(id);
          if(companies.isNotEmpty){
            companies.forEach((element) {
              Item item = new Item(lookingFor: "direction",nameItem: element.nom,idParent: element.id);
              itemCompany.add(item);
            });
          }
          localWidget = "Company";
    }else{
      itemCompany = await figureCompanies(user);
    }
    return itemCompany.isNotEmpty?itemCompany:[];
  }
  Future<List<Item>> fetchDirection(User user, int? id)async{
    List<Item> itemDirection  = <Item>[];
    if(user.entrePotTable != "Empty"){
      List<StockEntrepot> direction = await DBProvider.db.getAllDirectionByCompany(id);
      if(direction.isNotEmpty){
        direction.forEach((element) {
          Item item = new Item(lookingFor: "service",nameItem: element.directionType,idParent: element.id);
          itemDirection.add(item);
        });
        localWidget = "Direction";
      }else{
        List<StockEntrepot> direction = await DBProvider.db.getAllServicesByCompany(id);
        if(direction.isNotEmpty){
          direction.forEach((element) {
            Item item = new Item(lookingFor: "emplacement",nameItem: element.directionType,idParent: element.id);
            itemDirection.add(item);
          });
        }
        localWidget = "Service";
      }
    }else{
      itemDirection = await figureDirections(user);
    }

    return itemDirection.isNotEmpty?itemDirection:[];
  }
  Future<List<Item>> fetchService(User user, int? id)async{
    List<Item> itemServices  = <Item>[];
    if(user.entrePotTable != "Empty"){
      List<StockEntrepot> services = await DBProvider.db.getAllServiceByDirection(id);
      if(services.isNotEmpty){
        services.forEach((element) {
          Item item = new Item(lookingFor: "emplacement",nameItem: element.directionType,idParent: element.id);
          itemServices.add(item);
        });
        localWidget = "Service";
      }
    }else {
      itemServices  = await figureEmplacements(user);
    }
    return itemServices.isNotEmpty?itemServices:[];
  }
  Future<List<Item>> fetchEmplacement(User user, int? id)async{
    List<Item> itemEmplacement = <Item>[];

    if(user.emplacementTable != "Empty"){
      List<Emplacement> emplacement = await DBProvider.db.getAllEmplacementByService(id);
      if(emplacement.isNotEmpty){
        emplacement.forEach((element) {
          Item item = new Item(lookingFor: "stockSys",nameItem: element.nom,idParent: element.id);
          itemEmplacement.add(item);
        });
      }
      localWidget = "Bureau";
    }else{
      itemEmplacement = await figureEmplacements(user);
    }


    return itemEmplacement.isNotEmpty?itemEmplacement : [];
  }

  Future<List<Item>> fetchTables({lookingFor,id})async{
      User? user = await MainProvider().getUser();
      List<Item> items = <Item>[];

  if(lookingFor != null){
    if(user != null){
      switch(lookingFor){
        case "company" : items = await fetchCompany(user,id);
                            if(items.isEmpty)continue nextDirection;else break;
        nextDirection:case "direction" : items = await fetchDirection(user,id);
                            if(items.isEmpty)continue nextService;else break;
        nextService: case "service" :  items = await fetchService(user,id);
                            if(items.isEmpty)continue nextEmplacement;else break;
        nextEmplacement: case "emplacement" : items = await fetchEmplacement(user,id);
                            if(items.isEmpty)continue nextDefault;else break;
        nextDefault: default : items =[]; break;
      }
    }else items=[];

  }else{
    if(user!=null){
      /* Search for Site from its Table */
      items = await figureSites(user);

      if(items.isEmpty){
        items = await figureCompanies(user);
        if(items.isEmpty){
          items = await figureDirections(user);
          if(items.isEmpty){
            items = await figureEmplacements(user);
          }
        }
      }

    /*
      if(user.siteTable!="Empty" || user.companyTable != "Empty"){
        items = await figureSites(user);
      }
      else if(user.companyTable != "Empty"||user.entrePotTable != "Empty"){
        items = await figureCompanies(user);
      }
        else if(user.entrePotTable != "Empty" || user.emplacementTable != "Empty"){
          items = await figureDirections(user);
      }
      else if(user.emplacementTable != "Empty" || user.stockSysTable != "Empty"){
         items = await figureEmplacements(user);
            }
      */


    }else items=[];

  }
        return items.isNotEmpty?items:[];
    
  }





}




