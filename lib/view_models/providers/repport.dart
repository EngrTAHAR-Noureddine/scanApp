import 'package:flutter/material.dart';

class RepportProvider extends ChangeNotifier{

  static RepportProvider? _instance;
  RepportProvider._();
  factory RepportProvider() => _instance ??=RepportProvider._();





}
