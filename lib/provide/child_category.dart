import 'package:flutter/material.dart';
import '../model/category.dart';
class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> chilCategoryList = [];
  int childIndex = 0; 
  String categoryId = "4"; 
  String subId = '';
  int page = 1; 
  String noMoreText = "";
  setChildCategory(List<BxMallSubDto> list,String categoryId){
    page = 1;
    noMoreText="";
    childIndex = 0;
    BxMallSubDto all = BxMallSubDto();
    all.mallCategoryId="";
    all.comments = "null";
    all.mallCategoryId="00";
    all.mallSubName="全部";
    chilCategoryList = [all];
    chilCategoryList.addAll(list);
    // chilCategoryList = list;
    notifyListeners();
  }

  changeChildIndex(index,String id){
      page = 1;
    noMoreText="";
    childIndex = index;
    subId = id;
    notifyListeners();
  }
  addPage(){
    page++;
  }

  changeNoMore(String text){
    noMoreText = text;
    notifyListeners();
  }
}