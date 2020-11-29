import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Bookmark with ChangeNotifier {
  var ind = 0;

  void proceed(int inde) {
    notifyListeners();
  }

  int value() {
    notifyListeners();
    return ind;
  }
}
