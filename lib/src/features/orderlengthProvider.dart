import 'package:flutter/material.dart';

class OrderLengthNotifier extends ChangeNotifier {
  int _orderLength = 0;

  int get orderLength => _orderLength;

  void setOrderLength(int length) {
    _orderLength = length;
    notifyListeners();
  }
}
