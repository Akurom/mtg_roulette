import 'package:flutter/material.dart';


class DialerModel extends ChangeNotifier {

  int _count;
  String strCount = "";

  DialerModel({int? initial}): _count = initial ?? 0;

  int get count => _count;

  void updateCount(int newCount) {
    _count = newCount;
    notifyListeners();
  }

  void addDigitToRight(String digit) {

  }
}