import 'package:flutter/material.dart';

class ExportProvider extends ChangeNotifier{

  static final ExportProvider _singleton = ExportProvider._internal();
  factory ExportProvider() {
    return _singleton;
  }
  ExportProvider._internal();



}
