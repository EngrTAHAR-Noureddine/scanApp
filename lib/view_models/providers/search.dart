import 'package:flutter/material.dart';
import 'package:scanapp/data/database.dart';
import 'package:scanapp/models/database_models/product_lots.dart';

class SearchProvider extends ChangeNotifier{

  static SearchProvider? _instance;
  SearchProvider._();
  factory SearchProvider() => _instance ??=SearchProvider._();

  String? searchItem;

  void onSearch(value){
    searchItem=value.toString();
    notifyListeners();
  }

  Future<List<ProductLot>> getList()async{
    List<ProductLot> list =(searchItem != null )? await DBProvider.db.getAllSearchs(searchItem):[];
    return list;
  }




}
