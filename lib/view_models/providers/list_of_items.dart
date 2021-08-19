import 'package:flutter/material.dart';

class ListItemsProvider extends ChangeNotifier{

  static ListItemsProvider? _instance;
  ListItemsProvider._();
  factory ListItemsProvider() => _instance ??=ListItemsProvider._();



}
