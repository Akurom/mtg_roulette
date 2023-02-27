
import 'package:flutter/material.dart';


class CounterModel extends ChangeNotifier {

  int _count;

  CounterModel({int? initial}): _count = initial ?? 0;

  int get count => _count;

  void updateCount(int newCount) {
    _count = newCount;
    notifyListeners();
  }
}