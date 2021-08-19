import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier{

  static SearchProvider? _instance;
  SearchProvider._();
  factory SearchProvider() => _instance ??=SearchProvider._();




}
