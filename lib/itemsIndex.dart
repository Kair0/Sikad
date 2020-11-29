import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemsIndex with ChangeNotifier {
  var ind = 0;
  void zero() {
    ind = 0;
  }

  void equate(int inde) {
    print(ind);
    ind = inde;
    print(ind);

    notifyListeners();
  }

  int value() {
    notifyListeners();
    return ind;
  }
}
