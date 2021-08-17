import 'package:flutter/material.dart';

class ListItemsProvider extends ChangeNotifier{

  static final ListItemsProvider _singleton = ListItemsProvider._internal();
  factory ListItemsProvider() {
    return _singleton;
  }
  ListItemsProvider._internal();



}
