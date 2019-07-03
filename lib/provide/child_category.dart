import 'package:flutter/material.dart';
import '../model/category.dart';
class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> chilCategoryList = [];
  int childIndex = 0; //子类高亮索引
  String categoryId = "4"; //大类ID
  String subId = ''; //小类ID
  int page = 1; // 列表页数
  String noMoreText = "";
  setChildCategory(List<BxMallSubDto> list,String categoryId){
    page = 1;
    noMoreText="";
    childIndex = 0;//点击大类切换时候更改为0
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

  //改变子类索引
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