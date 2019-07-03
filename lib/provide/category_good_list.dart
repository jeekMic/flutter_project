import 'package:flutter/material.dart';
import '../model/categoryGoodList.dart';
class CategoryGoodsListProvide with ChangeNotifier{
  List<CategroyData> goodList = [];
    setGoodList(List<CategroyData> list){
     goodList=list;
     notifyListeners();
  }
    setGoodListFirst(List<CategroyData> list){
     goodList.addAll(list);
     notifyListeners();
  }
}