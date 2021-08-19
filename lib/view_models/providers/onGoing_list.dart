import 'package:flutter/material.dart';

class OnGoingListProvider extends ChangeNotifier{

  static OnGoingListProvider? _instance;
  OnGoingListProvider._();
  factory OnGoingListProvider() => _instance ??=OnGoingListProvider._();



}
