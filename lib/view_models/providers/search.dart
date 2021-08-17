import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier{

  static final SearchProvider _singleton = SearchProvider._internal();
  factory SearchProvider() {
    return _singleton;
  }
  SearchProvider._internal();



}
