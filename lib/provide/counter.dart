import 'package:flutter/material.dart';

class Counter with ChangeNotifier{
  int value = 0;
  increment(){
    value++;
    //通知观察者
    notifyListeners();
  }
}