import 'package:flutter/material.dart';
import '../model/category.dart';
class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> chilCategoryList = [];

  setChildCategory(List<BxMallSubDto> list){
    BxMallSubDto all = BxMallSubDto();
    all.mallCategoryId="00";
    all.comments = "null";
    all.mallCategoryId="00";
    all.mallSubName="全部";
    chilCategoryList = [all];
    chilCategoryList.addAll(list);
    // chilCategoryList = list;
    notifyListeners();
  }
}