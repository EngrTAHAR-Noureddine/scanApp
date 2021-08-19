import 'package:flutter/material.dart';

class ExportProvider extends ChangeNotifier{
  static ExportProvider? _instance;
  ExportProvider._();
  factory ExportProvider() => _instance ??=ExportProvider._();



}
