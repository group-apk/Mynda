import 'package:flutter/material.dart';

class DashboardProvider with ChangeNotifier {
  int index = 0;

  set setIndex(int index) {
    this.index = index;
    notifyListeners();
  }
}
