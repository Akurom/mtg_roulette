

import 'package:flutter/material.dart';

class MenuModel extends ChangeNotifier {

  bool _isOpen = false;
  bool _isReady = true;

  bool _isPicking = false;

  bool get isOpen => _isOpen;
  bool get isReady => _isReady;
  bool get isPicking => _isPicking;

  void togglePicking() {
    _isPicking = ! _isPicking;
  }

  void toggleReady() {
    _isReady = ! _isReady;
    notifyListeners();
  }

  void set ready(bool ready) {
    _isReady = ready;
    notifyListeners();
  }

  void toggleMenu() {
    _isOpen = !_isOpen;
    notifyListeners();
  }
}