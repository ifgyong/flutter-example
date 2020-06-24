import 'package:flutter/cupertino.dart';

class Counter extends ChangeNotifier {
  int index = 0;
  void add() {
    index += 1;
    notifyListeners();
  }

  void changeValue(int index) {
    this.index = index;
    notifyListeners();
  }
}

class CounterValue extends ChangeNotifier {
  int _index = 0;
  int get value => _index;
  void add() {
    _index += 2;
    notifyListeners();
  }
}

class CounterValue2 extends ChangeNotifier {
  int _index = 0;
  int get value => _index;
  void add() {
    _index += 2;
    notifyListeners();
  }
}
