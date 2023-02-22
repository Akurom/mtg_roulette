

import 'package:flutter/material.dart';

class DamageSnackModel extends ChangeNotifier {

  bool _display = false;
  int _count = 0;

  bool get display => _display;
  int get count => _count;

  void toogleDisplay() {
    _display = !_display;
    notifyListeners();
  }

  void updateCount(int newCount) {
    _count = newCount;
    notifyListeners();
  }
}